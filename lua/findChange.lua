local function onChange(pin, state)
    pin = pin + 1;
    print(state, pin);
     
    if InputSet[pin][1] == 1
    then
    --датчик
        --print("datch");
        if (InputSet[pin][5] == 1 and state)
            or
           (InputSet[pin][5] == 2 and state == false)
        then
            --print(OffDelayValues[pin]);
            OffDelayValues[pin] = -1;
            if InputSet[pin][2] > 0
            then
                --отслеживаем включение
                OnDelayValues[pin] = InputSet[pin][2];
                --print("on ....");
            else
                --включаем
                --print("on");
                InputsOn = bit.set(InputsOn, pin)
                publ("inputs/"..pin, 1);
                --отправка MQTT
                dofile("CalcOut.lua");
            end
        else
            OnDelayValues[pin] = -1;
            if not InputSet[pin][4]
            then                
                if InputSet[pin][3] > 0
                then
                    --отслеживаем отключение
                    OffDelayValues[pin] = InputSet[pin][3];
                    --print("off ....");
                else
                    --выключаем
                     --print("off");
                    InputsOn = bit.clear(InputsOn, pin);
                    publ("inputs/"..pin, 0);
                    dofile("CalcOut.lua");
                end
            end
        end
    else
    --счетчик
    --print(InputSet["in"..pin][5])
    --print("state", state)
    
        if (InputSet[pin][5] == 1 and state)
            or
           (InputSet[pin][5] == 2 and state == false)
        then
           --увеличим на единицу
            InputSet[pin][6] = InputSet[pin][6] + 1;
            publ("inputs/"..pin, InputSet[pin][6]);
            dofile("SaveInputSet.lua");           
        end
    end 
end

    spi.setup(1, spi.MASTER, spi.CPOL_HIGH, spi.CPHA_HIGH, 8, 20);
    gpio.write(pinIn, gpio.LOW)
    tmr.delay(20)
    gpio.write(pinIn, gpio.HIGH)
    spi.send(1,0x80)
    tmr.delay(20)
    local states = 0x0 
    states = string.byte(spi.recv(1, 1))
    local changed = bit.bxor(states, Inputs);
    for i = 0, InputsCount, 1
    do 
        if bit.band(changed, 1) == 1
            then                
                 onChange(i, bit.isset(states, i));
                --onChangeMod = nil;
                break;
            end
            changed = bit.rshift(changed, 1);            
    end                
    Inputs = states;
    states = nil;
    changed = nil;
