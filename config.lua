-- Configuration file for the switch board
local conf = {}

-- Configuration for the switches
-- Each switch can have:
--      id - the id for the switch
--      pin - the pin to use for GPIO
--      state - the default value for the state of the switch (1 = on, 0 = off)
conf.switches = {
    ['02'] = { pin = 1 },
    ['96'] = { pin = 2 },
    ['97'] = { pin = 3 },
    ['40'] = { pin = 4 },
    ['4f'] = { pin = 5 },
    ['ed'] = { pin = 6 },
    ['1c'] = { pin = 7 },
    ['26'] = { pin = 0 }
}

conf.ID_LENGTH = 2

-- Configuration for wireless access point (hotspot)
conf.ap = {
    ssid = 'some ssid',
    pwd = 'some password'
}

-- Configuration for http server
conf.server = {
    port = 80
}

conf.dns = {
    hostname = 'switchboard',
    options = {
        description = 'A switchboard',
        service = 'http',
        port = '80',
        location = 'My room'
    }
}

return conf;
