http.get("https://nodemcu-build.com/", nil, function(code, data)
    if (code < 0) then
      print("HTTP request failed")
    else
      print(code, data)
    end
  end)

  station_cfg={}
station_cfg.ssid="chertok"
station_cfg.pwd="123456789"
station_cfg.save=true
wifi.sta.config(station_cfg)

wifi.sta.connect()

print(wifi.sta.status())

http.request("https://nodemcu-build.com/", "HEAD", "", "", 
  function(code, data)
    if (code < 0) then
      print("HTTP request failed")
    else
      print(code, data)
    end
  end)
  
  
  station_cfg={}
station_cfg.ssid="chertok"
station_cfg.pwd="123456789"
station_cfg.save=true
wifi.sta.config(station_cfg)

wifi.sta.connect()

print(wifi.sta.status())
print(wifi.getmode())

do
local sta_config=wifi.sta.getconfig(true)
print(string.format("\tCurrent station config\n\tssid:\"%s\"\tpassword:\"%s\"\n\tbssid:\"%s\"\tbssid_set:%s", sta_config.ssid, sta_config.pwd, sta_config.bssid, (sta_config.bssid_set and "true" or "false")))
end


http.get("https://149.154.167.220/bot527573912:AAFuxq9welemUxybCz4Akr2ae90sssOlt8Q/getUpdates?offset=100518854", nil, function(code, data)
    if (code < 0) then
      print("HTTP request failed")
    else
      print(code, data)
    end
  end)

  http.request("https://149.154.167.220/bot527573912:AAFuxq9welemUxybCz4Akr2ae90sssOlt8Q/getUpdates?offset=100518854", "GET", "", "", 
  function(code, data)
    
      print(code)
      print("'''")
      print(data)
  end)

http.get("http://httpbin.org/ip", nil, function(code, data)
    if (code < 0) then
      print("HTTP request failed")
    else
      print(code, data)
    end
  end)
  

  sntp.sync("ntp1.vniiftri.ru",
  function(sec, usec, server, info)
    print('sync', sec, usec, server)
  end,
  function()
   print('failed!')
  end
)


http.get("https://api.github.com/repos/nodemcu/nodemcu-firmware/releases/latest", {}, function(code,data) print(code, data) end)