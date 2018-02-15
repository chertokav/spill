gpio.mode(pinIn, gpio.OUTPUT);
gpio.mode(pinOut, gpio.OUTPUT);

--wifi.setmode(wifi.STATIONAP)
--wifi.sta.config("ASUSCH","VFITYMRF")
--wifi.sta.autoconnect(1);


 
spi.setup(1, spi.MASTER, spi.CPOL_HIGH, spi.CPHA_LOW, 8, 20);
gpio.write(pinOut, gpio.LOW)
tmr.delay(20)
spi.send(1,0)
gpio.write(pinOut, gpio.HIGH)

