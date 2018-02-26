return function ()
    local inputs
    if file.open("params.json", "r") 
    then
        local ok, json = pcall(sjson.decode,file.read())
        inputs = ok and json or {}    
        file.close();
    else
         print("no file");
    end
    return inputs
end

