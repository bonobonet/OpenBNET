module openbnet.types.user;

import std.datetime.date;
import std.json;

public class User
{
    // TODO: Fields
    private string name, id, hostname, ip;
    private string realname, vhost;

    private long clientPort, serverPort;
    private DateTime connectedSince, idleSince;
    


    private this() {}

    public static User fromJSON(JSONValue jsonIn)
    {
        User user = new User();

        user.name = jsonIn["name"].str();
        user.id = jsonIn["id"].str();
        user.hostname = jsonIn["hostname"].str();
        
        user.ip = jsonIn["ip"].str();


        JSONValue userBlock = jsonIn["user"];
        user.realname = userBlock["realname"].str();
        user.vhost = userBlock["vhost"].str();



        return user;
    }

    public string getRealname()
    {
        return realname;
    }

    public string getNick()
    {
        return name;
    }

    public string getIP()
    {
        return ip;
    }

    public string getHostname()
    {
        return hostname;
    }

    public string getVHost()
    {
        return vhost;
    }

   
}