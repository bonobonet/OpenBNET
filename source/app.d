import std.stdio;

import vibe.d;

void main()
{
	writeln("Edit source/app.d to start your project.");

	HTTPServerSettings httpSettings = new HTTPServerSettings();
	httpSettings.bindAddress = ["::"];
	httpSettings.bindPort = 8002;

	runApplication();
}
