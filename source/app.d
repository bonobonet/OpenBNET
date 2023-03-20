import std.stdio;

// import vibe.d;

// TODO: Make configurable via environment variab;e
string rpcEndpoint = "https://apiuser:password@127.0.0.1:8001/api";

import std.net.curl;
 

// void homeHandler(HTTPServerRequest req, HTTPServerResponse resp)
// {
	

// 	resp.writeBody("Hello");
// }

void main()
{
	writeln("Edit source/app.d to start your project.");

	auto resp = get(rpcEndpoint);
	writeln(resp);
	

	// HTTPServerSettings httpSettings = new HTTPServerSettings();
	// httpSettings.bindAddresses = ["::"];
	// httpSettings.port = 8002;

	// URLRouter router = new URLRouter();

	// router.get("/", &homeHandler);

	// listenHTTP(httpSettings, router);

	// runApplication();
}
