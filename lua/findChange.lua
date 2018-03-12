local function onChange(pin, InputSet)
    --pin = pin + 1;
    local state;
    --print(InputsValue[pin].."-"..InputSet[pin][11].."-"..bit.isset(InputsOn, pin-1))
    --если значение больше или меньше граничных значений
    if InputsValue[pin] < InputSet[pin][11] and bit.isset(InputsOn, pin-1) then
    --сброс на ноль
        state = false
    elseif InputsValue[pin] > InputSet[pin][12] and bit.isclear(InputsOn, pin-1) then
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
                InputsOn = bit.set(InputsOn, pin-1)
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
                    InputsOn = bit.clear(InputsOn, pin-1);
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
    end 
end   

 
--print("-------")
for i = 1, 16 do
    --print(InputsValueOld[i].."v"..InputsValue[i])
    if InputsValueOld[i] ~= InputsValue[i] then
        onChange(i, InputSet)
    end
end
