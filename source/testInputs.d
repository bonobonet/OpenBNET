module testInputs;

import std.json;

string channeList = `
{
  "jsonrpc": "2.0",
  "method": "channel.list",
  "id": 123,
  "result": {
    "list": [
      {
        "name": "#ccc",
        "creation_time": "2023-03-19T18:19:30.000Z",
        "num_users": 4,
        "modes": "nt"
      },
      {
        "name": "#gaming",
        "creation_time": "2023-03-19T19:50:26.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#network",
        "creation_time": "2023-03-19T19:50:28.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#club45",
        "creation_time": "2023-03-19T19:50:55.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#Gentoousers",
        "creation_time": "2023-03-19T19:52:32.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#blngqisstoopid",
        "creation_time": "2023-03-19T19:52:32.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#openbsd",
        "creation_time": "2023-03-19T19:52:32.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#bnetr",
        "creation_time": "2023-03-19T20:36:15.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#chris",
        "creation_time": "2023-03-19T20:36:15.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#rednet",
        "creation_time": "2023-03-19T20:36:15.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#dsource",
        "creation_time": "2023-03-20T11:26:52.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#llcn",
        "creation_time": "2023-03-20T11:26:52.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#birchwood2",
        "creation_time": "2023-03-20T11:26:52.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#birchwoodLeave3",
        "creation_time": "2023-03-20T11:26:52.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#birchwoodLeave2",
        "creation_time": "2023-03-20T11:26:52.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#birchwoodLeave1",
        "creation_time": "2023-03-20T11:26:52.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#general",
        "creation_time": "2023-03-19T18:19:29.000Z",
        "num_users": 13,
        "modes": "nt"
      },
      {
        "name": "#1",
        "creation_time": "2023-03-20T10:41:16.000Z",
        "num_users": 2,
        "modes": "nt"
      },
      {
        "name": "#yggdrasil",
        "creation_time": "2023-03-19T18:19:50.000Z",
        "num_users": 10,
        "modes": "nst"
      },
      {
        "name": "#birchwood",
        "creation_time": "2023-03-20T10:41:16.000Z",
        "num_users": 3,
        "modes": "nt"
      },
      {
        "name": "#ukru",
        "creation_time": "2023-03-19T19:50:36.000Z",
        "num_users": 2,
        "modes": "nt"
      },
      {
        "name": "#bnet",
        "creation_time": "2023-03-19T18:19:30.000Z",
        "num_users": 4,
        "modes": "nt"
      },
      {
        "name": "#help",
        "creation_time": "2023-03-20T10:41:16.000Z",
        "num_users": 2,
        "modes": "nt"
      },
      {
        "name": "#crxn",
        "creation_time": "2023-03-19T18:19:30.000Z",
        "num_users": 8,
        "modes": "nt"
      },
      {
        "name": "#programming",
        "creation_time": "2023-03-19T18:19:29.000Z",
        "num_users": 9,
        "modes": "nt"
      },
      {
        "name": "#networking",
        "creation_time": "2023-03-19T19:50:29.000Z",
        "num_users": 8,
        "modes": "nt"
      },
      {
        "name": "#linux",
        "creation_time": "2023-03-19T19:50:29.000Z",
        "num_users": 4,
        "modes": "nt"
      },
      {
        "name": "#chaox",
        "creation_time": "2023-03-20T10:41:16.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#fauna",
        "creation_time": "2023-03-19T18:21:13.000Z",
        "num_users": 3,
        "modes": "nt"
      },
      {
        "name": "#politics",
        "creation_time": "2023-03-19T18:21:13.000Z",
        "num_users": 4,
        "modes": "nt"
      },
      {
        "name": "#i2pd",
        "creation_time": "2023-03-19T19:50:26.000Z",
        "num_users": 8,
        "modes": "nt"
      },
      {
        "name": "#tlang",
        "creation_time": "2023-03-19T18:21:13.000Z",
        "num_users": 4,
        "modes": "nt"
      },
      {
        "name": "#dn42",
        "creation_time": "2023-03-20T10:41:16.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#lokinet",
        "creation_time": "2023-03-19T19:50:29.000Z",
        "num_users": 4,
        "modes": "nt"
      },
      {
        "name": "#popura",
        "creation_time": "2023-03-20T10:41:16.000Z",
        "num_users": 1,
        "modes": "nt"
      },
      {
        "name": "#opers",
        "creation_time": "2021-02-26T19:07:17.000Z",
        "num_users": 1,
        "topic": "🔑️ BNET Operators | Official operators channel for BNET IRC Network | Hub migration stats: https://pad.riseup.net/p/0DW9YWWKiuwOPFgFkClM-keep",
        "topic_set_by": "rany",
        "topic_set_at": "2022-10-18T18:37:19.000Z",
        "modes": "instHP 200:7d"
      }
    ]
  }
}`;