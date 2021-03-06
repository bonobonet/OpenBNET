#!/usr/bin/python3

"""
OpenBNET

A simple web service that provides insight into the BonoboNET network
"""

import json
import sys
import time
from os import environ as env
from os.path import join as path_join
from socket import AddressFamily, SocketKind, socket
from threading import Lock

from flask import Flask, abort, render_template, Response
from flask.helpers import send_file

# Setup the flask instance
app = Flask(__name__)

# Network information
NET_INFO = {
    "networkName": "OpenBonobo",
    "description": "Network statistics for the BonoboNET network",
    "networkLogo": "open_bnet_banner.png",
}

# Socket for unrealircd
UNREAL_SOCKET_PATH = "/tmp/openbnet.sock"


class FetchJSON:
    def __init__(self, unix_path, expires_after=60):
        self.unix_path = unix_path
        self.json_data = None
        self.expires_after = expires_after
        self.last_update = -self.expires_after - 1
        self.lock = Lock()

    def get(self):
        if self.unix_path is None:
            return None

        with self.lock:
            if time.time() - self.last_update < self.expires_after:
                return self.json_data

            try:
                # Assuming it is never bigger than a certain size
                sock = socket(AddressFamily.AF_UNIX, SocketKind.SOCK_STREAM)
                sock.connect(self.unix_path)
                bytes_recv = sock.recv(4096)
                sock.close()

                str_data = bytes_recv.decode()
                json_data = json.loads(str_data)

                self.json_data = json_data
                self.last_update = time.time()

                return json_data
            except Exception as exception:
                print(exception)

                self.json_data = None
                self.last_update = time.time()

                return None


FETCH_JSON = FetchJSON(None)


@app.route("/", methods=["GET"])
def home():
    # Fetch the information form unrealircd socket
    json_data = FETCH_JSON.get()

    # Grab servers
    if json_data is None:
        abort(Response(response="Error whilst contacting the IRC daemon", status=404))

    # Grab general info
    network_state = {}
    network_state["channels"] = json_data["channels"]
    network_state["clients"] = json_data["clients"]
    network_state["operators"] = json_data["operators"]
    network_state["messages"] = json_data["messages"]

    return render_template(
        "index.html", **NET_INFO, servers=json_data["serv"], **network_state
    )


@app.route("/channels", methods=["GET"])
def channels_direciory():
    # Fetch the information form unrealircd socket
    json_data = FETCH_JSON.get()

    # Grab servers
    if json_data is None:
        abort(Response(response="Error whilst contacting the IRC daemon", status=404))

    return render_template("channels.html", **NET_INFO, channels=json_data["chan"])


@app.route("/raw", methods=["GET"])
def raw():
    raw_data = FETCH_JSON.get()
    return render_template("raw.html", raw=raw_data, **NET_INFO)


@app.route("/assets/<file>", methods=["GET"])
def assets(file):
    file = file.replace("..", "")
    file = file.replace("/", "")
    return send_file(path_join("assets", file))


@app.route("/api", methods=["GET"])
def api():
    data = FETCH_JSON.get()
    return data


@app.errorhandler(Exception)
def handle_exception(code):
    """
    Handles all errors
    """
    return render_template("error.html", **NET_INFO, code=code)


def init():
    """
    Starts the server

    Args:
        None

    Returns:
        None
    """
    try:
        bind_addr = str(env["OPENBNET_BIND_ADDR"])
    except KeyError:
        bind_addr = "::"

    try:
        bind_port = int(env["OPENBNET_BIND_PORT"])
    except (KeyError, ValueError):
        bind_port = 8081

    try:
        global UNREAL_SOCKET_PATH
        UNREAL_SOCKET_PATH = str(env["UNREAL_SOCKET_PATH"])
    except KeyError:
        pass

    global FETCH_JSON
    FETCH_JSON = FetchJSON(UNREAL_SOCKET_PATH)

    try:
        # Start flask
        app.run(host=bind_addr, port=bind_port)
    except Exception as exception:
        print(
            f"Could not start OpenBONOBO: {exception.__class__.__name__} - {exception}"
        )
        sys.exit(1)


if __name__ == "__main__":
    # Start OBNET
    init()
