local result = {}
result[99] = function(msg)
    local dir = msg.scriptDir .. "BeerNode/"
    local specialMsg = live.MsgPacker.createSpecialGiftMsgFromNormalGiftMsg(msg, dir, "送你99杯啤酒")
    live.messageManager:pushSpecialGiftMessageFront(specialMsg) 
end
return result