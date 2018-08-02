local result = {}
result[66] = function(msg)
    local dir = msg.scriptDir .. "Great666Node/"
    local specialMsg = live.MsgPacker.createSpecialGiftMsgFromNormalGiftMsg(msg, dir, "送你666")
    live.messageManager:pushSpecialGiftMessageFront(specialMsg) 
end
return result