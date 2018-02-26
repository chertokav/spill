    --сложим маски
    local Masks = dofile("LoadMasks.lua")()
    OutputsOld = Outputs;
    Outputs = 0;
    --print(#Masks)
    for i = 1, #Masks do
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
                Outputs = bit.set(Outputs, i)
            else
                Outputs = bit.clear(Outputs, i)
            end
        end
    end
    
