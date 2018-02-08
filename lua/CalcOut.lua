    --сложим маски
    Outputs = 0;
    for i = 1, #Masks do
        if bit.isset(InputsOn, i - 1)
        then
            Outputs = bit.bor(Outputs, Masks[i]);
            print(Outputs);
        end
    end 
    --Outputs = outputs;
    spi.setup(1, spi.MASTER, spi.CPOL_HIGH, spi.CPHA_LOW, 8, 20);
    gpio.write(pinOut, gpio.LOW)
    tmr.delay(20)
    spi.send(1,Outputs)
    gpio.write(pinOut, gpio.HIGH)
