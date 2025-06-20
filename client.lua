local prompts = GetRandomIntInRange(0, 0xffffff)

local Core = exports.vorp_core:GetCore()

local working = false
local hasPackage = false
local MarkerPosition = 0

local progressbar = exports.vorp_progressbar:initiate()

local Animations = exports.vorp_animations.initiate()

local PlayerIsRestricted = false
local PlayerIsPermitted = false

local disableSprintandJump = false

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
StartNPCs()-- NPC loads after selecting character
end)

function StartNPCs()
    for i, v in ipairs(Config.NPCs) do
        local x, y, z = table.unpack(v.coords)
        -- Loading Model
        local hashModel = GetHashKey(v.npcmodel)
        if IsModelValid(hashModel) then
            RequestModel(hashModel)
            while not HasModelLoaded(hashModel) do
                Wait(100)
            end
        else
            print(v.npcmodel .. " is not valid")
        end
        -- Spawn NPC Ped
        local npc = CreatePed(hashModel, x, y, z, v.heading, false, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, npc, true) -- SetRandomOutfitVariation
        SetEntityNoCollisionEntity(PlayerPedId(), npc, false)
        SetEntityCanBeDamaged(npc, false)
        SetEntityInvincible(npc, true)
        Wait(1000)
        FreezeEntityPosition(npc, true) -- NPC can't escape
        SetBlockingOfNonTemporaryEvents(npc, true) -- NPC can't be scared
        --create blip
        if v.blip ~= 0 then
            local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, x, y, z)
            SetBlipSprite(blip, v.blip, true)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.npc_name)
        end
    end
end

Citizen.CreateThread(function() --create talk to npc prompt
    Citizen.Wait(5000)
    local press = Config.Language.press
    talktonpc = PromptRegisterBegin()
    PromptSetControlAction(talktonpc, Config.keys["G"])
    press = CreateVarString(10, 'LITERAL_STRING', press)
    PromptSetText(talktonpc, press)
    PromptSetEnabled(talktonpc, 1)
    PromptSetVisible(talktonpc, 1)
    PromptSetStandardMode(talktonpc, 1)
    PromptSetHoldMode(talktonpc, 1)
    PromptSetGroup(talktonpc, prompts)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, talktonpc, true)
    PromptRegisterEnd(talktonpc)
end)

