import std.stdio;

import vibe.d;

// TODO: Make configurable via environment variab;e
string rpcEndpoint = "https://apiuser:password@127.0.0.1:8001/api";

import std.net.curl;

public class Network
{
	public string name;
	public string logo;
}

// TODO: A fetch channel should populate with users list inside it


void channelListHandler(HTTPServerRequest req, HTTPServerResponse resp)
{
	// TODO: Add actual channel fetch here
	import types.channel;
	Channel[] channels = getDummyChannels();


	Network network = new Network();
	resp.render!("channels.dt", network, channels);
}

void homeHandler(HTTPServerRequest req, HTTPServerResponse resp)
{
	

	resp.writeBody("Hello");
}

void main()
{
	writeln("Edit source/app.d to start your project.");

	// auto resp = get(rpcEndpoint);
	// writeln(resp);
	

	HTTPServerSettings httpSettings = new HTTPServerSettings();
	httpSettings.bindAddresses = ["::"];
	httpSettings.port = 8002;

	URLRouter router = new URLRouter();

	router.get("/", &homeHandler);
	router.get("/channels", &channelListHandler);

	listenHTTP(httpSettings, router);

	runApplication();
}
