import std.stdio;

import vibe.d;

void homeHandler(HTTPServerRequest req, HTTPServerResponse resp)
{
	resp.writeBody("Hello");
}

void main()
{
	writeln("Edit source/app.d to start your project.");

	HTTPServerSettings httpSettings = new HTTPServerSettings();
	httpSettings.bindAddress = ["::"];
	httpSettings.bindPort = 8002;

	URLRouter router = new URLRouter();

	router.get("/", &homeHandler);

	listenHTTP(router, httpSettings);

	runApplication();
}
