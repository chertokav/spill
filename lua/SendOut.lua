local id  = 0
local sda = 5
local scl = 6
local function read_reg(dev_addr, reg_addr)
      i2c.start(id)
      i2c.address(id, dev_addr ,i2c.TRANSMITTER)
      i2c.write(id,reg_addr)
      i2c.stop(id)
      i2c.start(id)
      i2c.address(id, dev_addr,i2c.RECEIVER)
      c = i2c.read(id,1)
      i2c.stop(id)
      return c
    end

local function write_reg(dev_addr, reg_addr, reg_val)
      i2c.start(id)
      i2c.address(id, dev_addr, i2c.TRANSMITTER)
      i2c.write(id, reg_addr)
      i2c.write(id, reg_val)
      i2c.stop(id)
    end

local function shift(bitCount)
    local NewOutputs = bit.lshift(Outputs, bitCount)
    NewOutputs = bit.rshift(NewOutputs, 24)
    local SignalOutputs = bit.bnot(Outputs);
    SignalOutputs = bit.lshift(SignalOutputs, bitCount)
    SignalOutputs = bit.rshift(SignalOutputs, 24)
    return NewOutputs, SignalOutputs
end


print("send")
--первый
local NewOutputs, SignalOutputs = shift(24);
write_reg(0x21, 0x01, SignalOutputs)
write_reg(0x20, 0x01, NewOutputs)

--проверка на расширение 1 модуль
if Outputs1Adress > 0 then
    NewOutputs, SignalOutputs = shift(16);
    write_reg(Outputs1Adress, 0x03, SignalOutputs)
    write_reg(Outputs1Adress, 0x02, NewOutputs)
end

--проверка на расширение 2 модуль
if Outputs2Adress > 0 then
    NewOutputs, SignalOutputs = shift(8);
    write_reg(Outputs2Adress, 0x03, SignalOutputs)
    write_reg(Outputs2Adress, 0x02, NewOutputs)
end

--проверка на расширение 3 модуль
if Outputs3Adress > 0 then
    NewOutputs, SignalOutputs = shift(0);
    write_reg(Outputs3Adress, 0x03, SignalOutputs)
    write_reg(Outputs3Adress, 0x02, NewOutputs)
end
