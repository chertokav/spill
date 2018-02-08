    --сложим маски
    Outputs = 0;
    for i = 1, #Masks do
        if bit.isset(InputsOn, i - 1)
        then
            Outputs = bit.bor(Outputs, Masks[i]);
            print(Outputs);
        end
    end 
dofile("SendOut.lua");
