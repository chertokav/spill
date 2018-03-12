  local function settings(level, pulse2)
    print("Settings mode")
    dofile("setup.lua")
    tmr.stop(0)
  end
  
  gpio.mode(3, gpio.INT)
  gpio.trig(3, "down", settings)

  

  function settings2(level, pulse2)
    print("cli2")
  end

print("10 seconds wait")
tmr.alarm(0, 10000, tmr.ALARM_SINGLE, 
    function()
        dofile("Run.lua");           
    end
)

