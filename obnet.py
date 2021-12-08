"""
OpenBNET

A simple web service that provides insight into the BonoboNET network
"""

from flask import Flask, render_template
from flask.helpers import send_file

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

@app.route("/", methods=["GET"])
def home():
    global netInfo
    return render_template("index.html", **netInfo)

@app.route("/assets/<file>", methods=["GET"])
def assets(file):
    return send_file(file)
