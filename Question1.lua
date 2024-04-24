--Q1 - Fix or improve the implementation of the below methods

-- Use constant variable to specify key's purpose
local login_key = 1000

-- Changed arguments to release storage of specified key.
function releaseStorage(player, key)
    player:setStorageValue(key, -1)
end

function onLogout(player)
    if player:getStorageValue(login_key) == 1 then
        addEvent(releaseStorage, 1000, player, login_key) --after one second, 
        return true --logout successful
    end
    return false --Player could not be found
end

