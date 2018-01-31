tmr.alarm(0, delay, 1, 
    function()
        dofile("findChange.lua")
        dofile("OnOffDelay.lua")        
    end
)
