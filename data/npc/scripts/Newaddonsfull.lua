local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)


function onCreatureAppear(cid)                npcHandler:onCreatureAppear(cid)             end
function onCreatureDisappear(cid)             npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)         npcHandler:onCreatureSay(cid, type, msg)     end
function onThink()                             npcHandler:onThink()                         end

npcHandler:setMessage(MESSAGE_GREET, "Greetings |PLAYERNAME|. Here you can purchase {addons} with the money you earn by killing other players.")

function playerBuyAddonNPC(cid, message, keywords, parameters, node)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
    if (parameters.confirm ~= true) and (parameters.decline ~= true) then
        if(getPlayerPremiumDays(cid) == 0) and (parameters.premium == true) then
            npcHandler:say('Sorry, but this addon is only for premium players!', cid)
            npcHandler:resetNpc()
            return true
        end
        if (getPlayerStorageValue(cid, parameters.storageID) ~= -1) then
            npcHandler:say('You already have this addon!', cid)
            npcHandler:resetNpc()
            return true
        end
        local itemsTable = parameters.items
        local items_list = ''
        if table.maxn(itemsTable) > 0 then
            for i = 1, table.maxn(itemsTable) do
                local item = itemsTable[i]
                items_list = items_list .. item[2] .. ' ' .. getItemNameById(item[1])
                if i ~= table.maxn(itemsTable) then
                    items_list = items_list .. ', '
                end
            end
        end
        local text = ''
        if (parameters.cost > 0) and table.maxn(parameters.items) then
            text = items_list .. ' and ' .. parameters.cost .. ' gp'
        elseif (parameters.cost > 0) then
            text = parameters.cost .. ' gp'
        elseif table.maxn(parameters.items) then
            text = items_list
        end
        npcHandler:say('Did you bring me ' .. text .. ' for ' .. keywords[1] .. '?', cid)
        return true
    elseif (parameters.confirm == true) then
        local addonNode = node:getParent()
        local addoninfo = addonNode:getParameters()
        local items_number = 0
        if table.maxn(addoninfo.items) > 0 then
            for i = 1, table.maxn(addoninfo.items) do
                local item = addoninfo.items[i]
                if (getPlayerItemCount(cid,item[1]) >= item[2]) then
                    items_number = items_number + 1
                end
            end
        end
        if(getPlayerMoney(cid) >= addoninfo.cost) and (items_number == table.maxn(addoninfo.items)) then
            doPlayerRemoveMoney(cid, addoninfo.cost)
            if table.maxn(addoninfo.items) > 0 then
                for i = 1, table.maxn(addoninfo.items) do
                    local item = addoninfo.items[i]
                    doPlayerRemoveItem(cid,item[1],item[2])
                end
            end
            doPlayerAddOutfit(cid, addoninfo.outfit_male, addoninfo.addon)
            doPlayerAddOutfit(cid, addoninfo.outfit_female, addoninfo.addon)
            setPlayerStorageValue(cid,addoninfo.storageID,1)
            npcHandler:say('Here you are.', cid)
        else
            npcHandler:say('You do not have needed cash!', cid)
        end
        npcHandler:resetNpc()
        return true
    elseif (parameters.decline == true) then
        npcHandler:say('Not interested? Maybe another addon?', cid)
        npcHandler:resetNpc()
        return true
    end
    return false
end

local noNode = KeywordNode:new({'no'}, playerBuyAddonNPC, {decline = true})
local yesNode = KeywordNode:new({'yes'}, playerBuyAddonNPC, {confirm = true})

