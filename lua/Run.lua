
--node.output(function(str)
--                uart.write(1, str)
--            end
--            , 0)

--uart.setup(0, 74880, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1)
--адреса выходных регистров
Outputs1Adress = 0x23;
Outputs2Adress = 0x0;
Outputs3Adress = 0x0;
--адреса входных регистров
Inputs1Adress = 0x26
Inputs2Adress = 0x0
Inputs3Adress = 0x0

--битовый массив выходов максимум 4 по 8 выходов
Outputs = 0x0;
OutputsManual = 0x0;
OutputsManualOld = 0x0;
OutputsOld = 0;
InputsValueOld = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
InputsValue    = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
InputsOn = 0x0;
InputsOnHigh = 0x0;
OnDelayValues  = {-1, -1, -1, -1, -1, -1, -1, -1};
OffDelayValues = {-1, -1, -1, -1, -1, -1, -1, -1};

dofile("setup.lua")


dofile("MQTT.lua");
dofile("SendOut.lua");
RUNtimer = tmr.create()
delay = 3000;
RUNtimer:alarm(30000, tmr.ALARM_SINGLE , 
    function()
        RUNtimer:alarm(delay, 1, 
            function()
                --print("readInputs")
                dofile("readInputs.lua");
                --print("findChange")
                dofile("findChange.lua")
                --print("OnOffDelay")
                dofile("OnOffDelay.lua")
                --print("CalcOut")
                dofile("CalcOut.lua")
                --проверим, что изменилось
                --print("OutputsOld")
                if bit.bxor(OutputsOld, Outputs) ~= 0 then
                    dofile("SendOut.lua");
                    dofile("MQTTsend.lua");
                    dofile("SaveOutputs.lua");
                end        
            end
            )
    end
)

