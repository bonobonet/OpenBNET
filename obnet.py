#!/usr/bin/python3

"""
OpenBNET

A simple web service that provides insight into the BonoboNET network
"""

import json
from typing import Protocol
from flask import Flask, render_template
from flask.helpers import send_file
from socket import AddressFamily, SocketKind, socket, IPPROTO_NONE

"Setup the flask instance"
app=Flask(__name__)

"Network information"
netInfo={
    "networkName": "OpenBonobo",
    "description": "Network statistics for the BonoboNET network",
    "networkLogo": "open_bnet_banner.png"
}

"TODO: Fetch json"
"TODO: asset handler"
"TODO: Custom error pages"

"Last server fetch"
servers=[]

"Socket for unrealircd"
sock=None
unrealSocketPath="/tmp/openbnet.sock"

@app.route("/", methods=["GET"])
def home():
    global netInfo
    global servers

    "Fetch the information form unrealircd socket"
    jsonData=fetchJSON(unrealSocketPath)

    "TODO: Handle None returned on error"

    "Grab servers"
    servers=jsonData["serv"]

    "Grab general info"
    networkState = {}
    networkState["channels"] = jsonData["channels"]
    networkState["clients"] = jsonData["clients"]
    networkState["operators"] = jsonData["operators"]
    networkState["messages"] = jsonData["messages"]

    return render_template("index.html", **netInfo, servers=servers, **networkState)

@app.route("/raw", methods=["GET"])
def raw():
    raw=fetchJSON(unrealSocketPath)
    return render_template("raw.html", raw=raw, **netInfo)

@app.route("/assets/<file>", methods=["GET"])
def assets(file):
    return send_file(file)

@app.route("/api", methods=["GET"])
def api():
    data=fetchJSON(unrealSocketPath)
    return data

"Fetches the JSON from the server"
def fetchJSON(unixPath):
    try:
        "Assuming it is never bigger than a certain size"
        sock=socket(AddressFamily.AF_UNIX, SocketKind.SOCK_STREAM)
        sock.connect(unixPath)
        bData=sock.recv(4096)
        sock.close()

        strData=bData.decode()
        jsonData=json.loads(strData)

        return jsonData
    except Exception as e:
        print(e)
        return None

"Error handler for 404"
@app.errorhandler(Exception)
def notFoundHandler():
    retur  render_template("404.html", **netInfo)

"Start the process"
def init():
    "TODO: Please add support here to get environment variables to fill up netInfo"
    "TODO: Please add support here to set the bind host and port"
    bindAddr="::"
    bindPort=8081

    "TODO: Add env support for setting `unrealSocketPath`"

    try:
        "Start flask"
        app.run(host=bindAddr, port=bindPort)
    except:
        print("Couldn't start OpenBonobo")

"Start OBNET"
init()