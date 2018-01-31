Broker="192.168.1.107"
port=1883

        m:connect(Broker, port, 0, 0)
        m:publish(myClient.."/report","Wait",0,0)


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
        m:subscribe({[myClient.."/cool"]=1,[myClient.."/hot"]=1})
    end
)
    
m:on("offline", function(client) print ("offline") end)

m:on("message", function(conn, topic, data)
    print("mes "..topic.." & "..data)
end)
