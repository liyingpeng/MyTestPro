local PickYouNode=class("PickYouNode", require("app.gift.special.SpecialGiftNode"))
function PickYouNode:create(layer, msg)
    local node=PickYouNode.new(layer, msg)
    node:init()
    return node
end

function PickYouNode:init()
    display.loadSpriteFrames(self:getResourcePath("data1.plist"), self:getResourcePath("data1.png"))
    display.loadSpriteFrames(self:getResourcePath("data2.plist"), self:getResourcePath("data2.png"))
    self:setName("PickYouNode")
    local width, height = display.size.width, display.size.height
    local sprites = {}
    local actions = {}

    
-- 合成 3, index = -1.000
sprites[1] = display.newSprite()
actions[1] = cc.Sequence:create({
    cc.CallFunc:create(function(el, data)
        self:beforeAnimationStart()
    end),
    cc.DelayTime:create(5.067),
    cc.CallFunc:create(function(el, data)
        self:afterAnimationEnd()
    end)
})
table.insert(self.data, { node = sprites[1], action = actions[1] })
self:addChild(sprites[1])

-- 文案
local ownerAction = cc.Sequence:create({
    cc.CallFunc:create(function(el, data)
        el:align(display.CENTER, display.cx, display.cy + 500)
            :setOpacity(0)
            :setVisible(true) 
    end),
    cc.Spawn:create({
        cc.FadeIn:create(.2),
        cc.MoveBy:create(.2, cc.p(0, -100))
    }),
    cc.DelayTime:create(4.667),
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

-- 合成 1, index = 10
sprites[2] = display.newSprite()
sprites[2]:setContentSize(750, 2000)
sprites[2]:setCascadeOpacityEnabled(true)

sprites[2]:setPosition(374, 669)
sprites[2]:addTo(sprites[1])


-- 形状 26.png, index = 10
sprites[3] = cc.ClippingNode:create()
sprites[3]:setPosition(0, 0)
-- sprites[3]:setGlobalZOrder(972)
-- sprites[3]:setAlphaThreshold(0.5)
sprites[3]:setInverted(false)
sprites[3]:addTo(sprites[2])

local mask3Shape = cc.DrawNode:create()
mask3Shape:drawSolidPoly({ cc.p(53.577, 2284.453), cc.p(53.577, 2024.222), cc.p(279.4680000000001, 2024.222), cc.p(279.4680000000001, 2284.453) }, 4, cc.c4f(1, 0, 0, 1))
sprites[3]:setStencil(mask3Shape)
actions[3] = cc.ActionFloat:create(0.733, 0, 1, function(value)
    mask3Shape:clear()
    mask3Shape:drawSolidPoly({
cc.p(53.577 + -946.577 * value, 2284.453 + -41.453 * value),
cc.p(53.577 + -946.577 * value, 2024.222 + -1572.222 * value),
cc.p(279.468 + -151.468 * value, 2024.222 + -1572.222 * value),
cc.p(279.468 + -151.468 * value, 2284.453 + -41.453 * value)}, 4, cc.c4f(1, 0, 0, 1))
end)
table.insert(self.data, { node = mask3Shape, action = actions[3] })

-- 形状 26.png, index = 10
sprites[4] = display.newSprite(self:getResourcePath("img_12.png"))

sprites[4]:setPosition(869, 1680)
sprites[4]:setAnchorPoint(0.968, 0.978)
sprites[4]:setGlobalZOrder(971)
sprites[4]:addTo(sprites[3])
actions[4] = cc.Spawn:create({
cc.Sequence:create({
cc.FadeTo:create(0.467, 110),
cc.FadeTo:create(0.533, 255),
cc.FadeTo:create(3.333, 255),
cc.FadeTo:create(0.667, 0)}),
cc.Sequence:create({
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.467, -17)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.533, 30)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.467, -36)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.533, 36)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.467, -36)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.467, 36)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.6, -36)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.533, 36)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.933, -36))})})
table.insert(self.data, { node = sprites[4], action = actions[4] })

-- 形状 26 拷贝.png, index = 9
sprites[5] = cc.ClippingNode:create()
sprites[5]:setPosition(0, 0)
-- sprites[5]:setGlobalZOrder(974)
-- sprites[5]:setAlphaThreshold(0.5)
sprites[5]:setInverted(false)
sprites[5]:addTo(sprites[2])

