    local s
    if file.open("setting.json", "r") then
        local ok, json = pcall(sjson.decode,file.read('\n'))
        s = ok and json or {}
        s.token=crypto.toBase64(node.random(100000))
        file.close()
        print("Settings Loaded")
        local cfg={}
        cfg.ssid=s.wifi_id
        cfg.pwd = s.wifi_pass
        local cfgap={}
        cfgap.ssid="NodeMsu"
        cfgap.pwd="1qaz2wsx"
        wifi.setmode(wifi.STATIONAP)
        wifi.ap.config(cfgap)
        wifi.sta.config(cfg)
        wifi.sta.autoconnect(1);
        wifi.eventmon.register(wifi.eventmon.AP_STACONNECTED,
            function(T)
                print("Connect client: "..wifi.ap.getip())
                if(not srv_init) then 
                    dofile('web.lua') 
                end
            end)
        Broker = s.mqtt_server
        port = s.mqtt_port
        print("s.token"..s.token)
        myClient = "196-59/gidro"
        m = mqtt.Client(myClient, 180)
    else
        print("Settings Clear")
    end
