import std.stdio;

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


void channelListHandler(HTTPServerRequest req, HTTPServerResponse resp)
{
	// TODO: Add actual channel fetch here
	import types.channel;
	Channel[] channels = getDummyChannels();


	Network network = new Network();
	resp.render!("channels.dt", network, channels);
}

void channelInfoHandler(HTTPServerRequest req, HTTPServerResponse resp)
{
	/* Extract the parameters */
	auto params = req.params;

	/* Extract name parameter */
	if(params.get("name") !is null)
	{
		string channelName = params["name"];
	}
	/* If not found, throw an error */
	else
	{
		throw new HTTPStatusException(HTTPStatus.badRequest, "Missing channel name parameter");
	}

	// TODO: Ensure we have a "name" parameter, if not throw an HTTP error
}

void homeHandler(HTTPServerRequest req, HTTPServerResponse resp)
{
	

	resp.writeBody("Hello");
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

	// Setup serving of static files
	router.get("/assets/table.css", serveStaticFile("assets/table.css"));
	router.get("/assets/open_bnet_banner.png", serveStaticFile("assets/open_bnet_banner.png"));

	listenHTTP(httpSettings, router);

	runApplication();
}
