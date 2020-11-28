-- Configuration file for the switch board
local conf = {}

-- Configuration for the switches
-- Each switch can have:
--      id - the id for the switch
--      pin - the pin to use for GPIO
--      state - the default value for the state of the switch (1 = on, 0 = off)
conf.switches = {
    ['00'] = { pin = 1 },
    ['01'] = { pin = 2 },
    ['02'] = { pin = 3 },
    ['03'] = { pin = 4 },
    ['04'] = { pin = 5 },
    ['05'] = { pin = 6 },
    ['06'] = { pin = 7 },
    ['07'] = { pin = 0 }
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
