local data = {["Outputs"] = Outputs,
              ["OutputsManual"] = OutputsManual, 
              ["InputsValueOld"] = InputsValueOld, 
              ["InputsValue"] = InputsValue, 
              ["InputsOn"] = InputsOn, 
              ["InputsOnHigh"] = InputsOnHigh, 
              ["OnDelayValues"] = OnDelayValues, 
              ["OffDelayValues"] = OffDelayValues, 
              ["OutputsManualOld"] = OutputsManualOld}
local ok, json = pcall(sjson.encode, data)
if ok
then
  if file.open("SavedData.inp", "w+")
  then
       print("saveOutputs")
       file.write(json)
       file.close()
  end
else
  print("failed to encode!")
end