Citizen.CreateThread(function()
    while true do
        local sleep = true
        local _source = source
        for i, v in ipairs(Config.NPCs) do
            local playerCoords = GetEntityCoords(PlayerPedId())
            if Vdist(playerCoords, v.coords) <= v.radius then -- Checking distance between player and npc
                if v.type ~= "nointeraction" then
                    sleep = false
                    local label = CreateVarString(10, 'LITERAL_STRING', Config.Language.talk)
                    PromptSetActiveGroupThisFrame(prompts, label)
                    if Citizen.InvokeNative(0xC92AC953F0A982AE, talktonpc) then --if pressing the interaction-key
                        local playerPed = PlayerPedId()
                        FreezeEntityPosition(playerPed,true)
                        if v.type == "jobinteraction" then
                            if Config.applyJobSpecifications == true then --when job restrictions are turned on
                                TriggerServerEvent("juSa_carrier_job:checkJob")
                                Wait(500)
                                if PlayerIsRestricted == false and PlayerIsPermitted == true then
                                    if working == false then
                                        working = true
                                        TaskStartScenarioInPlace(playerPed, GetHashKey("WORLD_HUMAN_BADASS"), Config.taskbar, true, false, false, false) --Taskbar-Animation (change the text in "" if u want to have another animation instead)
                                        progressbar.start(Config.Language.task_clocking_in, Config.taskbar,function ()end, 'linear')
                                        Citizen.Wait(Config.taskbar)
                                        TriggerEvent('vorp:NotifyLeft', Config.Language.jobname, Config.Language.clocked_in, "BLIPS", "blip_chest", 4000, "COLOR_GREEN")
                                        MarkerPosition = math.random(6)
                                        Citizen.Wait(500)
                                        Core.NotifyRightTip(Config.Language.get_package,10000)
                                    else
                                        working = false
                                        TaskStartScenarioInPlace(playerPed, GetHashKey("WORLD_HUMAN_BADASS"), Config.taskbar, true, false, false, false) --Taskbar-Animation (change the text in "" if u want to have another animation instead)
                                        progressbar.start(Config.Language.task_clocking_out, Config.taskbar,function ()end, 'linear')
                                        Citizen.Wait(Config.taskbar)
                                        TriggerEvent('vorp:NotifyLeft', Config.Language.jobname, Config.Language.clocked_out, "BLIPS", "blip_destroy", 4000, "COLOR_RED")
                                        MarkerPosition = 0
                                        Citizen.Wait(500)
                                        hasPackage = false
                                        Animations.endAnimation("carry_box")
                                    end
                                else
                                    TriggerEvent('vorp:NotifyLeft', Config.Language.jobname, Config.Language.notallowed, "BLIPS", "blip_destroy", 4000, "COLOR_RED")
                                end
                            else
                                if working == false then
                                    working = true
                                    TaskStartScenarioInPlace(playerPed, GetHashKey("WORLD_HUMAN_BADASS"), Config.taskbar, true, false, false, false) --Taskbar-Animation (change the text in "" if u want to have another animation instead)
                                    progressbar.start(Config.Language.task_clocking_in, Config.taskbar,function ()end, 'linear')
                                    Citizen.Wait(Config.taskbar)
                                    TriggerEvent('vorp:NotifyLeft', Config.Language.jobname, Config.Language.clocked_in, "BLIPS", "blip_chest", 4000, "COLOR_GREEN")
                                    MarkerPosition = math.random(6)
                                    Citizen.Wait(500)
                                    Core.NotifyRightTip(Config.Language.get_package,10000)
                                else
                                    working = false
                                    TaskStartScenarioInPlace(playerPed, GetHashKey("WORLD_HUMAN_BADASS"), Config.taskbar, true, false, false, false) --Taskbar-Animation (change the text in "" if u want to have another animation instead)
                                    progressbar.start(Config.Language.task_clocking_out, Config.taskbar,function ()end, 'linear')
                                    Citizen.Wait(Config.taskbar)
                                    TriggerEvent('vorp:NotifyLeft', Config.Language.jobname, Config.Language.clocked_out, "BLIPS", "blip_destroy", 4000, "COLOR_RED")
                                    MarkerPosition = 0
                                    Citizen.Wait(500)
                                    hasPackage = false
                                    Animations.endAnimation("carry_box")
                                end
                            end
                        end
                        ClearPedTasks(playerPed)
                        FreezeEntityPosition(playerPed,false)
                        PlayerIsRestricted = false
                        PlayerIsPermitted = false
                        Wait(500)
                        Citizen.Wait(1000)
                    end
                end
            end
        end
        if Config.disallow_sprint_and_jump then
            if disableSprintandJump then
                if IsPedSprinting(PlayerPedId()) then  
                    Citizen.InvokeNative(0xAE99FB955581844A, PlayerPedId(), 1500, 2000, 0, false, false, false)
                    if Config.show_disallow_tip then
                        Core.NotifyRightTip(Config.Language.dontRun, 4000)
                    end
                    Wait(2500)
                    Animations.startAnimation("carry_box") --set carrying box anim again after fall
                elseif IsPedJumping(PlayerPedId()) then
                    Citizen.InvokeNative(0xAE99FB955581844A, PlayerPedId(), 1500, 2000, 0, false, false, false)
                    if Config.show_disallow_tip then
                        Core.NotifyRightTip(Config.Language.dontJump, 4000)
                    end
                    Wait(2500)
                    Animations.startAnimation("carry_box") --set carrying box anim again after fall
                end
            end
        end
        if sleep then
            Citizen.Wait(500)
        end
        Citizen.Wait(1)
    end
end)

RegisterNetEvent('juSa_carrier_job:jobchecked')
AddEventHandler('juSa_carrier_job:jobchecked', function(isrestricted, ispermitted)
    if isrestricted then
        PlayerIsRestricted = true
    elseif ispermitted then
        PlayerIsPermitted = true
    end
end)

