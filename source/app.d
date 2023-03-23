import std.stdio;

// TODO: Import gogga and use it for logging

import gogga;

private GoggaLogger logger;

static this()
{
	logger = new GoggaLogger();
	logger.enableDebug();

	version(release)
	{
		logger.disableDebug();
	}
}
import vibe.d;

// TODO: Make configurable via environment variab;e
string rpcEndpoint = "https://apiuser:password@127.0.0.1:8001/api";

// import std.net.curl;

public class Network
{
	public string name;
	public string logo;
}

// TODO: A fetch channel should populate with users list inside it

import types.channel;

void channelListHandler(HTTPServerRequest req, HTTPServerResponse resp)
{
	// TODO: Add actual channel fetch here
	Channel[] channels = getDummyChannels();

	// TODO: Add actual network here
	Network network = new Network();

	resp.render!("channels.dt", network, channels);
}

import types.server;

void serverListHandler(HTTPServerRequest req, HTTPServerResponse resp)
{
	// TODO: Add actual channel fetch here
	Server[] servers = getDummyServers();

	// TODO: Add actual network here
	Network network = new Network();

	resp.render!("servers.dt", network, servers);
}

void channelInfoHandler(HTTPServerRequest req, HTTPServerResponse resp)
{
	// TODO: Add actual network here
	Network network = new Network();

	/* Extract the parameters */
	auto params = req.query;

	logger.debug_(params);

	/* Extract name parameter */
	if(params.get("name") !is null) // TODO: Ensure channel name is not empty string
	{
		/* Extract the channel name */
		string channelName = strip(params["name"]);

		

		/* Fetch the channel info */
		ChannelInfo channelInfo = getDummyChannelInfo(channelName);


		resp.render!("channelinfo.dt", channelInfo, network);

	}
	/* If not found, throw an error */
	else
	{
		logger.error("The channel name parameter is not present");
		throw new HTTPStatusException(HTTPStatus.badRequest, "Missing channel name parameter");
	}

	// TODO: Ensure we have a "name" parameter, if not throw an HTTP error
}

void homeHandler(HTTPServerRequest req, HTTPServerResponse resp)
{
	// TODO: Add actual network here
	Network network = new Network();

	resp.render!("home.dt", network);
}

void errorHandler(HTTPServerRequest req, HTTPServerResponse resp, HTTPServerErrorInfo error)
{
	// TODO: FInish error page
	Network network = new Network();

	auto request = req;
	resp.render!("error.dt", error, request, network);
}

void main()
{
	writeln("Edit source/app.d to start your project.");

	// auto resp = get(rpcEndpoint);
	// writeln(resp);
	

	HTTPServerSettings httpSettings = new HTTPServerSettings();
	httpSettings.bindAddresses = ["::"];
	httpSettings.port = 8002;

	import std.functional : toDelegate;
	httpSettings.errorPageHandler = toDelegate(&errorHandler);

	URLRouter router = new URLRouter();

	router.get("/", &homeHandler);
	router.get("/channels", &channelListHandler);
	router.get("/channelinfo", &channelInfoHandler);
	router.get("/servers", &serverListHandler);

	// Setup serving of static files
	router.get("/assets/table.css", serveStaticFile("assets/table.css"));
	router.get("/assets/open_bnet_banner.png", serveStaticFile("assets/open_bnet_banner.png"));

	listenHTTP(httpSettings, router);

	runApplication();
}
