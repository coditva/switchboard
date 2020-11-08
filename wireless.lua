config = require("config")

if config.ap and config.station then
    wifi.ap.config(config.ap)
    wifi.sta.config(config.station)

    print("Starting station and access point mode")
    print(wifi.ap.getip())
    wifi.setmode(wifi.STATIONAP)
elseif config.ap then
    wifi.ap.config(config.ap)

    print("Starting access point mode")
    print(wifi.ap.getip())
    wifi.setmode(wifi.SOFTAP)
elseif config.station then
    wifi.sta.config(config.station)

    print("Starting station mode")
    wifi.setmode(wifi.STATION)
else
    print("Stopping wifi")
    wifi.setmode(wifi.NULLMODE)
end