-- citizen (done)
local outfit_node = keywordHandler:addKeyword({'first citizen addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, items = {}, outfit_female = 136, outfit_male = 128, addon = 1, storageID = 10001})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second citizen addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 136, outfit_male = 128, addon = 2, storageID = 10002})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- hunter (done)
local outfit_node = keywordHandler:addKeyword({'first hunter addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 137, outfit_male = 129, addon = 1, storageID = 10003})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second hunter addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 137, outfit_male = 129, addon = 2, storageID = 10004})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- knight (done)
local outfit_node = keywordHandler:addKeyword({'first knight addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 139, outfit_male = 131, addon = 1, storageID = 10005})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second knight addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 139, outfit_male = 131, addon = 2, storageID = 10006})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- mage (done)
local outfit_node = keywordHandler:addKeyword({'first mage addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 138, outfit_male = 130, addon = 1, storageID = 10005}) 
outfit_node:addChildKeywordNode(yesNode) 
outfit_node:addChildKeywordNode(noNode) 
local outfit_node = keywordHandler:addKeyword({'second mage addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 138, outfit_male = 130, addon = 2, storageID = 10006}) 
outfit_node:addChildKeywordNode(yesNode) 
outfit_node:addChildKeywordNode(noNode) 


-- summoner (done)
local outfit_node = keywordHandler:addKeyword({'first summoner addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 141, outfit_male = 133, addon = 1, storageID = 10009}) 
outfit_node:addChildKeywordNode(yesNode) 
outfit_node:addChildKeywordNode(noNode) 
local outfit_node = keywordHandler:addKeyword({'second summoner addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 141, outfit_male = 133, addon = 2, storageID = 10010}) 
outfit_node:addChildKeywordNode(yesNode) 
outfit_node:addChildKeywordNode(noNode) 


-- barbarian (done)
local outfit_node = keywordHandler:addKeyword({'first barbarian addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 147, outfit_male = 143, addon = 1, storageID = 10011})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second barbarian addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 147, outfit_male = 143, addon = 2, storageID = 10012})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- druid (done)
local outfit_node = keywordHandler:addKeyword({'first druid addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 148, outfit_male = 144, addon = 1, storageID = 10013})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second druid addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 148, outfit_male = 144, addon = 2, storageID = 10014})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- nobleman (done)
local outfit_node = keywordHandler:addKeyword({'first nobleman addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, items = {}, outfit_female = 140, outfit_male = 132, addon = 1, storageID = 10015})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second nobleman addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, items = {}, outfit_female = 140, outfit_male = 132, addon = 2, storageID = 10016})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- oriental (done)
local outfit_node = keywordHandler:addKeyword({'first oriental addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 150, outfit_male = 146, addon = 1, storageID = 10017})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second oriental addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 150, outfit_male = 146, addon = 2, storageID = 10018})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- warrior (done)
local outfit_node = keywordHandler:addKeyword({'first warrior addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 142, outfit_male = 134, addon = 1, storageID = 10019})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second warrior addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 142, outfit_male = 134, addon = 2, storageID = 10020})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- wizard (done)
local outfit_node = keywordHandler:addKeyword({'first wizard addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 149, outfit_male = 145, addon = 1, storageID = 10021})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second wizard addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 149, outfit_male = 145, addon = 2, storageID = 10022})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- assassin (done)
local outfit_node = keywordHandler:addKeyword({'first assassin addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 156, outfit_male = 152, addon = 1, storageID = 10023})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second assassin addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 156, outfit_male = 152, addon = 2, storageID = 10024})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- beggar (done)
local outfit_node = keywordHandler:addKeyword({'first beggar addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 157, outfit_male = 153, addon = 1, storageID = 10025})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second beggar addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 157, outfit_male = 153, addon = 2, storageID = 10026})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- pirate (done)
local outfit_node = keywordHandler:addKeyword({'first pirate addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 155, outfit_male = 151, addon = 1, storageID = 10027})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second pirate addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 155, outfit_male = 151, addon = 2, storageID = 10028})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- shaman (done)
local outfit_node = keywordHandler:addKeyword({'first shaman addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 158, outfit_male = 154, addon = 1, storageID = 10029})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second shaman addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 158, outfit_male = 154, addon = 2, storageID = 10030})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- norseman (done)
local outfit_node = keywordHandler:addKeyword({'first norseman addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 252, outfit_male = 251, addon = 1, storageID = 10031})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second norseman addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 252, outfit_male = 251, addon = 2, storageID = 10032})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- jester (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first jester addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 270, outfit_male = 273, addon = 1, storageID = 10033})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second jester addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 270, outfit_male = 273, addon = 2, storageID = 10034})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- demonhunter (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first demonhunter addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 288, outfit_male = 289, addon = 1, storageID = 10035})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second demonhunter addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 288, outfit_male = 289, addon = 2, storageID = 10036})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- nightmare (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first nightmare addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 269, outfit_male = 268, addon = 1, storageID = 10037})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second nightmare addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 269, outfit_male = 268, addon = 2, storageID = 10038})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- brotherhood (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first brotherhood addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 279, outfit_male = 278, addon = 1, storageID = 10039})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second brotherhood addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 279, outfit_male = 278, addon = 2, storageID = 10040})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- yalaharian (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first yalaharian addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 324, outfit_male = 325, addon = 1, storageID = 10041})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second yalaharian addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 324, outfit_male = 325, addon = 2, storageID = 10042})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- warmaster (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first warmaster addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 336, outfit_male = 335, addon = 1, storageID = 10043})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second warmaster addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 336, outfit_male = 335, addon = 2, storageID = 10044})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- wayfarer (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first wayfarer addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 366, outfit_male = 367, addon = 1, storageID = 10045})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second wayfarer addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 366, outfit_male = 367, addon = 2, storageID = 10046})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)


-- afflicted (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first afflicted addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 431, outfit_male = 430, addon = 1, storageID = 10047})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second afflicted addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 431, outfit_male = 430, addon = 2, storageID = 10048})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- elementalist (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first elementalist addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 433, outfit_male = 432, addon = 1, storageID = 10049})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second elementalist addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 433, outfit_male = 432, addon = 2, storageID = 10050})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- deepling (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first deepling addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 464, outfit_male = 463, addon = 1, storageID = 10051})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second deepling addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 464, outfit_male = 463, addon = 2, storageID = 10052})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- insectoid (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first insectoid addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 466, outfit_male = 465, addon = 1, storageID = 10053})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second insectoid addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 466, outfit_male = 465, addon = 2, storageID = 10054})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- entrepreneur (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first entrepreneur addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 471, outfit_male = 472, addon = 1, storageID = 10055})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second entrepreneur addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 471, outfit_male = 472, addon = 2, storageID = 10056})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- crystal warlord (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first crystal warlord addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 513, outfit_male = 512, addon = 1, storageID = 10057})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second crystal warlord addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 513, outfit_male = 512, addon = 2, storageID = 10058})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- soil guardian (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first soil guardian addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 514, outfit_male = 516, addon = 1, storageID = 10059})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second soil guardian addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 514, outfit_male = 516, addon = 2, storageID = 10060})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- demon (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first demon addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 542, outfit_male = 541, addon = 1, storageID = 10061})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second demon addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 542, outfit_male = 541, addon = 2, storageID = 10062})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- cave explorer (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first cave explorer addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 575, outfit_male = 574, addon = 1, storageID = 10063})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second cave explorer addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 575, outfit_male = 574, addon = 2, storageID = 10064})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)

-- dream warden (done)(custom)
local outfit_node = keywordHandler:addKeyword({'first dream warden addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 578, outfit_male = 577, addon = 1, storageID = 10065})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)
local outfit_node = keywordHandler:addKeyword({'second dream warden addon'}, playerBuyAddonNPC, {premium = true, cost = 10000, items = {}, outfit_female = 578, outfit_male = 577, addon = 2, storageID = 10066})
    outfit_node:addChildKeywordNode(yesNode)
    outfit_node:addChildKeywordNode(noNode)


keywordHandler:addKeyword({'addons'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can give you citizen, hunter, knight, mage, nobleman, summoner, warrior, barbarian, druid, wizard, oriental, pirate, assassin, beggar, shaman, norseman, nighmare, jester, yalaharian,brotherhood,warmaster,wayfarer, afflicted, elementalist, deepling, insectoid, entrepreneur, crystal warlord, soil guardian, demon, cave explorer, dream warden, addons.'})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'To buy the first addon say \'first NAME addon\', for the second addon say \'second NAME addon\'.'})

npcHandler:addModule(FocusModule:new())