local MetYouNode=class("MetYouNode", require("app.gift.special.SpecialGiftNode"))
function MetYouNode:create(layer, msg)
    local node=MetYouNode.new(layer, msg)
    node:init()
    return node
end
function MetYouNode:init()
    display.loadSpriteFrames(self:getResourcePath("data.plist"), self:getResourcePath("data.png"))
    self:setName("MetYouNode")
    
    local width, height = display.size.width, display.size.height 
    local ratio = 2
    
    local ownerAction = cc.Sequence:create({
        cc.CallFunc:create(function(el, data)
            self:beforeAnimationStart() 
            el:setScale(.8)
            el:align(display.CENTER, display.cx, display.cy + 200)
            el:setOpacity(0)
            el:setVisible(true)
        end),
        -- 定义其他动作
        cc.Spawn:create({
            cc.FadeIn:create(0.2),
            cc.MoveBy:create(0.2, cc.p(0, -100))
        }),
        cc.DelayTime:create(4.6),
        cc.EaseIn:create(
            cc.Spawn:create({
                cc.FadeOut:create(0.4),
                cc.ScaleTo:create(0.4, 1.1)
            }),3.0),
        cc.CallFunc:create(function(el, data)
            el:setOpacity(255)
            el:setVisible(false)
        end)
    })


-- 合成 1, index = -1.000
local sprite0 = display.newSprite()
sprite0:setScale(.5)
sprite0:setPositionX(.35 * width)
local sprite0Action = cc.Sequence:create({
    cc.CallFunc:create(function(el, data)
        self:beforeAnimationStart()
    end),
    cc.DelayTime:create(5.000),
    cc.CallFunc:create(function(el, data)
        self:afterAnimationEnd()
    end)
})
sprite0:runAction(sprite0Action)
self:addChild(sprite0)

local heartLeftParticle = cc.ParticleSystemQuad:create(self:getResourcePath('heart_left.plist'))
heartLeftParticle:addTo(sprite0)

local heartRightParticle = cc.ParticleSystemQuad:create(self:getResourcePath('heart_right.plist'))
heartRightParticle:addTo(sprite0)

local heartLeftParticleAction = cc.Sequence:create({
    cc.CallFunc:create(function(el,data)
        el:setVisible(false)
    end),
    cc.DelayTime:create(.6),
    cc.CallFunc:create(function(el,data)
        el:setVisible(true)
        el:resetSystem()
    end),
    cc.DelayTime:create(4),
    cc.CallFunc:create(function(el,data)
        el:setVisible(false)
    end),
})
local heartRightParticleAction = cc.Sequence:create({
    cc.CallFunc:create(function(el,data)
        el:setVisible(false)
    end),
    cc.DelayTime:create(.6),
    cc.CallFunc:create(function(el,data)
        el:setVisible(true)
        el:resetSystem()
    end),
    cc.DelayTime:create(4),
    cc.CallFunc:create(function(el,data)
        el:setVisible(false)
    end),
})
heartLeftParticle:runAction(heartLeftParticleAction)
heartRightParticle:runAction(heartRightParticleAction)

-- 大❤️.png, index = 12
local sprite1 = display.newSprite("#img_2.png")

sprite1:setPosition(377, -337)
sprite1:setScale(0.8, 0.8)
sprite1:addTo(sprite0)
local sprite1Action = cc.Spawn:create({
    cc.Sequence:create({
    cc.DelayTime:create(0.333),
    cc.BezierTo:create(0.333, { 
        cc.p(377, -212.934), 
        cc.p(377, 536.997), 
        cc.p(377, 536.997)}),
    cc.MoveTo:create(0.2, cc.p(377, 594.399)),
    cc.BezierTo:create(0.267, { 
        cc.p(377, 594.399), 
        cc.p(377, 543.054), 
        cc.p(377, 525.661)}),
    cc.BezierTo:create(0.2, { 
        cc.p(377, 509.953), 
        cc.p(377, 527.836), 
        cc.p(377, 531)}),
    cc.BezierTo:create(2.8, { 
        cc.p(377, 537.667), 
        cc.p(377, 531), 
        cc.p(377, 531)}),
    cc.MoveTo:create(0.533, cc.p(377, 570.073)),
    cc.MoveTo:create(0.333, cc.p(377, -733))}),
    cc.Sequence:create({
    cc.DelayTime:create(0.667),
    cc.ScaleTo:create(0.467, 0.762, 0.762),
    cc.ScaleTo:create(0.533, 0.77, 0.77),
    cc.ScaleTo:create(0.4, 1, 1),
    cc.ScaleTo:create(0.267, 0.77, 0.77),
    cc.ScaleTo:create(0.733, 1, 1),
    cc.ScaleTo:create(0.267, 0.77, 0.77),
    cc.ScaleTo:create(0.8, 1, 1),
    cc.ScaleTo:create(0.267, 1.09, 1.09),
    cc.ScaleTo:create(0.333, 0.53, 0.53),
    cc.ScaleTo:create(0.267, 0, 0),
    cc.ScaleTo:create(0.067, 0.77, 0.77),
    cc.ScaleTo:create(0.333, 1, 1)})})
