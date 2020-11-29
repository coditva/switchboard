-- setup wifi
dofile("wireless.lua")

-- setup hostname
dofile("mdns.lua")

socket = require("socket")
switch = require("switch")
config = require("config")

local function truncate_string (s, str)
    _, j = string.find(s, str)

    -- return the string from the start till the character to search
    return s:sub(1, j - 1)
end

local function get_id_from_url (url)
    return url:sub(2, 1 + config.ID_LENGTH)
end

local function handle_get_call (url)
    print("GET ", url)

    if url == "/" then
        return "{\"status\":\"OK\"}"
    end

    id = get_id_from_url(url)

    if switch.is_present(id) then
        return "{\"state\":" .. switch.get_state(id) .. "}"
    end

    return "{\"error\":\"invalid id\"}"
end

local function handle_post_call (url)
    print("POST ", url)

    id = get_id_from_url(url)

    if switch.is_present(id) then
        switch.toggle_state(id)

        return "{\"state\":" .. switch.get_state(id) .. "}"
    end

    return "{\"error\":\"invalid id\"}"
end

local function handle_message (data)
    if not data then
        return
    end

    first_line = truncate_string(data, "\n")

    if first_line == nil then
        return
    end

    iterator = first_line:gmatch("%S+")
    method = string.lower(iterator())
    url = iterator()

    if not method or not url then
        print('invalid method', method)
        return "{\"error\":\"invalid request\"}"
    end

    if method == "get" then
        return handle_get_call(url)
    end

    if method == "post" then
        return handle_post_call(url)
    end

    return "{\"error\":\"invalid method\"}"
end

socket.handle_receive = function (sock, data)
    sock:hold()

    -- if no data was received, unblock socket and try again
    if data == nil then
        sock:unhold()

        return
    end

    -- we're just taking the request line and parsing it because we only need
    -- method and url

    -- TODO: ensure that this chunk of data contains all the required info
    local response = handle_message(data)

    -- if no response is to be sent, it's probably a 404
    if not response then
        sock:send("HTTP/1.1 404\r\n\r\n")
        sock:close()

        return
    end

    sock:send("HTTP/1.1 200 OK\r\n")
    sock:send("content-length: " .. response:len() .. "\r\n")
    sock:send("content-type: application/json\r\n")
    sock:send("\r\n")
    sock:send(response)

    sock:unhold()
    sock:close()
end
