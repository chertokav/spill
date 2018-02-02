if file.open("params.json", "r") 
then
    local ok, json = pcall(sjson.decode,file.read())
    InputSet = ok and json or {}    
    file.close();
else
     print("no file");
end

