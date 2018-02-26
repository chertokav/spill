MQTTtimer = tmr.create()
MQTTconnected = false;
MQTTtimer:register(30000, tmr.ALARM_SEMI , function()
                            m:connect(Broker, port, 0, 
                            function(client)
                                print("MQTT connected")
                                MQTTconnected = true;
                                m:publish(myClient.."/report","Wait",0,0)
                                m:subscribe({[myClient.."/inputs/#"]=1,[myClient.."/outputs/#"]=1,[myClient.."/system/#"]=1})
                            end,
                            function(client, reason)
                                print("MQTT failed reason: " .. reason)
                                MQTTtimer:start()
                                MQTTconnected = false;
                            end)
                            MQTTtimer:stop()
                        end)
MQTTtimer:start()

function publ(topic, datt)
    print("mes "..topic.." & "..datt)
    if(datt and MQTTconnected) then
        m:publish(myClient.."/"..topic, datt, 0, 0)
    else
        print("MQTT publish error")
    end
    
end
                
--подписка на сообщения
m:on("connect", 
    function(client) 
        print ("MQTT connected")
        m:subscribe({[myClient.."/inputs/#"]=1,[myClient.."/outputs/#"]=1,[myClient.."/system/#"]=1})
    end
)
    
m:on("offline", function(client) 
                    print ("offline") 
                    MQTTtimer:start()
                    MQTTconnected = false;
                end)

m:on("message", 
    function(conn, topic, data)
        print("mes "..topic.." & "..data)
        local d1 =string.match(topic,  "outputs.(%d+)")
        local d2 =string.match(topic,  "inputs.(%d+)")
        if d1 then
            if data == "1" then
                if bit.isset(Outputs, d1-1) then 
                    print("On skeep")
                else
                    print("bit.set Outputs")
                    OutputsManualOld = bit.set(OutputsManualOld, d1-1)
                    OutputsManual = bit.set(OutputsManual, d1-1)
                    dofile("CalcOut.lua");
                    if bit.bxor(OutputsOld, Outputs) > 0 then
                        dofile("SendOut.lua");
                        publ("system/manual", 1);
                    end
                end
            else
                if bit.isclear(Outputs, d1-1) then 
                    print("Off skeep")
                else
                    print("bit.clear Outputs")
                    OutputsManualOld = bit.clear(OutputsManualOld, d1-1)
                    OutputsManual = bit.set(OutputsManual, d1-1)
                    dofile("CalcOut.lua");
                    if bit.bxor(OutputsOld, Outputs) > 0 then
                        dofile("SendOut.lua");
                        publ("system/manual", 1);
                    end
                end
            end
        elseif d2 then
            if data == "1" then
                print("bit.set InputsOn")
                InputsOn = bit.set(InputsOn, d2-1)
            else
                print("bit.set InputsOn")
                InputsOn = bit.clear(InputsOn, d2-1)
            end        
        elseif string.match(topic,  "system.(%w+)") == "cmd" then
            if data == "MQTTreload" then
                --перезагрузить весь MQTT
                for i = 0, 15, 1
                do
                    if bit.isset(Inputs, i) then                
                        publ("inputs/"..i+1, 1);
                    else
                        publ("inputs/"..i+1, 0);
                    end
                end                
                for i = 0, 15, 1
                do
                    if bit.isset(Outputs, i) then                
                        publ("outputs/"..i+1, 1);
                    else
                        publ("outputs/"..i+1, 0);
                    end
                end
                if OutputsManual ~= 0 then
                    publ("system/manual", 1);
                else
                    publ("system/manual", 0);
                end
            end    
        elseif string.match(topic,  "system.(%w+)") == "manual" then
            if data == "1" then
                
            else
                OutputsManual = 0x0;
                OutputsManualOld = 0x0;
            end
        else
            print("No match MQTT")
        end
    end)



