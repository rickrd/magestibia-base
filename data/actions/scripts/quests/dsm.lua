function onUse (player, cid,item,frompos,item2,topos)
	pos = {x=1053, y=1050, z=7}
	pos2 = getPlayerPosition(cid)
 
	if getPlayerLevel(cid) >= 50 then
		if item.uid == 45003 then
			queststatus = player:getStorageValue(55003)
			if queststatus == -1 then
				doPlayerSendTextMessage(cid,22,"Você encontrou uma Dragon Scale Mail.")
				doPlayerAddItem(cid,2492,1)
				doPlayerAddItem(cid,2160,2)
				setPlayerStorageValue(cid,55003,1)
				doSendMagicEffect(getThingPos(cid), 29)
			else
				doPlayerSendTextMessage(cid,22,"Você ja completou a quest.")
			end
		end
	else
		doPlayerSendCancel(cid,'Somente Level 50 para receber a recompensa.')
	end
return 1
end