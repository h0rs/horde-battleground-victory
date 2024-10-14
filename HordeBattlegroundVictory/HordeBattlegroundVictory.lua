local frame = CreateFrame("Frame")

-- Function to handle battlefield/arena win and zone change
local function OnEvent(self, event, ...)
    if event == "UPDATE_BATTLEFIELD_STATUS" then
        print("Event: UPDATE_BATTLEFIELD_STATUS triggered")
        
        for i = 1, GetMaxBattlefieldID() do
            local status, mapName, instanceID, _, _, teamSize, isRanked, battleID, isArena = GetBattlefieldStatus(i)
            -- print("Checking battlefield ID:", i)
            -- print("Status:", status, "Map Name:", mapName, "Instance ID:", instanceID, "Team Size:", teamSize, "Is Ranked:", isRanked, "Is Arena:", isArena)

            if status == "active" then
                -- Check for winner regardless of status
                local winner = GetBattlefieldWinner()

                if winner then
                    -- print("Winner found:", winner)
                    -- Get player's faction (1 = Alliance, 0 = Horde)
                    local playerFaction = UnitFactionGroup("player") == "Horde" and 0 or 1
                    -- print("Player faction:", playerFaction)

                    -- Play victory sound if the player's team won
                    if winner == playerFaction then
                        -- print("Player's team won. Playing victory sound...")
                        PlaySound(8454)
                    else
                        -- print("Player's team lost.")
                    end
                else
                    -- print("No winner found yet.")
                end
            end
        end
    end
end

-- Register for events when battlefield/arena status updates
frame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
frame:SetScript("OnEvent", OnEvent)
