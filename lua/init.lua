print("10 seconds wait")
tmr.alarm(0, 10000, tmr.ALARM_SINGLE, 
    function()
        dofile("Run.lua");           
    end
)

