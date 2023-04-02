module openbnet.types.stats;

import std.json;
import testInputs;

public Stats getDummyStats()
{
    Stats stats = Stats.fromJSON(JSONValue());


    return stats;
}

public class Stats
{
    private long serverCount, userCount, channelCount;

    private this() {}

    public static Stats fromJSON(JSONValue jsonIn)
    {
        Stats stats = new Stats();

        JSONValue serverBlock = jsonIn["server"];
        serverCount = serverBlock["total"].integer();

        JSONValue userBlock = jsonIn["user"];
        userCount = userBlock["total"].integer();

        JSONValue channelBlock = jsonIn["channel"];
        channelCount = channelBlock["total"].integer();

        // TODO: Add parsing

        return stats;
    }

    public long getServers()
    {
        return serverCount;
    }

    public long getUsers()
    {
        return userCount;
    }

    public long getChannels()
    {
        return channelCount;
    }
}