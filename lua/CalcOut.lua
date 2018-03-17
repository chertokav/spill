    --сложим маски
    local Masks = dofile("LoadMasks.lua")()
    OutputsOld = Outputs;
    Outputs = 0;
    --print(#Masks)
    for i = 1, #Masks do
<<<<<<< HEAD
            -- берем одну маску и смотрим, есть в ней активные выходы по AND
        if bit.band(Masks[i], InputsOn) > 0 then
           Outputs = bit.set(Outputs, i-1);
        else
        end
    end
    for i = 1, #MasksHigh do
        if bit.band(MasksHigh[i], InputsOnHigh) > 0 then
           Outputs = bit.set(Outputs, i-1);
        else
        end
    end
    --установим ручные биты
    for i = 0, 7 do
        if bit.isset(OutputsManual, i) then
            if bit.isset(OutputsManualOld, i) then
=======
    --print("Masks[i]"..Masks[i])
        if bit.isset(InputsOn, i - 1)
        then
            --print("Outputs"..Outputs)
            Outputs = bit.bor(Outputs, Masks[i]);
            --print("Outputs2"..Outputs)
            --print(Outputs);
            --найти изменения            
        end
    end 
    --установим ручные биты
    for i = 0, 7 do
        if bit.isset(OutputsManual, i) then
            if bit.isset(OutputsManualOld, i) then                
>>>>>>> 4e4011cd0c0796307e57a388257007b51910d6e8
                Outputs = bit.set(Outputs, i)
            else
                Outputs = bit.clear(Outputs, i)
            end
        end
    end
    
