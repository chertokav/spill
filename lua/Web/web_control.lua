local function write_to_file(data,f)
 local ok, json = pcall(sjson.encode, data)
  if ok then
   if file.open(f, "w") then
    file.write(json)
    file.close()
   end
   print(json)
   return "true"
 else
  return "false"
 end
end

local function cry(l,p)
return crypto.toBase64(crypto.mask(l..p,s.token))
end

local function auth(arg)
 return cry(arg.login,arg.pass)==cry(s.auth_login,s.auth_pass) and cry(arg.login,arg.pass) or "false"
end

local function save(tab)
for k,v in pairs(tab) do
s[k] = (tonumber(v) and k ~= "auth_pass") and tonumber(v) or v
 end
 return write_to_file(s,"setting.json")
end

local function saveOut(tab)
    print(tab);
    print(Masks);
    Masks = tab["mask"];
    return write_to_file(Masks,"Masks.json")
end

local function saveIn(tab)
    print("saveIn");
    InputSet = tab["params"]
    return write_to_file(InputSet,"params.json")
end

local function OnOff(tab)
    if(tab["elChecked"]) then
        Outputs = bit.set(Outputs, tab["elValue"])
    else
        Outputs = bit.clear(Outputs, tab["elValue"]);
    end
    print(Outputs);
end

local function listap(t)
local d = {}
local i = {}
 for k,v in pairs(t) do
  d.am, d.ri, d.bd, d.cl = v:match("([^,]+),([^,]+),([^,]+),([^,]+)")
  d.sd=k
  i[#i+1]=d
  d={}
 end
 write_to_file(i,"get_network.json")
end

return function (tab)
local r="false"
print("tab.init");
print(tab.init);

 if tab.init=="save"then tab.init=nil r=save(tab)
 elseif tab.init=="saveOut" then tab.init=nil r=saveOut(tab)
 elseif tab.init=="saveIn" then tab.init=nil r=saveIn(tab)
 elseif tab.init=="OnOff" then tab.init=nil r=OnOff(tab)
 elseif tab.init=="scan" then wifi.sta.getap(listap) r="true"
 elseif tab.init=="reboot" then
  tmr.create():alarm(2000, tmr.ALARM_SINGLE, function()print("reboot")node.restart()end)
 elseif tab.init=="get" then
  if (file.open("get_network.json","r")) then r = file.read('\n') file.close()end
 elseif tab.init=="auth" then r=auth(tab) end
 return r
end
