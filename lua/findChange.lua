<<<<<<< HEAD
local function getPinIsSet(pin)
    if pin > 32 then
        return bit.isset(InputsOnHigh, pin-1)
    else
        return bit.isset(InputsOn, pin-1)
    end
end

local function getPinIsClear(pin)
    if pin > 32 then
        return bit.isclear(InputsOnHigh, pin-1)
    else
        return bit.isclear(InputsOn, pin-1)
    end
end

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

local function onChange(pin, InputSet)
--print(pin)
    if InputSet[pin] == nil then
        print("pin not config "..pin)
        return 
    end
=======
local function onChange(pin, InputSet)
>>>>>>> 4e4011cd0c0796307e57a388257007b51910d6e8
    --pin = pin + 1;
    local state;
    --print(InputsValue[pin].."-"..InputSet[pin][11].."-"..bit.isset(InputsOn, pin-1))
    --если значение больше или меньше граничных значений
<<<<<<< HEAD
    if InputsValue[pin] < InputSet[pin][11] and getPinIsSet(pin) then
    --сброс на ноль
        state = false
    elseif InputsValue[pin] > InputSet[pin][12] and getPinIsClear(pin) then
=======
    if InputsValue[pin] < InputSet[pin][11] and bit.isset(InputsOn, pin-1) then
    --сброс на ноль
        state = false
    elseif InputsValue[pin] > InputSet[pin][12] and bit.isclear(InputsOn, pin-1) then
>>>>>>> 4e4011cd0c0796307e57a388257007b51910d6e8
    --установка единицы
        state = true
    else
        return
    end
    
    print("onChange "..pin);
    
    if InputSet[pin][1] == 1
    then
    --датчик
        print("datch");
        if (InputSet[pin][5] == 1 and state)
            or
           (InputSet[pin][5] == 2 and state == false)
        then
            --print("OffDelayValues[pin]");
            OffDelayValues[pin] = -1;
            if InputSet[pin][2] > 0
            then
                --отслеживаем включение
                OnDelayValues[pin] = InputSet[pin][2];
            else
                --включаем
<<<<<<< HEAD
                PinSet(pin)
=======
                InputsOn = bit.set(InputsOn, pin-1)
>>>>>>> 4e4011cd0c0796307e57a388257007b51910d6e8
                publ("inputs/"..pin, 1);
            end
        else
            --print("OnDelayValues[pin]");
            OnDelayValues[pin] = -1;
            --print(InputSet[pin][4])
            if InputSet[pin][4] ~= 1
            then                
                if InputSet[pin][3] > 0
                then
                    --отслеживаем отключение
                    OffDelayValues[pin] = InputSet[pin][3];
                else
                    --выключаем
<<<<<<< HEAD
                    PinClear(pin);
=======
                    InputsOn = bit.clear(InputsOn, pin-1);
>>>>>>> 4e4011cd0c0796307e57a388257007b51910d6e8
                    publ("inputs/"..pin, 0);
                end
            end
        end
    else
    --счетчик
    
        if (InputSet[pin][5] == 1 and state)
            or
           (InputSet[pin][5] == 2 and state == false)
        then
            print(InputSet[15][6])  
           --увеличим на единицу
            InputSet[pin][6] = InputSet[pin][6] + 1;
            publ("inputs/"..pin, InputSet[pin][6]);
            local ok, json = pcall(sjson.encode, InputSet)
            if ok
            then
              if file.open("params.inp", "w+")
              then
                   -- print("save")
                   file.write(json)
                   file.close()
              end
            else
              print("failed to encode!")
            end
            print(InputSet[15][6])
        end
<<<<<<< HEAD
    end
end

local InputSet = dofile("LoadParams.lua")();  
--print("-------")
for i = 1, #InputsValueOld do
=======
    end 
end   

local InputSet = dofile("LoadParams.lua")(); 
--print("-------")
for i = 1, 16 do
>>>>>>> 4e4011cd0c0796307e57a388257007b51910d6e8
    --print(InputsValueOld[i].."v"..InputsValue[i])
    if InputsValueOld[i] ~= InputsValue[i] then
        onChange(i, InputSet)
    end
end
