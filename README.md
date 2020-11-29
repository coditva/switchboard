# switchboard
A wifi switchboard based on NodeMCU (ESP8266)

## Usage
Wire up GPIO pins of NodeMCU D0 to D7 to relay module inputs.
Change `config.lua` to configure the switch names, access point SSID and password and local hostname.
Upload the files to NodeMCU flash and start it up!

If everything goes well, you should see an access point available with the SSID you configured. There will be a server available which provides this API:

#### `GET` 192.168.4.1
Returns the status of the device:
```json
{
    "status": "ok"
}
```

#### `GET` 192.168.4.1/:id
Returns the state of the switch wired to the pin corresponding to the `id` (as specified in `config.lua`).

```json
{
    "state": 0
}
```

#### `POST` 192.168.4.1/:id
Toggles the state of the switch wired to the pin corresponding to the `id` (as specified in `config.lua`).
```json
{
    "state": 1
}
```

**Note: You can also use `http://switchboard.local` (or whatever hostname you configured in `config.lua`) in place of `192.168.4.1`.**