local mask5Shape = cc.DrawNode:create()
mask5Shape:drawSolidPoly({ cc.p(22.872, 2240.4449999999997), cc.p(22.872, 2091.812), cc.p(165.74, 2091.812), cc.p(165.74, 2240.4449999999997) }, 4, cc.c4f(1, 0, 0, 1))
sprites[5]:setStencil(mask5Shape)
actions[5] = cc.ActionFloat:create(0.733, 0, 1, function(value)
    mask5Shape:clear()
    mask5Shape:drawSolidPoly({
cc.p(22.872 + 58.128 * value, 2240.445 + -89.445 * value),
cc.p(22.872 + 58.128 * value, 2091.812 + -1739.812 * value),
cc.p(165.74 + 944.260 * value, 2091.812 + -1739.812 * value),
cc.p(165.74 + 944.260 * value, 2240.445 + -89.445 * value)}, 4, cc.c4f(1, 0, 0, 1))
end)
table.insert(self.data, { node = mask5Shape, action = actions[5] })

-- 形状 26 拷贝.png, index = 9
sprites[6] = display.newSprite(self:getResourcePath("img_11.png"))

sprites[6]:setPosition(-81, 1648)
sprites[6]:setAnchorPoint(0.041, 0.959)
sprites[6]:setGlobalZOrder(973)
sprites[6]:addTo(sprites[5])
actions[6] = cc.Spawn:create({
cc.Sequence:create({
cc.FadeTo:create(0.467, 110),
cc.FadeTo:create(0.533, 255),
cc.FadeTo:create(3.333, 255),
cc.FadeTo:create(0.667, 0)}),
cc.Sequence:create({
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.467, 17)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.533, -30)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.467, 36)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.533, -36)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.467, 36)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.467, -36)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.533, 36)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.6, -36)),
self:easeBezierAction(0, 0, 1, 1, cc.RotateBy:create(0.867, 36))})})
table.insert(self.data, { node = sprites[6], action = actions[6] })

-- 灯牌.png, index = 7
sprites[7] = display.newSprite("#img_10.png")

sprites[7]:setRotation(11)
sprites[7]:setPosition(397, 1853.571)
sprites[7]:setScale(0.6, 0.6)
sprites[7]:setGlobalZOrder(975)
sprites[7]:addTo(sprites[2])
actions[7] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(0.733),
cc.CallFunc:create(function(el,data) el:setVisible(true) end)}),
cc.Spawn:create({
cc.Sequence:create({
cc.DelayTime:create(0.667),
cc.BezierTo:create(0.667, { 
    cc.p(393.846, 1949.756), 
    cc.p(379, 796.997), 
    cc.p(379, 796.997)}),
cc.MoveTo:create(3.2, cc.p(379, 796.997)),
cc.MoveTo:create(0.133, cc.p(373, 928)),
cc.MoveTo:create(0.333, cc.p(373, 170))}),
cc.Sequence:create({
cc.DelayTime:create(1.067),
cc.RotateBy:create(0.267, -20),
cc.RotateBy:create(3.133, 0),
cc.RotateBy:create(0.533, 21)})})})
table.insert(self.data, { node = sprites[7], action = actions[7] })

-- 发光.png, index = 6
sprites[8] = display.newSprite("#img_9.png")

sprites[8]:setPosition(658.662, 335.498)
sprites[8]:setGlobalZOrder(976)
sprites[8]:addTo(sprites[7])
actions[8] = cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(0.733),
cc.CallFunc:create(function(el,data) el:setVisible(true) end)})
table.insert(self.data, { node = sprites[8], action = actions[8] })

-- picku_[000-080].png, index = 5
sprites[9] = display.newSprite()
local sprite9Frames = {}
for i = 0, 60 do
    sprite9Frames[i - 0 + 1] = display.newSpriteFrame('#picku_' .. string.format("%03d", i) .. '.png')
end
local sprite9Animation = cc.Animation:createWithSpriteFrames(sprite9Frames, 0.051)

