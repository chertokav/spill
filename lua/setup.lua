    if file.open("setting.json", "r") then       
        local ok, json = pcall(sjson.decode,file.read('\n'))
        s = ok and json or {}
        s.token=crypto.toBase64(node.random(100000))
        file.close()
        Masks, MasksHigh = dofile("LoadMasks.lua")()
        --InputSet = dofile("LoadParams.lua")();
        
        local cfg={}
        --для входа в настройки
        local cfgap={}
        cfgap.ssid = "NodeMsu"
        cfgap.pwd = "1qaz2wsx"
        wifi.setmode(wifi.STATIONAP)
        wifi.ap.config(cfgap)
        if s.wifi_mode == "AP" then
            cfg.ssid = s.wifi_id
            cfg.pwd = s.wifi_pass
            wifi.sta.config(cfg)
            wifi.sta.autoconnect(1);
            wifi.eventmon.register(wifi.eventmon.AP_STACONNECTED,
                function(T)
                    print("Connect client: "..wifi.ap.getip())
                    if(not srv_init) then 
                        dofile('web.lua') 
                    end
                end)
            if s.mqtt=="ON" then
                Broker = s.mqtt_server
                port = s.mqtt_port
                myClient = "196-59/gidro"
                m = mqtt.Client(myClient, 180)
            else
                print("MQTT is OFF")
            end
        end
    else
        print("Settings Clear")
    end

    --print("i2c.setup")
    id  = 0
    local sda = 5
    local scl = 6
    i2c.setup(id, sda, scl, i2c.SLOW)
    --print("i2c.setupEnd")
    
    local function read_reg(dev_addr, reg_addr)
          i2c.start(id)
          i2c.address(id, dev_addr ,i2c.TRANSMITTER)
          i2c.write(id,reg_addr)
          i2c.stop(id)
          i2c.start(id)
          i2c.address(id, dev_addr,i2c.RECEIVER)
          c = i2c.read(id,1)
          i2c.stop(id)
          return c
        end
    
    function write_reg(dev_addr, reg_addr, reg_val)
          i2c.start(id)
          i2c.address(id, dev_addr, i2c.TRANSMITTER)
          i2c.write(id, reg_addr)
          i2c.write(id, reg_val)
          i2c.stop(id)
        end
    --print("write_reg")
    --записать в регистр 3 (1, 1) 0x03 нули и настроить все пины как выходные
    --адрес регистра 0100 + 001 0x21 вывод для сигнальных диодов
    write_reg(0x21, 0x03, 0x00)
    
    --адрес регистра 0100 + 000 0x20 вывод для реле
    write_reg(0x20, 0x03, 0x00)
    
    --адрес регистра 0100 + 111 0x27  управление мультиплексором
    write_reg(0x27, 0x03, 0x00)
    
    --проверка на расширение 1 модуль вывода
    if Outputs1Adress ~= nil and Outputs1Adress > 0 then
        print("Outputs1Adress"..Outputs1Adress)
        write_reg(Outputs1Adress, 0x06, 0x0)
        write_reg(Outputs1Adress, 0x07, 0x0)
    end
    
    --проверка на расширение 2 модуль вывода
    if Outputs2Adress ~= nil and Outputs2Adress > 0 then
        write_reg(Outputs2Adress, 0x06, 0x0)
        write_reg(Outputs2Adress, 0x07, 0x0)
    end
    
    --проверка на расширение 3 модуль вывода
    if Outputs3Adress ~= nil and Outputs3Adress > 0 then
        write_reg(Outputs3Adress, 0x06, 0x0)
        write_reg(Outputs3Adress, 0x07, 0x0)
    end
    
    --проверка на расширение 1 модуль ввода
    if Inputs1Adress ~= nil and Inputs1Adress > 0 then
        write_reg(Inputs1Adress, 0x03, 0x0)
    end
    --проверка на расширение 2 модуль ввода
    if Inputs2Adress ~= nil and Inputs2Adress > 0 then
        write_reg(Inputs2Adress, 0x03, 0x0)
    end
    --проверка на расширение 3 модуль ввода
    if Inputs3Adress ~= nil and Inputs3Adress > 0 then
        write_reg(Inputs3Adress, 0x03, 0x0)
    end

    if file.open("SavedData.inp", "r") then       
        local ok, json = pcall(sjson.decode,file.read('\n'))
        local data = ok and json or {}
        file.close()
        Outputs = data["Outputs"]
        OutputsManual = data["OutputsManual"]
        InputsValueOld = data["InputsValueOld"]
        OutputsManualOld = data["OutputsManualOld"]
    end       


print("Settings Loaded")
