return function ()
    local s
    if file.open("setting.json", "r") then
        local ok, json = pcall(sjson.decode,file.read('\n'))
        s = ok and json or {}
        s.token=crypto.toBase64(node.random(100000))
        file.close()
        print("Settings Loaded")
    else
        print("Settings Clear")
    end
    return s
end
