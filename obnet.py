#!/usr/bin/python3

"""
OpenBNET

A simple web service that provides insight into the BonoboNET network
"""

import csv
import datetime as dt
import gzip
import io
import json
import os
import queue
import sys
import threading
import time
from os import environ as env
from os.path import join as path_join
from socket import AddressFamily, SocketKind, socket
from threading import Lock

# Graph related tooling
import matplotlib.pyplot as plt
import seaborn
# Flask
from flask import Flask, Response, abort, render_template
from flask.helpers import send_file
from genericpath import isfile

# Initialize seaborn
seaborn.set_theme()

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

# Logging path
LOGGING_PATH = "assets/logging.csv.gz"


def block_until_file_exists(fname):
    while not os.path.isfile(fname):
        time.sleep(0.5)
    return True


class FetchJSON:
    def __init__(self, unix_path, expires_after=30):
        self.unix_path = unix_path
        self.json_data = None
        self.expires_after = expires_after
        self.last_update = -self.expires_after - 1
        self.lock = Lock()

        # For logging and (to later) avoid reploting
        self.logging_dates = []
        self.channels = []
        self.clients = []
        self.operators = []
        self.messages = []

        # Run background thread
        self._thread_kill = queue.Queue()
        self._thread = threading.Thread(target=self.fetch_json_autoupdater)
        self._thread.start()

    def close_thread(self):
        self._thread_kill.put(True)
        self._thread.join()

    def fetch_json_autoupdater(self):
        while True:
            try:
                self._thread_kill.get_nowait()
                return
            except queue.Empty:
                pass

            if time.perf_counter() - self.last_update > self.expires_after:
                self.get()

            time.sleep(0.5)

    def get(self):
        if self.unix_path is None:
            print("Bruh")
            return None

        with self.lock:
            # return cached copy if threshold to update wasn't passed
            if time.perf_counter() - self.last_update < self.expires_after:
                print("fok")
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
                self.last_update = time.perf_counter()

                current_time = time.mktime(time.gmtime())
                with gzip.open(LOGGING_PATH, "a") as file:
                    writer = csv.writer(
                        io.TextIOWrapper(file, newline="", write_through=True)
                    )
                    writer.writerow(
                        [
                            current_time,
                            json_data["channels"],
                            json_data["clients"],
                            json_data["operators"],
                            json_data["messages"],
                        ]
                    )

                seaborn.set_theme()
                if len(self.logging_dates) == 0:
                    with gzip.open(LOGGING_PATH, "r") as file:
                        reader = csv.reader(io.TextIOWrapper(file, newline=""))
                        for row in reader:
                            self.logging_dates.append(
                                dt.datetime.fromtimestamp(float(row[0]))
                            )
                            self.channels.append(row[1])
                            self.clients.append(row[2])
                            self.operators.append(row[3])
                            self.messages.append(row[4])
                else:
                    self.logging_dates.append(dt.datetime.fromtimestamp(current_time))
                    self.channels.append(json_data["channels"])
                    self.clients.append(json_data["clients"])
                    self.operators.append(json_data["operators"])
                    self.messages.append(json_data["messages"])

                plt.cla()
                plt.clf()
                plt.xlim(left=self.logging_dates[0], right=self.logging_dates[-1])
                plt.plot(self.logging_dates, self.channels, label="channels")
                plt.xlabel("Time")
                plt.ylabel("Number")
                plt.savefig("assets/channels_graph.WORKING.svg")
                block_until_file_exists("assets/channels_graph.WORKING.svg")
                os.rename(
                    "assets/channels_graph.WORKING.svg", "assets/channels_graph.svg"
                )

                plt.cla()
                plt.clf()
                plt.xlim(left=self.logging_dates[0], right=self.logging_dates[-1])
                plt.plot(self.logging_dates, self.clients, label="clients")
                plt.xlabel("Time")
                plt.ylabel("Number")
                plt.savefig("assets/clients_graph.WORKING.svg")
                block_until_file_exists("assets/clients_graph.WORKING.svg")
                os.rename(
                    "assets/clients_graph.WORKING.svg", "assets/clients_graph.svg"
                )

                plt.cla()
                plt.clf()
                plt.xlim(left=self.logging_dates[0], right=self.logging_dates[-1])
                plt.plot(self.logging_dates, self.operators, label="operators")
                plt.xlabel("Time")
                plt.ylabel("Number")
                plt.savefig("assets/operators_graph.WORKING.svg")
                block_until_file_exists("assets/operators_graph.WORKING.svg")
                os.rename(
                    "assets/operators_graph.WORKING.svg", "assets/operators_graph.svg"
                )

                plt.cla()
                plt.clf()
                plt.xlim(left=self.logging_dates[0], right=self.logging_dates[-1])
                plt.plot(self.logging_dates, self.messages, label="messages")
                plt.xlabel("Time")
                plt.ylabel("Number")
                plt.savefig("assets/messages_graph.WORKING.svg")
                block_until_file_exists("assets/messages_graph.WORKING.svg")
                os.rename(
                    "assets/messages_graph.WORKING.svg", "assets/messages_graph.svg"
                )

                return json_data
            except Exception:
                self.json_data = None
                self.last_update = time.perf_counter()
                raise


FETCH_JSON = FetchJSON(UNREAL_SOCKET_PATH)


@app.route("/", methods=["GET"])
def home():
    # Fetch the information form unrealircd socket
    json_data = FETCH_JSON.get()

    # Grab servers
    if json_data is None:
        print("json_data is: %s" % json_data)
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


@app.route("/graphs", methods=["GET"])
def graphs():
    return render_template("graphs.html", **NET_INFO)


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
