
--node.output(function(str)
--                uart.write(1, str)
--            end
--            , 0)

s=dofile("init_settings.lua")()
dofile("init_wifi.lua")(s.wifi_mode,s.wifi_id,s.wifi_pass,function(con)
print(con)
if(not srv_init)then dofile('web.lua')end
end)

pinIn=8;
pinOut=4;

delay = 5000;
Inputs = 0x0;
InputsOn = 0x0;
Outputs = 0;
OutputsOld = 0;
OnDelayValues  = {-1, -1, -1, -1, -1, -1, -1, -1};
OffDelayValues = {-1, -1, -1, -1, -1, -1, -1, -1};
Masks = dofile("LoadMasks.lua")()

dofile("init_MQTT.lua");
dofile("setup.lua");
dofile("LoadParams.lua");
dofile("MQTT.lua");

