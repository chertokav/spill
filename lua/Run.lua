
--node.output(function(str)
--                uart.write(1, str)
--            end
--            , 0)

--uart.setup(0, 74880, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1)

dofile("setup.lua")

pinIn=8;
pinOut=1;
pinSignal=6;

id  = 0
sda = 5
scl = 6
i2c.setup(id, sda, scl, i2c.SLOW)

function read_reg(dev_addr, reg_addr)
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

--записать в регистр 3 (1, 1) 0x03 нули и настроить все пины как выходные
--адрес регистра 0100 + 001 0x21 вывод для сигнальных диодов
write_reg(0x21, 0x03, 0x00)

--адрес регистра 0100 + 000 0x20 вывод для реле
write_reg(0x20, 0x03, 0x00)

--адрес регистра 0100 + 111 0x27  управление мультиплексором
write_reg(0x27, 0x03, 0x00)

delay = 1000;
--Inputs = 0x0;
InputsValue = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
InputsValueOld = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
--InputsCount = 16;
InputsOn = 0x0;
Outputs = 0x0;
OutputsManual = 0x0;
OutputsManualOld = 0x0;
--OutputsCount = 8;
OutputsOld = 0;
OnDelayValues  = {-1, -1, -1, -1, -1, -1, -1, -1};
OffDelayValues = {-1, -1, -1, -1, -1, -1, -1, -1};

--dofile("LoadParams.lua");
dofile("MQTT.lua");
dofile("SendOut.lua");

tmr.alarm(0, 30000, tmr.ALARM_SEMI, 
    function()
        tmr.alarm(0, delay, 1, 
            function()
                dofile("readInputs.lua");
                dofile("findChange.lua")
                dofile("OnOffDelay.lua")      
                dofile("CalcOut.lua")  
                --проверим, что изменилось
                if bit.bxor(OutputsOld, Outputs) > 0 then
                    dofile("SendOut.lua");
                    dofile("MQTTsend.lua");
                end        
            end
            )
    end
)
