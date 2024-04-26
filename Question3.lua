--Q3 - Fix or improve the name and the implementation of the below method

function kickPartyMember(playerId, membername)
    -- Retrieve a valid player
    local player = Player(playerId)
    if player == nil then
        error("Player not found!")
        return false
    end

    -- Retrieve a valid party
    local party = player:getParty()
    if party == nil then
        error("Player is not in a party!")
        return false
    end

    for index, member in pairs(party:getMembers()) do
        if member:getName() == membername then
            party:removeMember(member)
            return true
        end
    end
    error("Party member not found!")
    return false
end