sprite1:runAction(sprite1Action)

-- girl
local girlSprite = display.newSprite('#girl_015.png')
girlSprite:setRotation(101)
    :setPosition(593, -150)
    :setScale(ratio, ratio)
    :setAnchorPoint(0.422, 0)
    :addTo(sprite0)

-- girl_[015-034].png, index = 8
local sprite4 = display.newSprite()
local sprite4Frames = {}
for i = 15, 34 do
    sprite4Frames[i - 15 + 1] = display.newSpriteFrame('#girl_' .. string.format("%03d", i) .. '.png')
end
local sprite4Animation = cc.Animation:createWithSpriteFrames(sprite4Frames, 0.070)

local girlSpriteAction = cc.Spawn:create({
    cc.Sequence:create({
        cc.RotateTo:create(.5, 0),
        cc.RotateTo:create(.133, -3),
        cc.RotateTo:create(.133, 0),
        cc.Repeat:create(cc.Animate:create(sprite4Animation), 2),
        cc.Spawn:create({
            cc.Animate:create(sprite4Animation),
            cc.Sequence:create({
                cc.DelayTime:create(.8),
                cc.MoveBy:create(.2, cc.p(0, 100)),
                cc.MoveBy:create(.3, cc.p(0, -900))
            })
        }),
    }),
})
girlSprite:runAction(girlSpriteAction)

local tmp1 = 380
-- boy 
local boySprite = display.newSprite('#boy_015.png')
boySprite:setRotation(101)
    :setPosition(240, -591 + tmp1)
    :setScale(ratio, ratio)
    :setAnchorPoint(.5, 0)
    :setRotation(-105)
    :addTo(sprite0)

-- boy_[015-031].png, index = 3
local sprite9 = display.newSprite()
local sprite9Frames = {}
for i = 15, 31 do
    sprite9Frames[i - 15 + 1] = display.newSpriteFrame('#boy_' .. string.format("%03d", i) .. '.png')
end
local sprite9Animation = cc.Animation:createWithSpriteFrames(sprite9Frames, 0.071)

local boySpriteAction = cc.Sequence:create({
    cc.Sequence:create({
        cc.RotateTo:create(.5, 0),
        cc.RotateTo:create(.133, 5),
        cc.RotateTo:create(.133, 0),
        cc.Repeat:create(cc.Animate:create(sprite9Animation), 3),
        cc.MoveBy:create(.2, cc.p(0, 100)),
        cc.MoveBy:create(.3, cc.p(0, -900))
    })
})
boySprite:runAction(boySpriteAction)

-- 雪花
local snowParticles = {}
for i = 1, 4 do
    snowParticles[i] = cc.ParticleSystemQuad:create(self:getResourcePath('snow' .. i .. '.plist'))
    snowParticles[i]:addTo(sprite0)
    local snowParticleAction = cc.Sequence:create({
        -- cc.DelayTime:create(3),
        cc.FadeOut:create(.3)
    })

    snowParticles[i]:runAction(snowParticleAction)
    
end
    -- owner
    local data1 = {node=self.layer.ownerNode,action=ownerAction}
    table.insert(self.data,data1)
end
function MetYouNode:onExit()
    printInfo("MetYouNode onExit!!!!")
    display.removeSpriteFrames(self:getResourcePath("data.plist"), self:getResourcePath("data.png"))
end
return MetYouNode