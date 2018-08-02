local result = {}
result[66] = function(msg)
    local dir = msg.scriptDir .. "GlassNode/"
    local specialMsg = live.MsgPacker.createSpecialGiftMsgFromNormalGiftMsg(msg, dir, "送你66块板砖")
    live.messageManager:pushSpecialGiftMessageFront(specialMsg) 
end
return result