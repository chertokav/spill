    --сложим маски
    
    OutputsOld = Outputs;
    Outputs = 0;
    for i = 1, #Masks do
            -- берем одну маску и смотрим, есть в ней активные выходы по AND
            if bit.band(Masks[i], InputsOn) > 0 then
                Outputs = bit.set(Outputs, i-1);
            else
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
    
