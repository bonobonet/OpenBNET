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

string serverList = `
{
  "jsonrpc": "2.0",
  "method": "server.list",
  "id": 123,
  "result": {
    "list": [
      {
        "name": "reddawn648.bnet",
        "id": "065",
        "hostname": "255.255.255.255",
        "ip": null,
        "details": "reddawn648.bnet",
        "server": {
          "info": "Reddawn's Brackenfell BNET IRC Server",
          "uplink": "braveheart.bnet",
          "num_users": 3,
          "boot_time": "2023-03-19T20:35:18.000Z",
          "synced": true,
          "ulined": false,
          "features": {
            "software": "UnrealIRCd-6.0.7-git-56478f04a",
            "protocol": 6000,
            "usermodes": "diopqrstwxzBDGHIRSTWZ",
            "chanmodes": [
              "beI",
              "fkL",
              "lH",
              "cdimnprstzCDGKMNOPQRSTVZ"
            ]
          }
        },
        "tls": {
          "certfp": "b4581758e2f32eb67ffc8b1821820e4ff287b31cd6096df08f6d5ba6c9b196a8",
          "cipher": "TLSv1.3-TLS_CHACHA20_POLY1305_SHA256"
        }
      },
      {
        "name": "braveheart.bnet",
        "id": "009",
        "hostname": "300:7232:2b0e:d6e9:216:3eff:fe3c:c82b",
        "ip": "300:7232:2b0e:d6e9:216:3eff:fe3c:c82b",
        "details": "braveheart.bnet@300:7232:2b0e:d6e9:216:3eff:fe3c:c82b",
        "connected_since": "2023-03-20T11:26:51.000Z",
        "idle_since": "2023-03-20T11:26:51.000Z",
        "server": {
          "info": "Official Bri'ish Scones&Tea BNET",
          "uplink": "worcester.bnet",
          "num_users": 6,
          "boot_time": "2023-03-19T19:50:15.000Z",
          "synced": true,
          "ulined": false,
          "features": {
            "software": "UnrealIRCd-6.0.3-git",
            "protocol": 6000,
            "usermodes": "diopqrstwxzBDGHIRSTWZ",
            "chanmodes": [
              "beI",
              "fkL",
              "lH",
              "cdimnprstzCDGKMNOPQRSTVZ"
            ]
          }
        },
        "tls": {
          "certfp": "0c88acd563e696fbdaffd65c8ca9a8606442db3ca3ca3900fa6d36321b8ca87f",
          "cipher": "TLSv1.3-TLS_CHACHA20_POLY1305_SHA256"
        }
      },
      {
        "name": "worcester.bnet",
        "id": "011",
        "hostname": "255.255.255.255",
        "ip": null,
        "client_port": 6667,
        "details": "worcester.bnet",
        "connected_since": "2023-03-20T10:41:08.000Z",
        "server": {
          "info": "Deavmi's Worcester Node",
          "num_users": 7,
          "boot_time": "2023-03-20T10:41:08.000Z",
          "features": {
            "software": "UnrealIRCd-6.0.7-git-e4571a5bf",
            "protocol": 6000,
            "usermodes": "diopqrstwxzBDGHIRSTWZ",
            "chanmodes": [
              "beI",
              "fkL",
              "lH",
              "cdimnprstzCDGKMNOPQRSTVZ"
            ],
            "rpc_modules": [
              {
                "name": "rpc",
                "version": "1.0.2"
              },
              {
                "name": "stats",
                "version": "1.0.0"
              },
              {
                "name": "user",
                "version": "1.0.5"
              },
              {
                "name": "server",
                "version": "1.0.0"
              },
              {
                "name": "channel",
                "version": "1.0.4"
              },
              {
                "name": "server_ban",
                "version": "1.0.3"
              },
              {
                "name": "server_ban_exception",
                "version": "1.0.1"
              },
              {
                "name": "name_ban",
                "version": "1.0.1"
              },
              {
                "name": "spamfilter",
                "version": "1.0.3"
              }
            ]
          }
        }
      }
    ]
  }
}

`;



string channelInfo = `

{
  "jsonrpc": "2.0",
  "method": "channel.get",
  "id": 123,
  "result": {
    "channel": {
      "name": "#general",
      "creation_time": "2023-03-19T18:19:29.000Z",
      "num_users": 15,
      "modes": "nt",
      "bans": [],
      "ban_exemptions": [],
      "invite_exceptions": [],
      "members": [
        {
          "name": "anontor",
          "id": "009TJE7B2"
        },
        {
          "name": "Nikat",
          "id": "065JAHE3U"
        },
        {
          "name": "zh",
          "id": "0111ID0LO"
        }
      ]
      }
    }
}
`;


string stats_get = `
{
  "jsonrpc": "2.0",
  "method": "stats.get",
  "id": 123,
  "result": {
    "server": {
      "total": 4,
      "ulined": 0
    },
    "user": {
      "total": 18,
      "ulined": 0,
      "oper": 1,
      "record": 22
    },
    "channel": {
      "total": 31
    },
    "server_ban": {
      "total": 11,
      "server_ban": 3,
      "spamfilter": 0,
      "name_ban": 7,
      "server_ban_exception": 1
    }
  }
}
`;