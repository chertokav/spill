<<<<<<< HEAD
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

=======
>>>>>>> 4e4011cd0c0796307e57a388257007b51910d6e8
print("10 seconds wait")
tmr.alarm(0, 10000, tmr.ALARM_SINGLE, 
    function()
        dofile("Run.lua");           
    end
)