sprites[9]:setPosition(691.792, 341.899)
sprites[9]:setScale(1.667, 1.667)
sprites[9]:setGlobalZOrder(977)
sprites[9]:addTo(sprites[7])
actions[9] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(1),
cc.CallFunc:create(function(el,data) el:setVisible(true) end)}),
cc.Sequence:create({
cc.DelayTime:create(1),
cc.Animate:create(sprite9Animation)})})
table.insert(self.data, { node = sprites[9], action = actions[9] })

-- 组 6 拷贝.png, index = 4
sprites[10] = display.newSprite("#img_8.png")

sprites[10]:setRotation(15)
sprites[10]:setPosition(-88, -227)
sprites[10]:setAnchorPoint(0.333, 0.113)
sprites[10]:setScale(0.92, 0.92)
sprites[10]:setGlobalZOrder(978)
sprites[10]:addTo(sprites[2])
actions[10] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(1),
cc.CallFunc:create(function(el,data) el:setVisible(true) end)}),
cc.Spawn:create({
cc.Sequence:create({
cc.DelayTime:create(1.133),
cc.BezierTo:create(0.333, { 
    cc.p(-73.5, -169.167), 
    cc.p(-1, 120), 
    cc.p(-1, 120)}),
cc.MoveTo:create(3.133, cc.p(-1, 120)),
cc.BezierTo:create(0.333, { 
    cc.p(-1, 120), 
    cc.p(-15.333, -309), 
    cc.p(-59, -398)})}),
cc.Sequence:create({
cc.DelayTime:create(1.267),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.467, 15),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.467, 15),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.4, 15),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.333, 15),
cc.RotateBy:create(0.467, -15)}),
cc.Sequence:create({
cc.DelayTime:create(1.267),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.467, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.467, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.4, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.333, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1)})})})
table.insert(self.data, { node = sprites[10], action = actions[10] })

-- 组 6 拷贝 2.png, index = 3
sprites[11] = display.newSprite("#img_7.png")

sprites[11]:setRotation(15)
sprites[11]:setPosition(547, -184)
sprites[11]:setAnchorPoint(0.443, 0.156)
sprites[11]:setScale(0.92, 0.92)
sprites[11]:setGlobalZOrder(979)
sprites[11]:addTo(sprites[2])
actions[11] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(1),
cc.CallFunc:create(function(el,data) el:setVisible(true) end)}),
cc.Spawn:create({
cc.Sequence:create({
cc.DelayTime:create(1.067),
cc.BezierTo:create(0.333, { 
    cc.p(551.333, -126.425), 
    cc.p(568.667, 103.874), 
    cc.p(573, 161.449)}),
cc.MoveTo:create(3.267, cc.p(573, 161.449)),
cc.BezierTo:create(0.4, { 
    cc.p(555, 87.208), 
    cc.p(516.333, -203.667), 
    cc.p(465, -284)})}),
cc.Sequence:create({
cc.DelayTime:create(1.267),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.467, 15),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.467, 15),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.4, 15),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.333, 15),
cc.RotateBy:create(0.467, -15)}),
cc.Sequence:create({
cc.DelayTime:create(1.267),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.467, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.467, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.4, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.333, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1)})})})
table.insert(self.data, { node = sprites[11], action = actions[11] })

-- 左2, index = 2
sprites[12] = display.newSprite()
sprites[12]:setContentSize(448, 856)
sprites[12]:setCascadeOpacityEnabled(true)

sprites[12]:setPosition(263, 428)
sprites[12]:addTo(sprites[2])
actions[12] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(1),
cc.CallFunc:create(function(el,data) el:setVisible(true) end)}),
cc.Sequence:create({
cc.DelayTime:create(4.667),
cc.BezierTo:create(0.333, { 
    cc.p(254, 281), 
    cc.p(230.5, -16.167), 
    cc.p(224, -105)})})})
table.insert(self.data, { node = sprites[12], action = actions[12] })

-- 组 52.png, index = 1
sprites[13] = display.newSprite("#img_6.png")

sprites[13]:setRotation(15)
sprites[13]:setPosition(115, -198)
sprites[13]:setAnchorPoint(0.5, 0.072)
sprites[13]:setScale(0.92, 0.92)
sprites[13]:setGlobalZOrder(980)
sprites[13]:addTo(sprites[12])
actions[13] = cc.Spawn:create({
cc.BezierTo:create(0.333, { 
    cc.p(72, -428), 
    cc.p(171, 120), 
    cc.p(171, 120)}),
cc.Sequence:create({
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.4, 15),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.333, 15),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.4, 15),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.4, 15),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.467, 15),
cc.RotateBy:create(0.467, -15)}),
cc.Sequence:create({
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.4, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.333, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.4, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.4, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.467, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1)})})
table.insert(self.data, { node = sprites[13], action = actions[13] })

