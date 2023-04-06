<center>

![](assets/open_bnet_banner.png)
 
# OpenBNET

Lightweight web interface and API endpoint for the [`JSON RPC`](https://www.unrealircd.org/docs/JSON-RPC) unrealircd module.

</center>

---

## Screenshots

### Home

Available at `/`:

![](screenshots/home.png)

### Channels directory

Available at `/channels`:

![](screenshots/chan_list.png)

### Raw output

Available at `/raw`:

![](screenshots/raw.png)

### API endpoint

Available at `/api`:

![](screenshots/api.png)

## Setting up

You will need the following and can install them easily:

1. `dmd`
2. `dub`

Visit the [D programming language website](https://dlang.org) for more information on how to install it.

You will need to configure the `JSON RPC` module as well, information on doing so can be found [here](https://deavmi.assigned.network/projects/bonobonet/network/config/monitoring/).

## Usage

Firstly grab all the files in this repository, then:

```
dub build
```

The next thing to do will be to set the following environment variables:

* `RPC_ENDPOINT`
    * The HTTP address to the JSON RPC endpoint

You can then run it like such:

```
RPC_ENDPOINT=https://127.0.0.1:8181 ./obnet
```

### Systemd-unit

There is an example systemd unit file included in the repository as `openbnet.service`

## License

This project uses the [AGPL version 3](https://www.gnu.org/licenses/agpl-3.0.en.html) license.

## Credits

* [`deavmi`](https://github.com/deavmi)
* [`rany2`](http://github.com/rany2)
