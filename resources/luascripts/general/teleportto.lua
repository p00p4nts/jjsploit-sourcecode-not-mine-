local players = game:GetService("Players")
local targetName = _G.TeleportToTarget
local localPlayer = players.LocalPlayer
local targetPlayer = nil

-- Function to check for exact and partial matches
local function findPlayerByPriority(targetName)
    local exactUsernameMatch, exactDisplayNameMatch = nil, nil
    local partialUsernameMatch, partialDisplayNameMatch = nil, nil

    for _, player in pairs(players:GetPlayers()) do
        if player.Name == targetName then
            exactUsernameMatch = player
        elseif player.DisplayName == targetName then
            exactDisplayNameMatch = player
        elseif string.find(player.Name:lower(), targetName:lower()) then
            partialUsernameMatch = player
        elseif string.find(player.DisplayName:lower(), targetName:lower()) then
            partialDisplayNameMatch = player
        end
    end

    return exactUsernameMatch or exactDisplayNameMatch or partialUsernameMatch or partialDisplayNameMatch
end

-- Find the target player
targetPlayer = findPlayerByPriority(targetName)

-- Teleport if the target player is found
if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
    localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPlayer.Character.HumanoidRootPart.Position)
else
    warn("Target player not found or invalid!")
end