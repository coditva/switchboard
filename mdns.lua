config = require("config")

if not config.dns then
    return print("No config found for mDNS. Aborting!")
end

print("Register hostname " .. config.dns.hostname)
mdns.register(config.dns.hostname, config.dns.options)
