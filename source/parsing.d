module parsing;

import std.json;

version(unittest)
{
    import std.stdio;
}

unittest
{
    JSONValue rcpDataIn = parseJSON(
    `
    {
  "jsonrpc": "2.0",
  "method": "channel.list",
  "id": 123,
  "result": {
    "list": [
      {
        "name": "#ccc",
        "creation_time": "2023-03-19T18:19:30.000Z",
        "num_users": 4,
        "modes": "nt"
      },
      {
        "name": "#gaming",
        "creation_time": "2023-03-19T19:50:26.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#network",
        "creation_time": "2023-03-19T19:50:28.000Z",
        "num_users": 1,
        "modes": "nt"
      }
    ]
    }
   }
    `);

    Channel[] channels;
    foreach(JSONValue curChannel; rcpDataIn["result"]["list"].array())
    {
        channels ~= Channel.fromJSON(curChannel);
    }
    
    foreach(Channel curChannel; channels)
    {
        writeln(curChannel);
    }
}

import std.datetime.date;

public class Channel
{
    private string name;
    private DateTime creationTime;

    private this()
    {

    }

    public static Channel fromJSON(JSONValue jsonIn)
    {
        Channel channel = new Channel();

        channel.name = jsonIn["name"].str();


        // Strip off the .XXXZ
        string creationTimeClean =jsonIn["creation_time"].str();
        import std.string;
        long dotPos = indexOf(creationTimeClean, ".");
        creationTimeClean = creationTimeClean[0..dotPos];
        channel.creationTime = DateTime.fromISOExtString(creationTimeClean);


        return channel;
    }

    public override string toString()
    {
        return "Channel [name: "~name~", created: "~creationTime.toString()~"]";
    }
}