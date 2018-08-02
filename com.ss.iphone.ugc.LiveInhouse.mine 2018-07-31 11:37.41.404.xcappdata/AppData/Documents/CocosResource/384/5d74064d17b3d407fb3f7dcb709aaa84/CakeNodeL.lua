local CakeNode=class("CakeNode", require("app.gift.special.SpecialGiftNode"))
function CakeNode:create(layer, msg)
    local node=CakeNode.new(layer, msg)
    node:init()
    return node
end

function CakeNode:init()
    display.loadSpriteFrames(self:getResourcePath("data.plist"), self:getResourcePath("data.png"))
    display.loadSpriteFrames(self:getResourcePath("shine1.plist"), self:getResourcePath("shine1.png"))
    display.loadSpriteFrames(self:getResourcePath("shine2.plist"), self:getResourcePath("shine2.png"))
    self:setName("CakeNode")
    local width, height = display.size.width, display.size.height
    local sprites = {}
    local actions = {}
    
-- 合成 1, index = -1.000
sprites[1] = display.newSprite()
sprites[1]:setScale(0.55)
sprites[1]:setAnchorPoint(0.5,0)


actions[1] = cc.Sequence:create({
    cc.CallFunc:create(function(el, data)
        self:beforeAnimationStart()
        el:setPosition( width*0.5-216,0)
    end),
    cc.DelayTime:create(5.000),
    cc.CallFunc:create(function(el, data)
        self:afterAnimationEnd()
    end)
})
table.insert(self.data, { node = sprites[1], action = actions[1] })
self:addChild(sprites[1])

-- 文案
local ownerAction = cc.Sequence:create({
    cc.CallFunc:create(function(el, data)
        el:align(display.CENTER, display.cx, height-50)
            :setOpacity(0)
            :setVisible(true) 
    end),
    cc.Spawn:create({
        cc.FadeIn:create(.2),
        cc.MoveBy:create(.2, cc.p(0, -100))
    }),
    cc.DelayTime:create(4.600),
    cc.Spawn:create({
        cc.FadeOut:create(.4),
        cc.ScaleTo:create(.4, 1.1)
    }),
    cc.CallFunc:create(function(el, data)
        el:setOpacity(255)
        el:setVisible(false)
    end)
})
table.insert(self.data, { node = self.layer.ownerNode, action = ownerAction })

-- shine_[000-064].png, index = 14
sprites[2] = display.newSprite()
local sprite2Frames = {}
for i = 0, 64 do
    sprite2Frames[i - 0 + 1] = display.newSpriteFrame('#shine_' .. string.format("%03d", i) .. '.png')
end
local sprite2Animation = cc.Animation:createWithSpriteFrames(sprite2Frames, 0.068)

sprites[2]:setPosition(390, 672)
sprites[2]:setScale(2.6, 2.6)
sprites[2]:setLocalZOrder(986)
sprites[2]:addTo(sprites[1])
actions[2] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(0.667),
cc.CallFunc:create(function(el,data) el:setVisible(true) end)}),
cc.Sequence:create({
cc.DelayTime:create(0.667),
cc.Animate:create(sprite2Animation)})})
table.insert(self.data, { node = sprites[2], action = actions[2] })

-- cake.png, index = 13
sprites[3] = display.newSprite("#img_6.png")

sprites[3]:setPosition(376, 127)
sprites[3]:setAnchorPoint(0.5, 0.17)
sprites[3]:setScale(1, 0.19)
sprites[3]:setLocalZOrder(987)
sprites[3]:addTo(sprites[1])
actions[3] = cc.Spawn:create({
cc.Sequence:create({
cc.BezierTo:create(0.467, { 
    cc.p(375.667, 306.667), 
    cc.p(374.333, 1194.333), 
    cc.p(374, 1205)}),
cc.BezierTo:create(0.067, { 
    cc.p(373.667, 1215.667), 
    cc.p(374, 356.333), 
    cc.p(374, 191)}),
cc.BezierTo:create(0.067, { 
    cc.p(374, 25.667), 
    cc.p(374, 213), 
    cc.p(374, 213)}),
cc.BezierTo:create(0.067, { 
    cc.p(374, 213), 
    cc.p(374, 194.667), 
    cc.p(374, 191)})}),
cc.Sequence:create({
cc.DelayTime:create(4.8),
cc.FadeTo:create(0.2, 0)}),
cc.Sequence:create({
cc.ScaleTo:create(0.2, 1, 1.19),
cc.ScaleTo:create(0.267, 1, 1.31),
cc.ScaleTo:create(0.067, 1, 0.81),
cc.ScaleTo:create(0.067, 1, 1.08),
cc.ScaleTo:create(0.067, 1, 1)})})
table.insert(self.data, { node = sprites[3], action = actions[3] })

