--[=[
        @class Thread
        @author zionqyl
]=]

local RunService = game:GetService('RunService')
local Thread = {}

function Thread:Wait(t)
    if t ~= nil then
        local totalTime = 0
        totalTime = totalTime + RunService.Heartbeat:Wait()
        while totalTime < t do
            totalTime = totalTime + RunService.Heartbeat:Wait()
        end
    else
        RunService.Heartbeat:Wait()
    end
end

function Thread:Spawn(callback)
    local bindable = Instance.new('BindableEvent')
    bindable.Event:Connect(callback)
    bindable:Fire()
    bindable:Destroy()
end

function Thread:Delay(t, callback)
    self:Spawn(function()
        self:Wait(t)
        callback()
    end)
end

return Thread
