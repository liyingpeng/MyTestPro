local PeachTreeNode=class("PeachTreeNode", require("app.gift.special.SpecialGiftNode"))
function PeachTreeNode:create(layer, msg)
    local node=PeachTreeNode.new(layer, msg)
    node:init()
    return node
end

function PeachTreeNode:init()
    display.loadSpriteFrames(self:getResourcePath("data.plist"), self:getResourcePath("data.png"))
    self:setName("PeachTreeNode")
    local width, height = display.size.width, display.size.height
    local sprites = {}
    local actions = {}

    
-- p1, index = -1.000
sprites[1] = display.newSprite()
sprites[1]:setScale(0.75)
sprites[1]:setAnchorPoint(0.5, 0)
sprites[1]:setPosition(0.5*width- 260,0)
actions[1] = cc.Sequence:create({
    cc.CallFunc:create(function(el, data)
        self:beforeAnimationStart()
    end),
    cc.DelayTime:create(4.000),
    cc.CallFunc:create(function(el, data)
        self:afterAnimationEnd()
    end)
})
table.insert(self.data, { node = sprites[1], action = actions[1] })
self:addChild(sprites[1])

-- 文案
local ownerAction = cc.Sequence:create({
    cc.CallFunc:create(function(el, data)
        el:align(display.CENTER, display.cx, height - 50)
            :setOpacity(0)
            :setVisible(true) 
    end),
    cc.Spawn:create({
        cc.FadeIn:create(.2),
        cc.MoveBy:create(.2, cc.p(0, -100))
    }),
    cc.DelayTime:create(3.600),
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

-- 233.png, index = 2
sprites[2] = display.newSprite("#img_8.png")
sprites[2]:setOpacity(0)
sprites[2]:setPosition(379, -499)
sprites[2]:setLocalZOrder(982)
sprites[2]:addTo(sprites[1])
actions[2] = cc.Spawn:create({
cc.Sequence:create({
cc.BezierTo:create(0.667, { 
    cc.p(379, -375.833), 
    cc.p(379, 116.833), 
    cc.p(379, 240)}),
cc.MoveTo:create(2.833, cc.p(379, 240)),
cc.BezierTo:create(0.5, { 
    cc.p(379, 102.5), 
    cc.p(379, -447.5), 
    cc.p(379, -585)})}),
cc.Sequence:create({
cc.DelayTime:create(0.267),
cc.FadeTo:create(0.4, 255),
cc.FadeTo:create(3.167, 255),
cc.FadeTo:create(0.167, 0)})})
table.insert(self.data, { node = sprites[2], action = actions[2] })

-- tree, index = 1
sprites[3] = display.newSprite()
sprites[3]:setContentSize(750, 1334)
sprites[3]:setCascadeOpacityEnabled(true)

sprites[3]:setPosition(375, 668)
sprites[3]:addTo(sprites[1])
actions[3] = cc.Sequence:create({
cc.DelayTime:create(3.833),
cc.FadeTo:create(0.167, 0)})
table.insert(self.data, { node = sprites[3], action = actions[3] })

-- lizi, index = 14
sprites[4] = cc.ClippingNode:create()
sprites[4]:setPosition(0, 0)
-- sprites[4]:setLocalZOrder(984)
-- sprites[4]:setAlphaThreshold(0.5)
sprites[4]:setInverted(false)
sprites[4]:addTo(sprites[3])

local mask4Shape = cc.DrawNode:create()
mask4Shape:drawSolidPoly({ cc.p(-301, 959), cc.p(-271, 711), cc.p(343, 715), cc.p(227, 1113) }, 4, cc.c4f(1, 0, 0, 1))
sprites[4]:setStencil(mask4Shape)


-- lizi, index = 14
sprites[5] = display.newSprite()
sprites[5]:setContentSize(750, 1334)
sprites[5]:setCascadeOpacityEnabled(true)

sprites[5]:setPosition(375, 667)
sprites[5]:addTo(sprites[4])
actions[5] = cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(0.8),
cc.CallFunc:create(function(el,data) el:setVisible(true) end)})
table.insert(self.data, { node = sprites[5], action = actions[5] })

-- tree.png, index = 12
sprites[6] = display.newSprite("#img_6.png")

sprites[6]:setPosition(383, 112)
sprites[6]:setAnchorPoint(0.534, 0.122)
sprites[6]:setScale(0, 0)
sprites[6]:setLocalZOrder(986)
sprites[6]:addTo(sprites[3])
actions[6] = cc.Spawn:create({
cc.Sequence:create({
cc.RotateBy:create(0.167, -9),
cc.RotateBy:create(0.1, 18),
cc.RotateBy:create(0.1, -16),
cc.RotateBy:create(0.133, 14),
cc.RotateBy:create(0.167, -7)}),
self:easeBezierAction(0, 0, 1, 1, cc.ScaleTo:create(0.667, 1, 1))})
table.insert(self.data, { node = sprites[6], action = actions[6] })

-- 2.png, index = 13
sprites[7] = display.newSprite("#img_7.png")

