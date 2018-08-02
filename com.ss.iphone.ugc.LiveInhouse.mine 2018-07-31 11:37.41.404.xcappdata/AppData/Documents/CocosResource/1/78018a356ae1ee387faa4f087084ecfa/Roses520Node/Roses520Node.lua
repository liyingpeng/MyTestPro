local Roses520Node= class("Roses520Node", require("app.gift.special.SpecialGiftNode"))

function Roses520Node:init()
   display.loadSpriteFrames(self:getResourcePath("Roses520Node/roses_666_0.plist"), self:getResourcePath("Roses520Node/roses_666_0.png"))
   display.loadSpriteFrames(self:getResourcePath("Roses520Node/roses_666_1.plist"), self:getResourcePath("Roses520Node/roses_666_1.png"))

    local animation = cc.Animation:create()
    for i=1,87 do
        animation :addSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame('roses_666_'.. i .. '.png'))
    end
    animation:setDelayPerUnit(4 / 87)
    local action = cc.Sequence:create({
        cc.Animate:create(animation),
        cc.CallFunc:create(function()
            display.removeSpriteFrames(self:getResourcePath("Roses520Node/roses_666_0.plist"), self:getResourcePath("Roses520Node/roses_666_0.png"))
            display.removeSpriteFrames(self:getResourcePath("Roses520Node/roses_666_1.plist"), self:getResourcePath("Roses520Node/roses_666_1.png")) 
        end)
    })
    display.newSprite('#roses_666_1.png')
        :align(display.LEFT_BOTTOM, 0, 0)
        :addTo(self)
        :runAction(action)
end 

function Roses520Node:create(layer, msg)
    local node = Roses520Node.new(layer, msg)
    node:init()
    return node
end

return Roses520Node
