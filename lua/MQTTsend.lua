--отправим MQTT на все изменения
local rez = bit.bxor(OutputsOld, Outputs)
OutputsOld = Outputs
for i = 0, 7 do
    if bit.isset(rez, i) then
        if bit.isset(Outputs, i) then                
            publ("outputs/"..i+1, 1);
        else
            publ("outputs/"..i+1, 0);
        end
    end
end

if OutputsManual ~= 0 then
    publ("system/manual", 1);
end
