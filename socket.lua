local config = require("config")
local server = net.createServer()

local function noop () end
local _socket = {
    handle_connection = noop,
    handle_reconnection = noop,
    handle_disconnect = noop,
    handle_receive = noop,
    handle_sent = noop
}

local function handler (socket)
    local _, ip = socket:getpeer()

    print("New connection from " .. (ip or 'unknown ip'))

    -- attach handlers
    socket:on("connection", _socket.handle_connection)
    socket:on("reconnection", _socket.handle_reconnection)
    socket:on("disconnection", _socket.handle_disconnection)
    socket:on("receive", _socket.handle_receive)
    socket:on("sent", _socket.handle_sent)
end

print("Started server on " .. config.server.port)
server:listen(config.server.port, handler)

return _socket
