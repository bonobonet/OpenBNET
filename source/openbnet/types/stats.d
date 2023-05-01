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

        import std.stdio;
        writeln(jsonIn);

        JSONValue serverBlock = jsonIn["server"];
        stats.serverCount = serverBlock["total"].integer();

        JSONValue userBlock = jsonIn["user"];
        stats.userCount = userBlock["total"].integer();

        JSONValue channelBlock = jsonIn["channel"];
        stats.channelCount = channelBlock["total"].integer();

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