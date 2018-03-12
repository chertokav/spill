function decToBcd(val)
    local d = string.format("%d",tonumber(val / 10))
    local d1 = tonumber(d*10)
    local d2 = val - d1
   return tonumber(d*16+d2)
end

function bcdToDec(val)
      local hl=bit.rshift(val, 4)
      local hh=bit.band(val,0xf)
     local hr = string.format("%d%d", hl, hh)
     return string.format("%d%d", hl, hh)
end

address = 0x68
i2c.setup(id, sda, scl, i2c.SLOW)


readTime = function ()
   wkd = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
   i2c.start(id)
   i2c.address(id, address, i2c.TRANSMITTER)
   i2c.write(id, 0x00)
   i2c.stop(id)
   i2c.start(id)
   i2c.address(id, address, i2c.RECEIVER)
   c=i2c.read(id, 7)
   i2c.stop(id)
   return  bcdToDec(string.byte(c,1)),
         bcdToDec(string.byte(c,2)),
         bcdToDec(string.byte(c,3)),
         wkd[tonumber(bcdToDec(string.byte(c,4)))],
         bcdToDec(string.byte(c,5)),
         bcdToDec(string.byte(c,6)),
         bcdToDec(string.byte(c,7))
end

setTime = function (second, minute, hour, day, date, month, year)
   i2c.start(id)
   i2c.address(id, address, i2c.TRANSMITTER)
   i2c.write(id, 0x00)
   i2c.write(id, decToBcd(second))
   i2c.write(id, decToBcd(minute))
   i2c.write(id, decToBcd(hour))
   i2c.write(id, decToBcd(day))
   i2c.write(id, decToBcd(date))
   i2c.write(id, decToBcd(month))
   i2c.write(id, decToBcd(year))
   i2c.stop(id)
end