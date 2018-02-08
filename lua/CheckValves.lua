--для списка кранов
local valves = {1, 5, 8};

local function onValve(valve)
local onDelay = 3000
local offDelay = 3000
local inputNumOn, inputNumOff
print("valve"..valve)
        if bit.isset(Outputs, valve - 1) then
            print("set is clouse");   
            for key, value in pairs(valves) do
                                if value==valve and key < #valves then
                                    onValve(valves[key + 1])
                                    break;
                                end
                            end         
        else 
             --ищем обратную связь
            for ind = 1, #InputSet do
                        if InputSet[ind][8] == valve then
                            if InputSet[ind][9] == 1 then
                                onDelay = InputSet[ind][10]
                                inputNumOn = ind
                                print("onDelay "..onDelay);
                                print("inputNumOn"..inputNumOn);
                            else
                                offDelay = InputSet[ind][10]
                                inputNumOff = ind
                                print("offDelay "..offDelay);
                                print("inputNumOff"..inputNumOff);
                            end
                        end
                    end
            Outputs = bit.set(Outputs, valve - 1)
            spi.setup(1, spi.MASTER, spi.CPOL_HIGH, spi.CPHA_LOW, 8, 20);
            gpio.write(pinOut, gpio.LOW)
            tmr.delay(20)
            spi.send(1,Outputs)
            gpio.write(pinOut, gpio.HIGH)
            --ждем
            tmr.alarm(2, offDelay, tmr.ALARM_SINGLE, 
                function()
                    --проверяем
                    print("checkValve")
                    if inputNumOff and not bit.isset(Inputs, inputNumOff - 1) then
                        --TODO: тревога
                        print("Alarm clouse")
                    else
                        print("checkValve")
                    end
                    --открыть кран
                    Outputs = bit.clear(Outputs, valve - 1)
                    spi.setup(1, spi.MASTER, spi.CPOL_HIGH, spi.CPHA_LOW, 8, 20);
                    gpio.write(pinOut, gpio.LOW)
                    tmr.delay(20)
                    spi.send(1,Outputs)
                    gpio.write(pinOut, gpio.HIGH)
                    --подождать закрытия
                    tmr.alarm(2, onDelay, tmr.ALARM_SINGLE, 
                        function()
                            --TODO:проверяем открытие
                            print("checkOFfValve")
                            if inputNumOn and bit.isset(Inputs, inputNumOn - 1) then
                                --не успел открыться
                                print("Alarm open")
 --TODO: тревога                               
                            else
                                print("checkValve")
                            end                            
                             --следующий кран
                            for key, value in pairs(valves) do
                                if value==valve and key < #valves then
                                    onValve(valves[key + 1])
                                    break;
                                end
                            end
                        end
                        )
                end
            )
        end
end
 

if #valves > 0 then
    onValve(valves[1])
end
