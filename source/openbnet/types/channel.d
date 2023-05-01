module openbnet.types.channel;

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
    import testInputs : channelInfoTest = channelInfo;
    
    JSONValue rcpDataIn = parseJSON(channelInfoTest);

    ChannelInfo channelInfo = ChannelInfo.fromJSON(rcpDataIn["result"]["channel"]);
}


public ChannelInfo getDummyChannelInfo(string channelName)
{
    import testInputs : channelInfoTest = channelInfo;
    JSONValue rcpDataIn = parseJSON(channelInfoTest);

    ChannelInfo channelInfo = ChannelInfo.fromJSON(rcpDataIn["result"]["channel"]);

    return channelInfo;
}

public class MemberInfo
{
    private string name;
    private string id;

   
    private this()
    {

    }
    
    

    public static MemberInfo fromJSON(JSONValue jsonIn)
    {
        MemberInfo info = new MemberInfo();

        info.name = jsonIn["name"].str();
        info.id = jsonIn["id"].str();

        return info;
    }

    public string getName()
    {
        return name;
    }

    public string getID()
    {
        return id;
    }

    public override string toString()
    {
        return name~" ("~id~")";
    }
}

/** 
 * Represents information that is retrived via `channel.get`
 * which means that this contains more in-depth information
 * for the given channel
 */
public class ChannelInfo
{
    

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

        /* Parse bans array */
        JSONValue[] bansJSON = jsonIn["bans"].array();
        foreach(JSONValue curBan; bansJSON)
        {
            channelInfo.bans ~= curBan.str();
        }

        /* Parse ban exemptions array */
        JSONValue[] banExemptionsJSON = jsonIn["ban_exemptions"].array();
        foreach(JSONValue curBan; banExemptionsJSON)
        {
            channelInfo.banExemptions ~= curBan.str();
        }

        /* Parse invite exceptions array */
        JSONValue[] inviteExceptionsJSON = jsonIn["invite_exceptions"].array();
        foreach(JSONValue curInviteException; inviteExceptionsJSON)
        {
            channelInfo.inviteExceptions ~= curInviteException.str();
        }

        JSONValue[] membersInfoJSON = jsonIn["members"].array();
        foreach(JSONValue curMemberInfo; membersInfoJSON)
        {
            channelInfo.members ~= MemberInfo.fromJSON(curMemberInfo);
        }

        return channelInfo;
    }

    public string[] getBans()
    {
        return bans;
    }

    public string[] getBanExemptions()
    {
        return banExemptions;
    }

    public string[] getInviteExceptions()
    {
        return inviteExceptions;
    }

    public MemberInfo[] getMembers()
    {
        return members;
    }
}