-- 预合成 1 合成 1, index = 1
sprites[14] = display.newSprite()
sprites[14]:setContentSize(486, 900)
sprites[14]:setCascadeOpacityEnabled(true)

sprites[14]:setPosition(440, 451.5)
sprites[14]:addTo(sprites[2])
actions[14] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(1),
cc.CallFunc:create(function(el,data) el:setVisible(true) end)}),
cc.Sequence:create({
cc.DelayTime:create(4.667),
cc.BezierTo:create(0.333, { 
    cc.p(412.667, 358.167), 
    cc.p(303.333, -15.167), 
    cc.p(276, -108.5)})})})
table.insert(self.data, { node = sprites[14], action = actions[14] })

-- 预合成 1, index = 1
sprites[15] = display.newSprite()
sprites[15]:setContentSize(392, 716)
sprites[15]:setCascadeOpacityEnabled(true)

sprites[15]:setRotation(15)
sprites[15]:setPosition(95, -295)
sprites[15]:setAnchorPoint(0.464, 0.053)
sprites[15]:setScale(0.92, 0.92)
sprites[15]:addTo(sprites[14])
actions[15] = cc.Spawn:create({
cc.BezierTo:create(0.333, { 
    cc.p(88.5, -213.833), 
    cc.p(191.606, 180.155), 
    cc.p(192, 182)}),
cc.Sequence:create({
cc.DelayTime:create(0.333),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.4, 15),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.467, 15),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.467, 15),
cc.RotateBy:create(0.467, -15),
cc.RotateBy:create(0.4, 15),
cc.RotateBy:create(0.467, -15)}),
cc.Sequence:create({
cc.DelayTime:create(0.333),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.4, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.467, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.467, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1),
cc.ScaleTo:create(0.4, 0.92, 0.92),
cc.ScaleTo:create(0.467, 1, 1)})})
table.insert(self.data, { node = sprites[15], action = actions[15] })

-- 形状 24.png, index = 5
sprites[16] = display.newSprite("#img_5.png")

sprites[16]:setPosition(235, 398)
sprites[16]:setGlobalZOrder(982)
sprites[16]:addTo(sprites[15])


-- 组 55.png, index = 4
sprites[17] = display.newSprite("#img_4.png")

sprites[17]:setRotation(12)
sprites[17]:setPosition(243, 361)
sprites[17]:setAnchorPoint(0.239, 0.854)
sprites[17]:setGlobalZOrder(983)
sprites[17]:addTo(sprites[15])
actions[17] = cc.Sequence:create({
cc.DelayTime:create(0.067),
cc.RotateBy:create(0.267, -23),
cc.RotateBy:create(0.333, 23),
cc.RotateBy:create(0.4, 0),
cc.RotateBy:create(0.267, -23),
cc.RotateBy:create(0.333, 23),
cc.RotateBy:create(0.4, 0),
cc.RotateBy:create(0.267, -23),
cc.RotateBy:create(0.333, 23),
cc.RotateBy:create(0.4, 0),
cc.RotateBy:create(0.267, -23),
cc.RotateBy:create(0.333, 23),
cc.RotateBy:create(0.4, 0),
cc.RotateBy:create(0.267, -23),
cc.RotateBy:create(0.333, 23)})
table.insert(self.data, { node = sprites[17], action = actions[17] })

-- 组 6.png, index = 3
sprites[18] = display.newSprite("#img_3.png")

sprites[18]:setPosition(238, 334)
sprites[18]:setGlobalZOrder(984)
sprites[18]:addTo(sprites[15])


-- 组 53.png, index = 2
sprites[19] = display.newSprite("#img_2.png")

