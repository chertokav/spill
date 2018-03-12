local ok, json = pcall(sjson.encode, InputSet)
if ok 
then
  if file.open("params.inp", "w+") 
  then  
       -- print("save")
       file.write(json)
       file.close()
  end
else
  print("failed to encode!")
end
