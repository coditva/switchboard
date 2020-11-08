local switch = {}

config = require("config")

-- multiple inits will retain state because config is cached and so is
-- config.states
local switches = config.switches

local function init_switch (id)
    print("Init GPIO" .. config.switches[id].pin .. " for switch " .. id)

    gpio.mode(switches[id].pin, gpio.OUTPUT)
    switch.set_state(id, switches[id].state)
end

function switch.get_state (id)
    return switches[id].state
end

function switch.set_state (id, state)
    state = state and 1 or 0
    gpio_state = state == 1 and gpio.HIGH or gpio.LOW

    gpio.write(switches[id].pin, gpio_state)
    switches[id].state = state
end

function switch.toggle_state (id)
    if switch.get_state(id) == 1 then
        switch.set_state(id, 0)
    else
        switch.set_state(id, 1)
    end
end

function switch.is_present (id)
    return switches[id] ~= nil
end

print('Init switches')
for id in pairs(switches) do
    print('Init switch ' .. id)
    init_switch(id)
    print('--')
end

-- export the switch controller
return switch