-- 巧克力棒.png, index = 12
sprites[4] = display.newSprite("#img_5.png")

sprites[4]:setRotation(17)
sprites[4]:setPosition(271, 591.5)
sprites[4]:setLocalZOrder(988)
sprites[4]:addTo(sprites[3])
actions[4] = cc.Spawn:create({
cc.Sequence:create({
cc.BezierTo:create(0.4, { 
    cc.p(272.667, 593.5), 
    cc.p(412.605, 741.223), 
    cc.p(395, 735.5)}),
cc.BezierTo:create(0.267, { 
    cc.p(334.5, 715.833), 
    cc.p(295.833, 623.833), 
    cc.p(276, 601.5)})}),
cc.Sequence:create({
cc.DelayTime:create(4.8),
cc.FadeTo:create(0.2, 0)}),
cc.Sequence:create({
cc.DelayTime:create(0.4),
cc.RotateBy:create(0.267, -17),
cc.RotateBy:create(4.133, 0)})})
table.insert(self.data, { node = sprites[4], action = actions[4] })

-- 星星.png, index = 11
sprites[5] = display.newSprite("#img_4.png")

sprites[5]:setRotation(-25)
sprites[5]:setPosition(126, 567.5)
sprites[5]:setLocalZOrder(989)
sprites[5]:addTo(sprites[3])
actions[5] = cc.Spawn:create({
cc.Sequence:create({
cc.BezierTo:create(0.4, { 
    cc.p(124, 569), 
    cc.p(42.455, 684.728), 
    cc.p(56, 681.5)}),
cc.BezierTo:create(0.267, { 
    cc.p(141.333, 661.167), 
    cc.p(147.667, 594.833), 
    cc.p(166, 577.5)})}),
cc.Sequence:create({
cc.DelayTime:create(4.8),
cc.FadeTo:create(0.2, 0)}),
cc.Sequence:create({
cc.DelayTime:create(0.333),
cc.RotateBy:create(0.333, 25),
cc.RotateBy:create(4.133, 0)})})
table.insert(self.data, { node = sprites[5], action = actions[5] })

-- 桃心.png, index = 10
sprites[6] = display.newSprite("#img_3.png")

sprites[6]:setRotation(28)
sprites[6]:setPosition(341, 551.5)
sprites[6]:setLocalZOrder(990)
sprites[6]:addTo(sprites[3])
actions[6] = cc.Spawn:create({
cc.Sequence:create({
cc.BezierTo:create(0.333, { 
    cc.p(343.667, 553.5), 
    cc.p(442.876, 599.326), 
    cc.p(429, 608.5)}),
cc.BezierTo:create(0.333, { 
    cc.p(378.833, 641.667), 
    cc.p(289.833, 559.333), 
    cc.p(262, 549.5)})}),
cc.Sequence:create({
cc.DelayTime:create(4.8),
cc.FadeTo:create(0.2, 0)}),
cc.Sequence:create({
cc.DelayTime:create(0.333),
cc.RotateBy:create(0.333, -28),
cc.RotateBy:create(4.133, 0)})})
table.insert(self.data, { node = sprites[6], action = actions[6] })

-- 蜡烛.png, index = 9
sprites[7] = display.newSprite("#img_2.png")

sprites[7]:setPosition(227, 627.5)
sprites[7]:setLocalZOrder(991)
sprites[7]:addTo(sprites[3])
actions[7] = cc.Spawn:create({
cc.Sequence:create({
cc.DelayTime:create(0.133),
cc.BezierTo:create(0.267, { 
    cc.p(227, 633), 
    cc.p(237.23, 850.467), 
    cc.p(231, 843.5)}),
cc.BezierTo:create(0.267, { 
    cc.p(215.5, 826.167), 
    cc.p(220.167, 643.5), 
    cc.p(218, 603.5)})}),
cc.Sequence:create({
cc.DelayTime:create(4.8),
cc.FadeTo:create(0.2, 0)}),
cc.Sequence:create({
cc.DelayTime:create(0.667),
cc.RotateBy:create(4.133, 0)})})
table.insert(self.data, { node = sprites[7], action = actions[7] })

