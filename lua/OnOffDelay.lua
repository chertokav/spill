local function PinSet(pin)
    if pin > 32 then
        InputsOnHigh = bit.set(InputsOnHigh, pin-1)
    else
        InputsOn = bit.set(InputsOn, pin-1)
    end
end

local function PinClear(pin)
    if pin > 32 then
        InputsOnHigh = bit.clear(InputsOnHigh, pin-1);
    else
        InputsOn = bit.clear(InputsOn, pin-1);
    end
end

    for key, value in pairs(OnDelayValues) do
        if value - delay < 0 and value  ~= -1
        then
            print("on", key, value);
            --здесь пора включить
            OnDelayValues[key] = -1;
            PinSet(key)
            --print(InputsOn);
            --dofile("CalcOut.lua");
        else if value  ~= -1
            then
                print("on...", key, value);
                OnDelayValues[key] = value - delay;            
            end
        end
    end

    for key, value in pairs(OffDelayValues) do
        if value - delay < 0 and value  ~= -1
        then
            print("off", key, value);
            --здесь пора включить
            OffDelayValues[key] = -1;
<<<<<<< HEAD
            PinClear(key)
=======
            InputsOn = bit.clear(InputsOn, key - 1);
            --dofile("CalcOut.lua");
>>>>>>> 4e4011cd0c0796307e57a388257007b51910d6e8
        else if value  ~= -1
            then
                print("off...", key, value);
                OffDelayValues[key] = value - delay;            
            end
        end
    end


