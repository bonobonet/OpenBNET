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