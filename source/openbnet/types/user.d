module openbnet.types.user;

import std.datetime.date;
import std.json;

public class User
{
    // TODO: Fields
    private string name, id, hostname, ip;
    private string realname;

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



        return user;
    }

    public string getRealname()
    {
        return realname;
    }

   
}