local MagicWandNode=class("MagicWandNode", require("app.gift.special.SpecialGiftNode"))

function MagicWandNode:init()
    
    display.loadSpriteFrames(self:getResourcePath("magic.plist"), self:getResourcePath("magic.png"))
    display.loadSpriteFrames(self:getResourcePath("magic2.plist"), self:getResourcePath("magic2.png"))
    display.loadSpriteFrames(self:getResourcePath("wand.plist"), self:getResourcePath("wand.png"))
    self:setName("MagicWandNode")

    local w=display.size.width
    local h=display.size.height
--金主动作
    local ownerAction = cc.Sequence:create({
        cc.CallFunc:create(function(el, data)
            self:beforeAnimationStart() 
            el:align(display.CENTER, display.cx, display.cy+0.32*h)
            el:setVisible(true)
        end),
        -- 定义其他动作
        cc.DelayTime:create(2.6),
        cc.EaseIn:create(
            cc.Spawn:create({
                cc.FadeOut:create(0.4),
                cc.ScaleTo:create(0.4, 1.1)
            }),3.0),
        cc.CallFunc:create(function(el, data)
            self:afterAnimationEnd() 
            el:setOpacity(255)
            el:setVisible(false)
        end)
    })

    local data1 = {node=self.layer.ownerNode,action=ownerAction}
    table.insert(self.data,data1)


    -- 魔法
    local magic = display.newSprite()
    magic:setPosition(cc.p(0.5*w,0.55*h))
    :setScale(2)
    :addTo(self)

    local allFrame={}
    for i=0,47 do
        allFrame[i] = display.newSpriteFrame("#light_0"..(i+12)..".png")
    end

    local magicAnimation = cc.Animation:createWithSpriteFrames(allFrame,3/48)
    local magicAnimate = cc.Animate:create(magicAnimation)
    local magicAction=cc.Sequence:create({
        magicAnimate,
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end)

    })

    data1 = {node=magic,action=magicAction}
    table.insert(self.data,data1)

    local wand = display.newSprite("#魔法棒.png")
    wand:setVisible(true)
    :setAnchorPoint(0.5,0.7)
    :setPosition(-0.1*w,0.6*h)
    :setRotation(30)
    :setScale(0.9)
    :addTo(self)

    local wandAction= cc.Sequence:create({
            cc.MoveBy:create(0.3,cc.p(0.25*w,0.05*h)),
            cc.MoveBy:create(0.3,cc.p(0.15*w,-0.1*h)),
            cc.MoveBy:create(0.3,cc.p(0.3*w,0.18*h)),
            cc.MoveBy:create(0.35,cc.p(0.2*w,-0.18*h)),
            cc.MoveBy:create(0.5,cc.p(-0.3*w,-0.2*h)),
            cc.MoveBy:create(0.1,cc.p(-0.15*w,0.015*h)),
            cc.MoveBy:create(0.1,cc.p(-0.05*w,0.025*h)),
            cc.MoveBy:create(0.1,cc.p(0.05*w,0.025*h)),
            cc.MoveBy:create(0.1,cc.p(0.15*w,0.015*h)),
            cc.Spawn:create({
                cc.MoveBy:create(0.55,cc.p(0.21*w,-0.2*h)),
                cc.FadeOut:create(0.8)
            }),
            cc.CallFunc:create(function(el,data)
                el:setVisible(false);
            end)
        })

    data1 = {node=wand,action=wandAction}
    table.insert(self.data,data1)

end

function MagicWandNode:onExit()
    printInfo("MagicWandNode onExit!!!!")
    display.removeSpriteFrames(self:getResourcePath("magic.plist"), self:getResourcePath("magic.png"))
    display.removeSpriteFrames(self:getResourcePath("magic2.plist"), self:getResourcePath("magic2.png"))
    display.removeSpriteFrames(self:getResourcePath("wand.plist"), self:getResourcePath("wand.png"))

end

function MagicWandNode:create(layer, msg)
    local node=MagicWandNode.new(layer, msg)
    node:init()
    return node
end

return MagicWandNode