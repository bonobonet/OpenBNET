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

public class Server
{
    private string name;
    private string sid;

    private this()
    {

    }


    public static Server fromJSON(JSONValue jsonIn)
    {
        Server server = new Server();

        server.name = jsonIn["name"].str();
        server.sid = jsonIn["id"].str();



        return server;
    }
}