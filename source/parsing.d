module parsing;

import std.json;

version(unittest)
{
    import std.stdio;
    import testInputs;
}

unittest
{
    
    JSONValue rcpDataIn = parseJSON(channeList);

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
import std.conv : to;

public class Channel
{
    private string name;
    private DateTime creationTime;
    private long userCount;
    private string topic, topicSetBy;
    private DateTime topicSetAt;


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

        channel.userCount = jsonIn["num_users"].integer();

        if("topic" in jsonIn.object())
        {
            channel.topic = jsonIn["topic"].str();
            channel.topicSetBy = jsonIn["topic_set_by"].str();

            // Strip off the .XXXZ
            string topicCreationTimeClean =jsonIn["topic_set_at"].str();
            import std.string;
            dotPos = indexOf(topicCreationTimeClean, ".");
            topicCreationTimeClean = topicCreationTimeClean[0..dotPos];
            channel.topicSetAt = DateTime.fromISOExtString(topicCreationTimeClean);
        }
        
        


        return channel;
    }

    public override string toString()
    {
        return "Channel [name: "~name~
                        ", created: "~creationTime.toString()~
                        ", size: "~to!(string)(userCount)~
                        "]";
    }
}