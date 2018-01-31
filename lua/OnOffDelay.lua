
    for key, value in pairs(OnDelayValues) do
        if value - delay < 0 and value  ~= -1
        then
            print("on", key, value);
            --здесь пора включить
            OnDelayValues[key] = -1;
            InputsOn = bit.set(InputsOn, key - 1);
            --print(InputsOn);
            dofile("CalcOut.lua");
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
            InputsOn = bit.clear(InputsOn, key - 1);
            dofile("CalcOut.lua");
        else if value  ~= -1
            then
                print("off...", key, value);
                OffDelayValues[key] = value - delay;            
            end
        end
    end


