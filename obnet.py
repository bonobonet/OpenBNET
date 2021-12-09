"""
OpenBNET

A simple web service that provides insight into the BonoboNET network
"""

from json.encoder import JSONEncoder
from json.decoder import JSONDecoder
from typing import Protocol
from flask import Flask, render_template
from flask.helpers import send_file
from socket import AddressFamily, SocketKind, socket

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

@app.route("/", methods=["GET"])
def home():
    global netInfo
    global servers

    "TODO: Fetch new servers here"
    servers=fetchServers()

    return render_template("index.html", **netInfo, servers=servers)

@app.route("/assets/<file>", methods=["GET"])
def assets(file):
    return send_file(file)

"Returns a list of servers"
def fetchServers():
    servers=["lockdown.bnet", "reddawn648.bnet", "sparrow.bnet"]


    fetchJSON("1")

    return servers

"Fetches the JSON from the server"
def fetchJSON(unixPath):
    try:
        "Assuming it is never bigger than a certain size"
        sock=socket(AddressFamily.AF_UNIX, SocketKind.SOCK_RAW)
        sock.connect(unixPath)
        bData=sock.recv(4096)
        sock.close()

        strData=bData.decode()
        jsonData=json.loads(strData)
    except:
        return None