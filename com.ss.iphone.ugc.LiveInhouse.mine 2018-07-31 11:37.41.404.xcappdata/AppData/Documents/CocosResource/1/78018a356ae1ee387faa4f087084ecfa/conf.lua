local result = {}
result[999] = function(msg)
    local dir = msg.scriptDir .. "Roses999Node/"
    local specialMsg = live.MsgPacker.createSpecialGiftMsgFromNormalGiftMsg(msg, dir, "送你999朵玫瑰")
    live.messageManager:pushSpecialGiftMessageFront(specialMsg) 
end
result[520] = function(msg, node)
    local rose520 = dofile(msg.scriptDir .. "Roses520Node/Roses520Node.lua"):create(node, msg)
    rose520:addTo(node, 100)
        :align(cc.p(0, 0), node._giftNode._giftIconNode:getPositionX() -50, -50)
    rose520:runAction(cc.Sequence:create({
        cc.CallFunc:create(function()
            node._giftNode._giftIconNode:setOpacity(0)--将原来的图标隐藏
            node._specialActionPlaying  = true
        end),
        cc.DelayTime:create(3),
        cc.CallFunc:create(function(el)
            node._specialActionPlaying = false
            node._giftNode._giftIconNode:setOpacity(255)
            el:removeSelf()
            print("rose520 end")
            node:hideNormalGift()
        end)
    }))
end
return result