#!/usr/bin/python3

"""
OpenBNET

A simple web service that provides insight into the BonoboNET network
"""

import sys
import json
from os import environ as env
from socket import AddressFamily, SocketKind, socket

from flask import Flask, render_template
from flask.helpers import send_file

# Setup the flask instance
app = Flask(__name__)

# Network information
NET_INFO = {
    "networkName": "OpenBonobo",
    "description": "Network statistics for the BonoboNET network",
    "networkLogo": "open_bnet_banner.png",
}

# TODO: Fetch json
# TODO: asset handler
# TODO: Custom error pages

# Last server fetch
SERVERS = []

# Socket for unrealircd
SOCK = None
UNREAL_SOCKET_PATH = "/tmp/openbnet.sock"


def fetch_json(unix_path):
    """
    "Fetches the JSON from the server

    Args:
        unixPath (str): The path to the socket

    Returns:
        dict or None: The JSON data or None if the socket is not available
    """
    try:
        # Assuming it is never bigger than a certain size
        sock = socket(AddressFamily.AF_UNIX, SocketKind.SOCK_STREAM)
        sock.connect(unix_path)
        bytes_recv = sock.recv(4096)
        sock.close()

        str_data = bytes_recv.decode()
        json_data = json.loads(str_data)

        return json_data
    except Exception as exception:
        print(exception)
        return None


@app.route("/", methods=["GET"])
def home():
    global NET_INFO
    global SERVERS

    # Fetch the information form unrealircd socket
    json_data = fetch_json(UNREAL_SOCKET_PATH)

    # Grab servers
    if json_data is not None:
        SERVERS = json_data["servers"]
    else:
        SERVERS = -1
        json_data = {
            "channels": -1,
            "clients": -1,
            "operators": -1,
            "messages": -1,
            "servers": -1,
        }

    # Grab general info
    network_state = {}
    network_state["channels"] = json_data["channels"]
    network_state["clients"] = json_data["clients"]
    network_state["operators"] = json_data["operators"]
    network_state["messages"] = json_data["messages"]

    return render_template("index.html", **NET_INFO, servers=SERVERS, **network_state)


@app.route("/raw", methods=["GET"])
def raw():
    raw_data = fetch_json(UNREAL_SOCKET_PATH)
    return render_template("raw.html", raw=raw_data, **NET_INFO)


@app.route("/assets/<file>", methods=["GET"])
def assets(file):
    return send_file(file)


@app.route("/api", methods=["GET"])
def api():
    data = fetch_json(UNREAL_SOCKET_PATH)
    return data

"Error handler for 404"
@app.errorhandler(Exception)
def notFoundHandler():
    return render_template("404.html", **netInfo)

"Start the process"
def init():
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
