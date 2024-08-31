--[=[
        @class Serverhop
        @author zionqyl
]=]

local Players = game:GetService('Players')
local HttpService = game:GetService('HttpService')
local TeleportService = game:GetService('TeleportService')

httprequest = (http and http.request) or http_request or (fluxus and fluxus.request) or request

return function()
    if httprequest then
        local servers = {}
        local req = httprequest({ Url = string.format('https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true', game.PlaceId) })
        local body = HttpService:JSONDecode(req.Body)
        if body and body.data then
            for i, v in next, body.data do
                if typeof(v) == 'table' and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(#servers)], Players.LocalPlayer)
        end
    end
end
