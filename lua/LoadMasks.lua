return function ()
    local s
    if file.open("Masks.json", "r") then
        local ok, json = pcall(sjson.decode,file.read('\n'))
        s = ok and json or {}
        file.close()
    else
        s={0, 0, 0, 0, 0, 0, 0, 0};
    end
    return s
end
