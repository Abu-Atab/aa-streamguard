local Config = {
    enabled = true,

    tickMs = 150,

    speedThreshold = 18.0, -- m/s (~65 km/h)
    minLookAhead = 60.0,
    maxLookAhead = 220.0,
    loadRadius = 140.0,

    rescueEnabled = true,
    rescueCheckMs = 250,
    rescueMinFallVelZ = -12.0,
    rescueDropBelowLastGood = 22.0,
}

local function clamp(v, a, b)
    if v < a then return a end
    if v > b then return b end
    return v
end

local function lookAheadDist(speed)
    local t = clamp((speed - Config.speedThreshold) / 35.0, 0.0, 1.0)
    return Config.minLookAhead + (Config.maxLookAhead - Config.minLookAhead) * t
end

local lastGood = { ok = false, x = 0.0, y = 0.0, z = 0.0, veh = 0 }

local function preloadAhead(veh)
    local speed = GetEntitySpeed(veh)
    if speed < Config.speedThreshold then return end

    local c = GetEntityCoords(veh)
    local f = GetEntityForwardVector(veh)
    local dist = lookAheadDist(speed)

    local ax = c.x + f.x * dist
    local ay = c.y + f.y * dist
    local az = c.z + 8.0

    RequestCollisionAtCoord(ax, ay, az)
    RequestAdditionalCollisionAtCoord(ax, ay, az)
    NewLoadSceneStartSphere(ax, ay, az, Config.loadRadius, 0)
end

local function stopScene()
    if IsNewLoadSceneActive() then
        NewLoadSceneStop()
    end
end

local function updateLastGood(veh)
    local c = GetEntityCoords(veh)
    local ok, gz = GetGroundZFor_3dCoord(c.x, c.y, c.z + 80.0, false)
    if ok then
        lastGood.ok = true
        lastGood.x, lastGood.y, lastGood.z = c.x, c.y, gz + 1.5
        lastGood.veh = veh
    end
end

local function rescueIfNeeded(veh)
    if not Config.rescueEnabled then return end
    if not lastGood.ok or lastGood.veh ~= veh then return end

    local c = GetEntityCoords(veh)
    local vz = select(3, table.unpack(GetEntityVelocity(veh)))

    if vz < Config.rescueMinFallVelZ and c.z < (lastGood.z - Config.rescueDropBelowLastGood) then
        FreezeEntityPosition(veh, true)
        SetEntityCoordsNoOffset(veh, lastGood.x, lastGood.y, lastGood.z, false, false, false)
        SetEntityVelocity(veh, 0.0, 0.0, 0.0)
        Wait(150)
        FreezeEntityPosition(veh, false)
    end
end

CreateThread(function()
    while true do
        if not Config.enabled then
            stopScene()
            Wait(1000)
        else
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                local veh = GetVehiclePedIsIn(ped, false)
                if GetPedInVehicleSeat(veh, -1) == ped then
                    preloadAhead(veh)
                end
            else
                stopScene()
            end
            Wait(Config.tickMs)
        end
    end
end)

CreateThread(function()
    while true do
        if Config.enabled and Config.rescueEnabled then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                local veh = GetVehiclePedIsIn(ped, false)
                if GetPedInVehicleSeat(veh, -1) == ped then
                    updateLastGood(veh)
                    rescueIfNeeded(veh)
                else
                    lastGood.ok = false
                    lastGood.veh = 0
                end
            else
                lastGood.ok = false
                lastGood.veh = 0
            end
        end
        Wait(Config.rescueCheckMs)
    end
end)
