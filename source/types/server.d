module types.server;

import std.json;

// version(unittest)
// {
    import std.stdio;
    import testInputs : serverList;
// }

public Server[] getDummyServers()
{
    JSONValue rcpDataIn = parseJSON(serverList);

    Server[] servers;
    foreach(JSONValue curServer; rcpDataIn["result"]["list"].array())
    {
        servers ~= Server.fromJSON(curServer);
    }

    return servers;
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

    private string software;
    private long protocol;


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
        if("uplinkServer" in serverBlock.object())
        {
            server.uplinkServer = serverBlock["uplink"].str();
        }
        server.num_users = serverBlock["num_users"].integer();

        // Strip off the .XXXZ
        string bootTime = serverBlock["boot_time"].str();
        long dotPos = indexOf(bootTime, ".");
        bootTime = bootTime[0..dotPos];
        server.boot_time = DateTime.fromISOExtString(bootTime);
        if("synced" in serverBlock.object())
        {
            server.synced = serverBlock["synced"].boolean();
        }
        if("ulined" in serverBlock.object())
        {
            server.ulined = serverBlock["ulined"].boolean();
        }

        /* Extract all information from the `feature {}` block within the `server {}` block */
        JSONValue featureBlock = serverBlock["features"];
        server.software = featureBlock["software"].str();
        server.protocol = featureBlock["protocol"].integer();
        


        return server;
    }

    public string getName()
    {
        return name;
    }

    public string getSID()
    {
        return sid;
    }

    public string getHostname()
    {
        return hostname;
    }

    public string getDetails()
    {
        return details;
    }

    public long getUserCount()
    {
        return num_users;
    }

    public string getInfo()
    {
        return infoString;
    }

    public string getUplink()
    {
        return uplinkServer;
    }

    public DateTime getBootTime()
    {
        return boot_time;
    }

    public bool getSynced()
    {
        return synced;
    }

    public bool getUlined()
    {
        return ulined;
    }

    public string getSoftware()
    {
        return software;
    }

    public long getProtocol()
    {
        return protocol;
    }
}