sprites[19]:setRotation(-31)
sprites[19]:setPosition(175, 340)
sprites[19]:setAnchorPoint(0.821, 0.86)
sprites[19]:setGlobalZOrder(985)
sprites[19]:addTo(sprites[15])
actions[19] = cc.Sequence:create({
cc.DelayTime:create(0.133),
cc.RotateBy:create(0.333, 34),
cc.RotateBy:create(0.467, -34),
cc.RotateBy:create(0.4, 0),
cc.RotateBy:create(0.333, 34),
cc.RotateBy:create(0.467, -34),
cc.RotateBy:create(0.4, 0),
cc.RotateBy:create(0.333, 34),
cc.RotateBy:create(0.467, -34),
cc.RotateBy:create(0.333, 0),
cc.RotateBy:create(0.333, 34),
cc.RotateBy:create(0.467, -34)})
table.insert(self.data, { node = sprites[19], action = actions[19] })

-- 组 54.png, index = 1
sprites[20] = display.newSprite("#img_1.png")

sprites[20]:setPosition(225, 371)
sprites[20]:setGlobalZOrder(986)
sprites[20]:addTo(sprites[15])


-- star.png, index = 9
sprites[21] = display.newSprite("#img_0.png")

sprites[21]:setPosition(224, 535)
sprites[21]:setScale(0.1, 0.1)
sprites[21]:setGlobalZOrder(990)
sprites[21]:addTo(sprites[1])
actions[21] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(1.467),
cc.CallFunc:create(function(el,data) el:setVisible(true) end),
cc.DelayTime:create(3.067),
cc.CallFunc:create(function(el,data) el:setVisible(false) end)}),
cc.Sequence:create({
cc.DelayTime:create(1.467),
cc.Repeat:create(cc.Sequence:create({
cc.ScaleTo:create(0.333, 0.78, 0.78),
cc.ScaleTo:create(0.333, 0.1, 0.1)}), 999)})})
table.insert(self.data, { node = sprites[21], action = actions[21] })

-- star.png, index = 8
sprites[22] = display.newSprite("#img_0.png")

sprites[22]:setPosition(252, 574)
sprites[22]:setScale(0.1, 0.1)
sprites[22]:setGlobalZOrder(991)
sprites[22]:addTo(sprites[1])
actions[22] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(1.933),
cc.CallFunc:create(function(el,data) el:setVisible(true) end),
cc.DelayTime:create(2.8),
cc.CallFunc:create(function(el,data) el:setVisible(false) end)}),
cc.Sequence:create({
cc.DelayTime:create(1.933),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.1, 0.1)})})
table.insert(self.data, { node = sprites[22], action = actions[22] })

-- star.png, index = 7
sprites[23] = display.newSprite("#img_0.png")

sprites[23]:setPosition(382, 564)
sprites[23]:setScale(0.1, 0.1)
sprites[23]:setGlobalZOrder(992)
sprites[23]:addTo(sprites[1])
actions[23] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(1.733),
cc.CallFunc:create(function(el,data) el:setVisible(true) end),
cc.DelayTime:create(2.8),
cc.CallFunc:create(function(el,data) el:setVisible(false) end)}),
cc.Sequence:create({
cc.DelayTime:create(1.733),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.1, 0.1)})})
table.insert(self.data, { node = sprites[23], action = actions[23] })

-- star.png, index = 6
sprites[24] = display.newSprite("#img_0.png")

sprites[24]:setPosition(562, 554)
sprites[24]:setScale(0.1, 0.1)
sprites[24]:setGlobalZOrder(993)
sprites[24]:addTo(sprites[1])
actions[24] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(1.867),
cc.CallFunc:create(function(el,data) el:setVisible(true) end),
cc.DelayTime:create(2.8),
cc.CallFunc:create(function(el,data) el:setVisible(false) end)}),
cc.Sequence:create({
cc.DelayTime:create(1.867),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.1, 0.1)})})
table.insert(self.data, { node = sprites[24], action = actions[24] })

-- star.png, index = 5
sprites[25] = display.newSprite("#img_0.png")

sprites[25]:setPosition(662, 454)
sprites[25]:setScale(0.1, 0.1)
sprites[25]:setGlobalZOrder(994)
sprites[25]:addTo(sprites[1])
actions[25] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(1.867),
cc.CallFunc:create(function(el,data) el:setVisible(true) end),
cc.DelayTime:create(2.8),
cc.CallFunc:create(function(el,data) el:setVisible(false) end)}),
cc.Sequence:create({
cc.DelayTime:create(1.867),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.1, 0.1)})})
table.insert(self.data, { node = sprites[25], action = actions[25] })

