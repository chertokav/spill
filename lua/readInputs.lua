Inputs = 0x0;
for i = 0, 15 do
    InputsValueOld[i+1] = InputsValue[i+1] 
    --установим активным вход i
    write_reg(0x27, 0x01, i)
    --считаем вход i
    InputsValue[i+1] = adc.read(0)
    print(InputsValue[i+1])
    
end

write_reg(0x27, 0x01, 16)

