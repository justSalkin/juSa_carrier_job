VorpCore = {}
local VorpInv = exports.vorp_inventory:vorp_inventoryApi()
-- local VORP_API = exports.vorp_core:vorpAPI()

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent('juSa_carrier_job:checkJob')
AddEventHandler('juSa_carrier_job:checkJob', function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
    local grade = Character.jobGrade
    local isrestricted = false
    local ispermitted = false
    
    if #Config.jobRestriction > 0 then
        for i, v in ipairs(Config.jobRestriction) do
            if v.name == job then
                if v.grade >= grade then
                    isrestricted = true
                end
            end
        end
    end
    
    if #Config.jobPermission > 0 then
        for i, v in ipairs(Config.jobPermission) do
            if v.name == job then
                if v.grade <= grade then
                    ispermitted = true
                end
            end
        end
    else 
        ispermitted = true
    end

    TriggerClientEvent("juSa_carrier_job:jobchecked", _source, isrestricted, ispermitted)
end)

RegisterServerEvent("juSa_carrier_job:givereward")
AddEventHandler("juSa_carrier_job:givereward", function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local giveitem = false
    local givemoney = false

    selectReward = math.random(100) -- select if give money or give item
    if selectReward <= Config.Chance then
        giveitem = true
    else
        givemoney = true
    end

    if giveitem == true then -- giving item reward
        local FinalLoot = LootToGive(_source)
        local User = VorpCore.getUser(_source).getUsedCharacter
        for k,v in pairs(Config.reward) do
            if v.item == FinalLoot then
                local amount = math.random(v.rewardmin, v.rewardmax)
                VorpInv.addItem(_source, FinalLoot, amount)
                LootsToGive = {}
                TriggerClientEvent("vorp:TipRight", _source, "" ..Config.Language.reward.. " " ..amount.. "x " ..v.name.. "." , 4000)
            end
        end

    elseif givemoney == true then --giving money reward
        local moneyreward_10 = math.random(Config.moneyrewardmin, Config.moneyrewardmax)
        moneyreward = moneyreward_10/10
        Character.addCurrency(0, moneyreward)
        TriggerClientEvent("vorp:TipRight", _source, "" ..Config.Language.reward.. " " ..moneyreward.. "$ ." , 4000)
    end
end)

function LootToGive(_source)
	local LootsToGive = {}
	for k,v in pairs(Config.reward) do
		table.insert(LootsToGive,v.item)
	end

	if LootsToGive[1] ~= nil then
		local value = math.random(1,#LootsToGive)
		local picked = LootsToGive[value]
		return picked
	end
end