-- 草莓1.png, index = 8
sprites[8] = display.newSprite("#img_1.png")

sprites[8]:setPosition(180.25, 545)
sprites[8]:setLocalZOrder(992)
sprites[8]:addTo(sprites[3])
actions[8] = cc.Spawn:create({
cc.Sequence:create({
cc.BezierTo:create(0.4, { 
    cc.p(179.917, 545), 
    cc.p(127.672, 710.585), 
    cc.p(137.028, 709.025)}),
cc.BezierTo:create(0.267, { 
    cc.p(188.622, 700.424), 
    cc.p(182.792, 542.368), 
    cc.p(186.25, 530)})}),
cc.Sequence:create({
cc.DelayTime:create(4.8),
cc.FadeTo:create(0.2, 0)})})
table.insert(self.data, { node = sprites[8], action = actions[8] })

-- 草莓2.png, index = 7
sprites[9] = display.newSprite("#img_0.png")

sprites[9]:setPosition(281.25, 540)
sprites[9]:setLocalZOrder(993)
sprites[9]:addTo(sprites[3])
actions[9] = cc.Spawn:create({
cc.Sequence:create({
cc.BezierTo:create(0.333, { 
    cc.p(281.25, 540), 
    cc.p(372.209, 672.001), 
    cc.p(355.25, 662.983)}),
cc.BezierTo:create(0.267, { 
    cc.p(305.417, 636.483), 
    cc.p(277.75, 547.997), 
    cc.p(262.25, 525)})}),
cc.Sequence:create({
cc.DelayTime:create(4.8),
cc.FadeTo:create(0.2, 0)})})
table.insert(self.data, { node = sprites[9], action = actions[9] })

-- Fire_[000-013].png, index = 6
sprites[10] = display.newSprite():setAnchorPoint(.5, .1)
local sprite10Frames = {}
for i = 0, 13 do
    sprite10Frames[i - 0 + 1] = display.newSpriteFrame('#Fire_' .. string.format("%03d", i) .. '.png')
end
local sprite10Animation = cc.Animation:createWithSpriteFrames(sprite10Frames, 0.072)

sprites[10]:setPosition(217, 677.784)
sprites[10]:setScale(0, 0)
sprites[10]:setLocalZOrder(994)
sprites[10]:addTo(sprites[3])
actions[10] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(0.667),
cc.CallFunc:create(function(el,data) el:setVisible(true) end),
cc.DelayTime:create(0.933),
cc.CallFunc:create(function(el,data) el:setVisible(false) end)}),
cc.Spawn:create({
cc.Sequence:create({
cc.DelayTime:create(0.667),
cc.Animate:create(sprite10Animation)}),
cc.Sequence:create({
cc.DelayTime:create(0.667),
cc.ScaleTo:create(0.333, 1.21, 1.21)})})})
table.insert(self.data, { node = sprites[10], action = actions[10] })

-- Fire_[000-013].png, index = 5
sprites[11] = display.newSprite():setAnchorPoint(.5, .1)
local sprite11Frames = {}
for i = 0, 13 do
    sprite11Frames[i - 0 + 1] = display.newSpriteFrame('#Fire_' .. string.format("%03d", i) .. '.png')
end
local sprite11Animation = cc.Animation:createWithSpriteFrames(sprite11Frames, 0.072)

sprites[11]:setPosition(217, 677.784)
sprites[11]:setScale(1.21, 1.21)
sprites[11]:setLocalZOrder(995)
sprites[11]:addTo(sprites[3])
actions[11] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(1.6),
cc.CallFunc:create(function(el,data) el:setVisible(true) end),
cc.DelayTime:create(0.933),
cc.CallFunc:create(function(el,data) el:setVisible(false) end)}),
cc.Sequence:create({
cc.DelayTime:create(1.6),
cc.Animate:create(sprite11Animation)})})
table.insert(self.data, { node = sprites[11], action = actions[11] })

