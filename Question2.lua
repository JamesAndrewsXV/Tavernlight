--Q2 - Fix or improve the implementation of the below method

function printSmallGuildNames(memberCount, db)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    local guildNames = {}

    while resultId
    do
        local name = resultId.getString("name")
        table.insert(guildNames, name) -- add guild names one by one to table
        resultId.next()
    end

    if #guildNames ~= 0 then -- Check to make sure program results are clear
        for index, guild in guildNames do
            print(guild)
        end
    else
        print("Guilds with less than " .. memberCount .. " members not found.")
    end
    

end