-- draw markers
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        if MarkerPosition == 1 then --pickup location 1
            local x, y, z = table.unpack(Config.Marker_1_coords)
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, x, y, z, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if Vdist(playerCoords, Config.Marker_1_coords) <= 2 and hasPackage == false then
                hasPackage = true
                pickupPackage()
            end
        
        elseif MarkerPosition == 2 then --pickup location 2
            local x, y, z = table.unpack(Config.Marker_2_coords)
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, x, y, z, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if Vdist(playerCoords, Config.Marker_2_coords) <= 2 and hasPackage == false then
                hasPackage = true
                pickupPackage()
            end

        elseif MarkerPosition == 3 then --pickup location 3
            local x, y, z = table.unpack(Config.Marker_3_coords)
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, x, y, z, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if Vdist(playerCoords, Config.Marker_3_coords) <= 2 and hasPackage == false then
                hasPackage = true
                pickupPackage()
            end

        elseif MarkerPosition == 4 then --pickup location 4
            local x, y, z = table.unpack(Config.Marker_4_coords)
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, x, y, z, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if Vdist(playerCoords, Config.Marker_4_coords) <= 2 and hasPackage == false then
                hasPackage = true
                pickupPackage()
            end

        elseif MarkerPosition == 5 then --pickup location 5
            local x, y, z = table.unpack(Config.Marker_5_coords)
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, x, y, z, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if Vdist(playerCoords, Config.Marker_5_coords) <= 2 and hasPackage == false then
                hasPackage = true
                pickupPackage()
            end

        elseif MarkerPosition == 6 then --pickup location 6
            local x, y, z = table.unpack(Config.Marker_6_coords)
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, x, y, z, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if Vdist(playerCoords, Config.Marker_6_coords) <= 2 and hasPackage == false then
                hasPackage = true
                pickupPackage()
            end

        elseif MarkerPosition == 9 then --storage location
            local x, y, z = table.unpack(Config.Marker_9_coords)
            local playerPed = PlayerPedId()
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, x, y, z, 0, 0, 0, 0, 0, 0, 2.5, 2.5, 1.5, 206, 45, 45, 120, 0, 0, 2, 0, 0, 0, 0)
            if Vdist(playerCoords, Config.Marker_9_coords) <= 2 and hasPackage == true then
                hasPackage = false
                Animations.endAnimation("carry_box")
                ClearPedTasksImmediately(PlayerPedId())
                ResetPlayerInputGait(PlayerPedId())
                TaskStartScenarioInPlace(playerPed, GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), Config.taskbar, true, false, false, false)
                progressbar.start(Config.Language.deliv_package, Config.taskbar,function ()end, 'linear')
                Citizen.Wait(Config.taskbar)
                TriggerServerEvent('juSa_carrier_job:givereward')
                ClearPedTasksImmediately(PlayerPedId())
                ResetPlayerInputGait(PlayerPedId())
                MarkerPosition = math.random(6) --new random markerposition/pickup location
                messagenextpackage()
                disableSprintandJump = false
            end
        end
    end
end)

function pickupPackage()
    if hasPackage == true then
        ClearPedTasksImmediately(PlayerPedId())
        ResetPlayerInputGait(PlayerPedId())
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), Config.taskbar, true, false, false, false)
        progressbar.start(Config.Language.picking_package, Config.taskbar,function ()end, 'linear')
        Citizen.Wait(Config.taskbar)
        Animations.startAnimation("carry_box")
        disableSprintandJump = true
        Core.NotifyRightTip(Config.Language.bring_package,10000)
        MarkerPosition = 9
    end
end

function messagenextpackage()
    Citizen.Wait(1500)
    Core.NotifyRightTip(Config.Language.get_package,10000)
end

function Anim(actor, dict, body, duration, flags, introtiming, exittiming)
    Citizen.CreateThread(function()
        RequestAnimDict(dict)
        local dur = duration or -1
        local flag = flags or 1
        local intro = tonumber(introtiming) or 1.0
        local exit = tonumber(exittiming) or 1.0
        timeout = 5
        while (not HasAnimDictLoaded(dict) and timeout>0) do
            timeout = timeout-1
            if timeout == 0 then
                print("Animation Failed to Load")
            end
            Citizen.Wait(300)
        end
        TaskPlayAnim(actor, dict, body, intro, exit, dur, flag--[[1 for repeat--]], 1, false, false, false, 0, true)
    end)
end