-- Fire_[000-013].png, index = 4
sprites[12] = display.newSprite():setAnchorPoint(.5, .1)
local sprite12Frames = {}
for i = 0, 13 do
    sprite12Frames[i - 0 + 1] = display.newSpriteFrame('#Fire_' .. string.format("%03d", i) .. '.png')
end
local sprite12Animation = cc.Animation:createWithSpriteFrames(sprite12Frames, 0.072)

sprites[12]:setPosition(217, 677.784)
sprites[12]:setScale(1.21, 1.21)
sprites[12]:setLocalZOrder(996)
sprites[12]:addTo(sprites[3])
actions[12] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(2.533),
cc.CallFunc:create(function(el,data) el:setVisible(true) end),
cc.DelayTime:create(0.933),
cc.CallFunc:create(function(el,data) el:setVisible(false) end)}),
cc.Sequence:create({
cc.DelayTime:create(2.533),
cc.Animate:create(sprite12Animation)})})
table.insert(self.data, { node = sprites[12], action = actions[12] })

-- Fire_[000-013].png, index = 3
sprites[13] = display.newSprite():setAnchorPoint(.5, .1)
local sprite13Frames = {}
for i = 0, 13 do
    sprite13Frames[i - 0 + 1] = display.newSpriteFrame('#Fire_' .. string.format("%03d", i) .. '.png')
end
local sprite13Animation = cc.Animation:createWithSpriteFrames(sprite13Frames, 0.072)

sprites[13]:setPosition(217, 677.784)
sprites[13]:setScale(1.21, 1.21)
sprites[13]:setLocalZOrder(997)
sprites[13]:addTo(sprites[3])
actions[13] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(3.467),
cc.CallFunc:create(function(el,data) el:setVisible(true) end),
cc.DelayTime:create(0.933),
cc.CallFunc:create(function(el,data) el:setVisible(false) end)}),
cc.Sequence:create({
cc.DelayTime:create(3.467),
cc.Animate:create(sprite13Animation)})})
table.insert(self.data, { node = sprites[13], action = actions[13] })

-- Fire_[000-013].png, index = 2
sprites[14] = display.newSprite():setAnchorPoint(.5, .1)
local sprite14Frames = {}
for i = 0, 13 do
    sprite14Frames[i - 0 + 1] = display.newSpriteFrame('#Fire_' .. string.format("%03d", i) .. '.png')
end
local sprite14Animation = cc.Animation:createWithSpriteFrames(sprite14Frames, 0.072)

sprites[14]:setPosition(217, 677.784)
sprites[14]:setScale(1.21, 1.21)
sprites[14]:setLocalZOrder(998)
sprites[14]:addTo(sprites[3])
actions[14] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(4.4),
cc.CallFunc:create(function(el,data) el:setVisible(true) end)}),
cc.Spawn:create({
cc.Sequence:create({
cc.DelayTime:create(4.4),
cc.Animate:create(sprite14Animation)}),
cc.Sequence:create({
cc.DelayTime:create(4.8),
cc.FadeTo:create(0.2, 0)})})})
table.insert(self.data, { node = sprites[14], action = actions[14] })

local fireworks = {}
for _, i in pairs({ 1, 2, 3, 5, 7 }) do
    fireworks[i] = cc.ParticleSystemQuad:create(self:getResourcePath('cake-rect_' .. i .. '.plist'))
    fireworks[i]:addTo(sprites[1]):setLocalZOrder(999)
    local fireworkAction = cc.Sequence:create({
        cc.CallFunc:create(function(el,data)
            el:setVisible(false)
        end),
        cc.DelayTime:create(.6),
        cc.CallFunc:create(function(el,data)
            el:setVisible(true)
            el:resetSystem()
        end),
        cc.DelayTime:create(2),
        cc.FadeOut:create(.2)
    })
    table.insert(self.data, { node = fireworks[i], action = fireworkAction })
end
end

function CakeNode:easeBezierAction(x1, y1, x2, y2, action)
    local easeAction = cc.EaseBezierAction:create(action)
    easeAction:setBezierParamer(x1, y1, x2, y2)
    return easeAction
end

function CakeNode:onExit()
    printInfo("CakeNode onExit!!!!")
    display.removeSpriteFrames(self:getResourcePath("data.plist"), self:getResourcePath("data.png"))
end
return CakeNode