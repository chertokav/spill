MQTTtimer = tmr.create()
MQTTtimer:register(30000, tmr.ALARM_SEMI , function()
                            print ("Tmr")
                            m:connect(Broker, port, 0, 
                            function(client)
                                m:publish(myClient.."/report","Wait",0,0)
                                m:subscribe({[myClient.."/inputs/#"]=1,[myClient.."/outputs/#"]=1,[myClient.."/system/#"]=1})
                            end,
                            function(client, reason)
                                print("failed reason: " .. reason)
                            end)
                            MQTTtimer:stop()
                        end)
MQTTtimer:start()



function publ(topic, datt)
    print("mes "..topic.." & "..datt)
    if(datt) 
    then
        m:publish(myClient.."/"..topic, datt,0,0)
    end
end


                
--подписка на сообщения
m:on("connect", 
    function(client) 
        print ("connected")
        m:subscribe({[myClient.."/inputs/#"]=1,[myClient.."/outputs/#"]=1,[myClient.."/system/#"]=1})
    end
)
    
m:on("offline", function(client) 
                    print ("offline") 
                    MQTTtimer:start()
                end)

m:on("message", 
    function(conn, topic, data)
        print("mes "..topic.." & "..data)
        local d1 = string.match(topic,  "outputs.(%d+)")
        local d2 = string.match(topic,  "inputs.(%d+)")
        if d1 then
            if data == "1" then
                print("bit.set Outputs")
                Outputs = bit.set(Outputs, d1)
            else
                print("bit.clear Outputs")
                Outputs = bit.clear(Outputs, d1)
            end
        elseif d2 then
            if data == "1" then
                print("bit.set InputsOn")
                InputsOn = bit.set(InputsOn, d2)
            else
                print("bit.set InputsOn")
                InputsOn = bit.clear(InputsOn, d2)
            end        
        else
            print("No match MQTT")
        end
    end)