sprites[7]:setPosition(270, 456)
sprites[7]:setLocalZOrder(985)
sprites[7]:addTo(sprites[6])


-- 3.png, index = 11
sprites[8] = display.newSprite("#img_5.png")

sprites[8]:setRotation(-1)
sprites[8]:setPosition(274, 440)
sprites[8]:setAnchorPoint(0.48, 0.416)
sprites[8]:setLocalZOrder(987)
sprites[8]:addTo(sprites[6])
actions[8] = cc.Spawn:create({
cc.Sequence:create({
cc.DelayTime:create(0.833),
cc.RotateBy:create(0.5, 2),
cc.RotateBy:create(0.5, -2),
cc.RotateBy:create(0.5, 2),
cc.RotateBy:create(0.5, -2),
cc.RotateBy:create(0.5, 2),
cc.RotateBy:create(0.5, -2),
cc.RotateBy:create(0.5, 2)}),
cc.Sequence:create({
cc.DelayTime:create(0.833),
cc.ScaleTo:create(0.5, 0.97, 1),
cc.ScaleTo:create(0.5, 1, 1),
cc.ScaleTo:create(0.5, 0.97, 1),
cc.ScaleTo:create(0.5, 1, 1),
cc.ScaleTo:create(0.5, 0.97, 1),
cc.ScaleTo:create(0.5, 1, 1),
cc.ScaleTo:create(0.5, 0.97, 1)})})
table.insert(self.data, { node = sprites[8], action = actions[8] })

-- 5.png, index = 10
sprites[9] = display.newSprite("#img_1.png")

sprites[9]:setRotation(-48)
sprites[9]:setPosition(474, 343.5)
sprites[9]:setScale(0.17, 0.17)
sprites[9]:setLocalZOrder(988)
sprites[9]:addTo(sprites[6])
actions[9] = cc.Sequence:create({
cc.DelayTime:create(1.1),
cc.Repeat:create(cc.Sequence:create({
cc.RotateBy:create(0.733, -52),
cc.RotateBy:create(0.767, 52)}), 999)})
table.insert(self.data, { node = sprites[9], action = actions[9] })

-- 11.png, index = 9
sprites[10] = display.newSprite("#img_4.png")

sprites[10]:setRotation(-0.867)
sprites[10]:setPosition(282, 442)
sprites[10]:setLocalZOrder(989)
sprites[10]:addTo(sprites[6])
actions[10] = cc.Sequence:create({
cc.DelayTime:create(0.833),
cc.ScaleTo:create(0.5, 0.98, 1),
cc.ScaleTo:create(0.5, 1, 1),
cc.ScaleTo:create(0.5, 0.98, 1),
cc.ScaleTo:create(0.5, 1, 1),
cc.ScaleTo:create(0.5, 0.98, 1),
cc.ScaleTo:create(0.5, 1, 1),
cc.ScaleTo:create(0.5, 0.98, 1)})
table.insert(self.data, { node = sprites[10], action = actions[10] })

-- 232.png, index = 8
sprites[11] = display.newSprite("#img_3.png")

sprites[11]:setPosition(192, 562)
sprites[11]:setScale(0.127, 0.127)
sprites[11]:setLocalZOrder(990)
sprites[11]:addTo(sprites[6])
actions[11] = cc.Sequence:create({
cc.DelayTime:create(0.667),
cc.Repeat:create(cc.Sequence:create({
cc.RotateBy:create(0.7, -30),
cc.RotateBy:create(0.733, 30)}), 999)})
table.insert(self.data, { node = sprites[11], action = actions[11] })

-- 232.png, index = 7
sprites[12] = display.newSprite("#img_3.png")

sprites[12]:setRotation(-140)
sprites[12]:setPosition(388, 361)
sprites[12]:setScale(0.127, 0.127)
sprites[12]:setLocalZOrder(991)
sprites[12]:addTo(sprites[6])
actions[12] = cc.Sequence:create({
cc.DelayTime:create(0.667),
cc.Repeat:create(cc.Sequence:create({
cc.RotateBy:create(0.733, -28),
cc.RotateBy:create(0.633, 28)}), 999)})
table.insert(self.data, { node = sprites[12], action = actions[12] })

-- 232.png, index = 6
sprites[13] = display.newSprite("#img_3.png")

sprites[13]:setPosition(381, 441)
sprites[13]:setScale(0.127, 0.127)
sprites[13]:setLocalZOrder(992)
sprites[13]:addTo(sprites[6])
actions[13] = cc.Sequence:create({
cc.DelayTime:create(0.667),
cc.Repeat:create(cc.Sequence:create({
cc.RotateBy:create(0.7, -30),
cc.RotateBy:create(0.633, 30)}), 999)})
table.insert(self.data, { node = sprites[13], action = actions[13] })

-- 2.png, index = 5
sprites[14] = display.newSprite("#img_2.png")

