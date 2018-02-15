    --сложим маски
    OutputsOld = Outputs;
    Outputs = 0;
    for i = 1, #Masks do
        if bit.isset(InputsOn, i - 1)
        then
            Outputs = bit.bor(Outputs, Masks[i]);
            print(Outputs);
            --найти изменения
            
        end
    end 
    dofile("SendOut.lua");
