local table = {
    ["Widow Queen"] = {price = 30000, id = 1}, 
    ["Racing Bird"] = {price = 30000, id = 2}, 
    ["War Bear"] = {price = 3000, id = 3}, 
    ["Black Sheep"] = {price = 30000, id = 4}, 
    ["Midnight Panther"] = {price = 30000, id = 5}, 
    ["Draptor"] = {price = 300000, id = 6}, 
    ["Titanica"] = {price = 30000, id = 7}, 
    ["Tin Lizzard"] = {price = 30000, id = 8}, 
    ["Blazebringer"] = {price = 30000, id = 9}, 
    ["Rapid Boar"] = {price = 30000, id = 10}, 
    ["Stampor"] = {price = 30000, id = 11}, 
    ["Undead Cavebear"] = {price = 30000, id = 12}, 
["Donkey"] = {price = 30000, id = 13}, 
["Tiger Slug"] = {price = 30000, id = 14}, 
["Uniwheel"] = {price = 30000, id = 15}, 
["Crystal Wolf"] = {price = 30000, id = 16}, 
["War Horse"] = {price = 30000, id = 17}, 
["Kingly Deer"] = {price = 30000, id = 18}, 
["Tamed Panda"] = {price = 30000, id = 19}, 
["Dromedary"] = {price = 30000, id = 20}, 
["Sandstone Scorpion"] = {price = 30000, id = 21}, 
["Rented Horse"] = {price = 30000, id = 22}, 
["Fire War Horse"] = {price = 30000, id = 23}, 
["Shadow Draptor"] = {price = 30000, id = 24}, 
["Rented Horse"] = {price = 30000, id = 25}, 
["Rented Horse"] = {price = 30000, id = 26}, 
["Ladybug"] = {price = 30000, id = 27}, 
["Manta"] = {price = 30000, id = 28}, 
["Ironblight"] = {price = 30000, id = 29}, 
["Magma Crawler"] = {price = 30000, id = 30}, 
["Dragonling"] = {price = 30000, id = 31}, 
["Gnarlhound"] = {price = 30000, id = 32}, 
["Red Manta"] = {price = 30000, id = 33}, 
["Mechanical Bird"] = {price = 30000, id = 34}, 
["Water Buffalo"] = {price = 30000, id = 35},
["Armoured Scorpion"] = {price = 30000, id = 36}, 
["Armoured Dragonling"] = {price = 30000, id = 37},
["Armoured Cavebear"] = {price = 30000, id = 38},
["The Hellgrip"] = {price = 30000, id = 39},
["Lion"] = {price = 30000, id = 40},
["Golden Lion"] = {price = 30000, id = 41},
["Shock Head"] = {price = 30000, id = 42},
} 
local keywordHandler = KeywordHandler:new() 
local npcHandler = NpcHandler:new(keywordHandler) 
NpcSystem.parseParameters(npcHandler) 
local talkState = {} 

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end 
function onCreatureDisappear(cid)          npcHandler:onCreatureDisappear(cid)        end 
function onCreatureSay(cid, type, msg)          npcHandler:onCreatureSay(cid, type, msg)        end 
function onThink()                  npcHandler:onThink()                    end

function creatureSayCallback(cid, type, msg) 
    if(not npcHandler:isFocused(cid)) then 
        return false 
    end 

    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid 
    if table[msg] then 
      local t = table[msg] 
      talkState[talkUser] = 1 
      if getPlayerPremiumDays(cid) >= 1 then 
        if not getPlayerMount(cid, t.id) then 
        if doPlayerRemoveMoney(cid, t.price) then 
          doPlayerAddMount(cid, t.id) 
          selfSay("You lost "..t.price.." gp! for mount!", cid)
          talkState[talkUser] = 0 
        else 
          selfSay("Sorry, you do not have enough money!", cid) 
          talkState[talkUser] = 0 
        end 
        else 
        selfSay("You already have this mount!", cid) 
        talkState[talkUser] = 0 
        end 
      else 
        selfSay("You must be Premium!", cid) 
        talkState[talkUser] = 0 
      end 
    else 
    selfSay('What? Please told me a correct name of mount!', cid) 
    talkState[talkUser] = 0 
  end 
  return true 
end 

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback) 
npcHandler:addModule(FocusModule:new())