spi.setup(1, spi.MASTER, spi.CPOL_HIGH, spi.CPHA_LOW, 8, 20);
    gpio.write(pinOut, gpio.LOW)
    tmr.delay(20)
    spi.send(1,Outputs)
    gpio.write(pinOut, gpio.HIGH)