-- star.png, index = 4
sprites[26] = display.newSprite("#img_0.png")

sprites[26]:setPosition(502, 514)
sprites[26]:setScale(0.1, 0.1)
sprites[26]:setGlobalZOrder(995)
sprites[26]:addTo(sprites[1])
actions[26] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(1.533),
cc.CallFunc:create(function(el,data) el:setVisible(true) end),
cc.DelayTime:create(2.8),
cc.CallFunc:create(function(el,data) el:setVisible(false) end)}),
cc.Sequence:create({
cc.DelayTime:create(1.533),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.1, 0.1)})})
table.insert(self.data, { node = sprites[26], action = actions[26] })

-- star.png, index = 3
sprites[27] = display.newSprite("#img_0.png")

sprites[27]:setPosition(96, 454)
sprites[27]:setScale(0.1, 0.1)
sprites[27]:setGlobalZOrder(996)
sprites[27]:addTo(sprites[1])
actions[27] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(1.867),
cc.CallFunc:create(function(el,data) el:setVisible(true) end),
cc.DelayTime:create(2.8),
cc.CallFunc:create(function(el,data) el:setVisible(false) end)}),
cc.Sequence:create({
cc.DelayTime:create(1.867),
cc.ScaleTo:create(0.333, 0.58, 0.58),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.58, 0.58),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.58, 0.58),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.58, 0.58),
cc.ScaleTo:create(0.333, 0.1, 0.1)})})
table.insert(self.data, { node = sprites[27], action = actions[27] })

-- star.png, index = 2
sprites[28] = display.newSprite("#img_0.png")

sprites[28]:setPosition(636, 426)
sprites[28]:setScale(0.1, 0.1)
sprites[28]:setGlobalZOrder(997)
sprites[28]:addTo(sprites[1])
actions[28] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(1.667),
cc.CallFunc:create(function(el,data) el:setVisible(true) end),
cc.DelayTime:create(2.8),
cc.CallFunc:create(function(el,data) el:setVisible(false) end)}),
cc.Sequence:create({
cc.DelayTime:create(1.667),
cc.ScaleTo:create(0.333, 0.58, 0.58),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.58, 0.58),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.58, 0.58),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.58, 0.58),
cc.ScaleTo:create(0.333, 0.1, 0.1)})})
table.insert(self.data, { node = sprites[28], action = actions[28] })

-- star.png, index = 1
sprites[29] = display.newSprite("#img_0.png")

sprites[29]:setPosition(376, 352)
sprites[29]:setScale(0.1, 0.1)
sprites[29]:setGlobalZOrder(998)
sprites[29]:addTo(sprites[1])
actions[29] = cc.Spawn:create({
cc.Sequence:create({
cc.CallFunc:create(function(el,data) el:setVisible(false) end),
cc.DelayTime:create(1.733),
cc.CallFunc:create(function(el,data) el:setVisible(true) end),
cc.DelayTime:create(2.8),
cc.CallFunc:create(function(el,data) el:setVisible(false) end)}),
cc.Sequence:create({
cc.DelayTime:create(1.733),
cc.ScaleTo:create(0.333, 0.58, 0.58),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.58, 0.58),
cc.ScaleTo:create(0.333, 0.49, 0.49),
cc.ScaleTo:create(0.333, 0.58, 0.58),
cc.ScaleTo:create(0.333, 0.1, 0.1),
cc.ScaleTo:create(0.333, 0.58, 0.58),
cc.ScaleTo:create(0.333, 0.1, 0.1)})})
table.insert(self.data, { node = sprites[29], action = actions[29] })

    
end

function PickYouNode:easeBezierAction(x1, y1, x2, y2, action)
    local easeAction = cc.EaseBezierAction:create(action)
    easeAction:setBezierParamer(x1, y1, x2, y2)
    return easeAction
end

function PickYouNode:onExit()
    printInfo("PickYouNode onExit!!!!")
    display.removeSpriteFrames(self:getResourcePath("data1.plist"), self:getResourcePath("data1.png"))
    display.removeSpriteFrames(self:getResourcePath("data2.plist"), self:getResourcePath("data2.png"))
end
return PickYouNode