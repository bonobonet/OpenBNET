module types.channel;

import std.json;

version(unittest)
{
    // import std.stdio;
    // import testInputs : channeList;
}

import std.stdio;
import testInputs : channeList;

public Channel[] getDummyChannels()
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

    return channels;
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
    private string modes;

    // TODO: add getters for the fields above

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
        
        channel.modes = jsonIn["modes"].str();


        return channel;
    }

    // TODO: Finish implementing this
    public override string toString()
    {
        return "Channel [name: "~name~
                        ", created: "~creationTime.toString()~
                        ", size: "~to!(string)(userCount)~
                        "]";
    }

    public string getName()
    {
        return name;
    }

    public string getModes()
    {
        return modes;
    }

    public long getUsers()
    {
        return userCount;
    }

    public string getTopic()
    {
        return topic;
    }

    public DateTime getCreationTime()
    {
        return creationTime;
    }
}


unittest
{
    JSONValue rcpDataIn = parseJSON(channelInfo);

    ChannelInfo channelInfo = ChannelInfo.fromJSON(rcpDataIn["result"]["channel"]);
}


public ChannelInfo getDummyChannelInfo(string channelName)
{
    import testInputs : channelInfoTest = channelInfo;
    JSONValue rcpDataIn = parseJSON(channelInfoTest);

    ChannelInfo channelInfo = ChannelInfo.fromJSON(rcpDataIn["result"]["channel"]);

    return channelInfo;
}

/** 
 * Represents information that is retrived via `channel.get`
 * which means that this contains more in-depth information
 * for the given channel
 */
public class ChannelInfo
{
    public struct MemberInfo
    {
        public string name;
        public string id;
    }

    private string[] bans;
    private string[] banExemptions;
    private string[] inviteExceptions;
    private MemberInfo[] members;

    private this()
    {

    }

    public static ChannelInfo fromJSON(JSONValue jsonIn)
    {
        ChannelInfo channelInfo = new ChannelInfo();



        return channelInfo;
    }
}