sprites[14]:setRotation(40)
sprites[14]:setPosition(187, 478)
sprites[14]:setScale(0.109, 0.11)
sprites[14]:setLocalZOrder(993)
sprites[14]:addTo(sprites[6])
actions[14] = cc.Sequence:create({
cc.DelayTime:create(0.667),
cc.Repeat:create(cc.Sequence:create({
cc.RotateBy:create(0.733, -30),
cc.RotateBy:create(0.7, 30)}), 999)})
table.insert(self.data, { node = sprites[14], action = actions[14] })

-- 2.png, index = 4
sprites[15] = display.newSprite("#img_2.png")

sprites[15]:setRotation(40)
sprites[15]:setPosition(400, 535)
sprites[15]:setScale(0.109, 0.11)
sprites[15]:setLocalZOrder(994)
sprites[15]:addTo(sprites[6])
actions[15] = cc.Sequence:create({
cc.DelayTime:create(0.833),
cc.Repeat:create(cc.Sequence:create({
cc.RotateBy:create(0.8, -30),
cc.RotateBy:create(0.7, 30)}), 999)})
table.insert(self.data, { node = sprites[15], action = actions[15] })

-- 2.png, index = 3
sprites[16] = display.newSprite("#img_2.png")

sprites[16]:setRotation(40)
sprites[16]:setPosition(110, 332)
sprites[16]:setScale(0.109, 0.11)
sprites[16]:setLocalZOrder(995)
sprites[16]:addTo(sprites[6])
actions[16] = cc.Sequence:create({
cc.DelayTime:create(0.933),
cc.Repeat:create(cc.Sequence:create({
cc.RotateBy:create(0.767, -30),
cc.RotateBy:create(0.767, 30)}), 999)})
table.insert(self.data, { node = sprites[16], action = actions[16] })

-- 5.png, index = 2
sprites[17] = display.newSprite("#img_1.png")

sprites[17]:setRotation(-27)
sprites[17]:setPosition(28, 384.5)
sprites[17]:setScale(0.17, 0.17)
sprites[17]:setLocalZOrder(996)
sprites[17]:addTo(sprites[6])
actions[17] = cc.Sequence:create({
cc.DelayTime:create(0.967),
cc.Repeat:create(cc.Sequence:create({
cc.RotateBy:create(0.733, 38),
cc.RotateBy:create(0.767, -38)}), 999)})
table.insert(self.data, { node = sprites[17], action = actions[17] })

-- 10.png, index = 1
sprites[18] = display.newSprite("#img_0.png")

sprites[18]:setPosition(290, 62)
sprites[18]:setLocalZOrder(997)
sprites[18]:addTo(sprites[6])

    
-- read particle file
    local _emitter_1 = cc.ParticleSystemQuad:create(self:getResourcePath("1.plist"))
        _emitter_1:setPosition(720,300)    -- position of particle
        :setVisible(false)
        :setLocalZOrder(-1)
        :addTo(self)

    local _emitter_1_action = cc.Sequence:create({
        cc.DelayTime:create(0.5),
        cc.CallFunc:create(function(el,data)
           el:setVisible(true)
        end),
        cc.DelayTime:create(3.2),
        cc.FadeOut:create(0.3),
        cc.CallFunc:create(function(el,data)
           el:setVisible(false)
        end),
    })
    table.insert(self.data,{ node= _emitter_1, action=_emitter_1_action})

    local _emitter_2 = cc.ParticleSystemQuad:create(self:getResourcePath("2.plist"))
        _emitter_2:setPosition(720,544-180)    -- position of particle
        :setVisible(false)
        :setLocalZOrder(-1)
        :addTo(self)

    local _emitter_2_action = cc.Sequence:create({
        cc.DelayTime:create(0.5),
        cc.CallFunc:create(function(el,data)
           el:setVisible(true)
        end),
        cc.DelayTime:create(3.2),
        cc.FadeOut:create(0.3),
        cc.CallFunc:create(function(el,data)
           el:setVisible(false)
        end),
    })
    table.insert(self.data,{ node= _emitter_2, action=_emitter_2_action})

    local _emitter_3 = cc.ParticleSystemQuad:create(self:getResourcePath("3.plist"))
        _emitter_3:setPosition(720,544-180)    -- position of particle
        :setVisible(false)
        :setLocalZOrder(-1)
        :addTo(self)

    local _emitter_3_action = cc.Sequence:create({
        cc.DelayTime:create(0.5),
        cc.CallFunc:create(function(el,data)
           el:setVisible(true)
        end),
        cc.DelayTime:create(3.2),
        cc.FadeOut:create(0.3),
        cc.CallFunc:create(function(el,data)
           el:setVisible(false)
        end),
    })
    table.insert(self.data,{ node= _emitter_3, action=_emitter_3_action})
end

function PeachTreeNode:easeBezierAction(x1, y1, x2, y2, action)
    local easeAction = cc.EaseBezierAction:create(action)
    easeAction:setBezierParamer(x1, y1, x2, y2)
    return easeAction
end

function PeachTreeNode:onExit()
    printInfo("PeachTreeNode onExit!!!!")
    display.removeSpriteFrames(self:getResourcePath("data.plist"), self:getResourcePath("data.png"))
end
return PeachTreeNode