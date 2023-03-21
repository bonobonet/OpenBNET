module types.server;

import std.json;

version(unittest)
{
    import std.stdio;
    import testInputs : serverList;
}

unittest
{
    
    JSONValue rcpDataIn = parseJSON(serverList);

    Server[] servers;
    foreach(JSONValue curServer; rcpDataIn["result"]["list"].array())
    {
        servers ~= Server.fromJSON(curServer);
    }
    
    foreach(Server curServer; servers)
    {
        writeln(curServer);
    }
}

import std.datetime.date;
import std.string;

public class Server
{
    private string name;
    private string sid;
    private string hostname; // TODO: MAke an address object
    private string details;


    /* information about this server (link-wise) */
    private string infoString;
    private string uplinkServer;
    private long num_users;
    private DateTime boot_time;
    private bool synced, ulined;

    private string software, protocol;


    private this()
    {

    }

    public static Server fromJSON(JSONValue jsonIn)
    {
        Server server = new Server();

        server.name = jsonIn["name"].str();
        server.sid = jsonIn["id"].str();
        server.hostname = jsonIn["hostname"].str();
        server.details = jsonIn["details"].str();

        /* Extract all information from the `server {}` block */
        JSONValue serverBlock = jsonIn["server"];
        server.infoString = serverBlock["info"].str();
        server.uplinkServer = serverBlock["uplink"].str();
        server.num_users = serverBlock["num_users"].integer();

        // Strip off the .XXXZ
        string bootTime = serverBlock["boot_time"].str();
        long dotPos = indexOf(bootTime, ".");
        bootTime = bootTime[0..dotPos];
        server.boot_time = DateTime.fromISOExtString(bootTime);

        server.synced = serverBlock["synced"].boolean();
        server.ulined = serverBlock["ulined"].boolean();

        /* Extract all information from the `feature {}` block within the `server {}` block */
        JSONValue featureBlock = serverBlock["features"];
        server.software = featureBlock["software"].str();
        server.protocol = featureBlock["protocol"].str();
        


        return server;
    }
}