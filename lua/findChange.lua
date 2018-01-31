


local function onChange(pin, state)
    pin = pin + 1;
    print(state, pin);
     
    if InputSet["in"..pin].Tp == 1
    then
    --датчик
        --print("datch");
        if (InputSet["in"..pin].Pol == 1 and state)
            or
           (InputSet["in"..pin].Pol == 2 and state == false)
        then
            --print(OffDelayValues[pin]);
            OffDelayValues[pin] = -1;
            if InputSet["in"..pin].On > 0
            then
                --отслеживаем включение
                OnDelayValues[pin] = InputSet["in"..pin].On;
                --print("on ....");
            else
                --включаем
                --print("on");
                InputsOn = bit.set(InputsOn, pin)
                dofile("CalcOut.lua");
            end
        else
            OnDelayValues[pin] = -1;
            if not InputSet["in"..pin].Tr
            then                
                if InputSet["in"..pin].Of > 0
                then
                    --отслеживаем отключение
                    OffDelayValues[pin] = InputSet["in"..pin].Of;
                    --print("off ....");
                else
                    --выключаем
                     --print("off");
                    InputsOn = bit.clear(InputsOn, pin);
                    dofile("CalcOut.lua");
                end
            end
        end
    else
    --счетчик
    --print(InputSet["in"..pin].Pol)
    --print("state", state)
    
        if (InputSet["in"..pin].Pol == 1 and state)
            or
           (InputSet["in"..pin].Pol == 2 and state == false)
        then
           --увеличим на единицу
            --print("Stchet");
            --print( InputSet["in"..pin].Val);
            InputSet["in"..pin].V = InputSet["in"..pin].V + 1;
            --print( InputSet["in"..pin].Val);
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
    for i = 0, 8, 1
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
