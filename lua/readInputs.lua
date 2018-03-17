local function write_reg(dev_addr, reg_addr, reg_val)
      i2c.start(id)
      i2c.address(id, dev_addr, i2c.TRANSMITTER)
      i2c.write(id, reg_addr)
      i2c.write(id, reg_val)
      i2c.stop(id)
    end
    
Inputs = 0x0;
local index = 0;
for i = 0, 15 do
    index = index + 1
    InputsValueOld[index] = InputsValue[index] 
    --установим активным вход i
    write_reg(0x27, 0x01, i)
    --считаем вход i
    InputsValue[index] = adc.read(0)
    --print(i.."-"..InputsValue[index]) 
end
write_reg(0x27, 0x01, 16)

if Inputs1Adress > 0 then
    for i = 0, 15 do  
        index = index + 1
        InputsValueOld[index] = InputsValue[index]  
        write_reg(Inputs1Adress, 0x01, i)
        --print(i.."-"..adc.read(0))
        InputsValue[index] = adc.read(0)
    end
    write_reg(Inputs1Adress, 0x01, 16)
end
