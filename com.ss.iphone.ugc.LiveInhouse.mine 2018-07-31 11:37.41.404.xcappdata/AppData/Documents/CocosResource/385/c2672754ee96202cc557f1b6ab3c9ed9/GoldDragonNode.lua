local TestNode=class("TestNode", require("app.gift.special.SpecialGiftNode"))
function TestNode:create(layer, msg)
    local node=TestNode.new(layer, msg)
    node:init()
    return node
end

function TestNode:init()
    display.loadSpriteFrames(self:getResourcePath("dragon1.plist"), self:getResourcePath("dragon1.png"))
    display.loadSpriteFrames(self:getResourcePath("dragon2.plist"), self:getResourcePath("dragon2.png"))
    display.loadSpriteFrames(self:getResourcePath("dragon3_1.plist"), self:getResourcePath("dragon3_1.png"))
    display.loadSpriteFrames(self:getResourcePath("dragon3_2.plist"), self:getResourcePath("dragon3_2.png"))
    display.loadSpriteFrames(self:getResourcePath("dragon3_3.plist"), self:getResourcePath("dragon3_3.png"))
    display.loadSpriteFrames(self:getResourcePath("dragon3_4.plist"), self:getResourcePath("dragon3_4.png"))
    display.loadSpriteFrames(self:getResourcePath("dragon3_5.plist"), self:getResourcePath("dragon3_5.png"))
    display.loadSpriteFrames(self:getResourcePath("dragon3_6.plist"), self:getResourcePath("dragon3_6.png"))
    self:setName("TestNode")
    local width, height = display.size.width, display.size.height
    local sprites = {}
    local actions = {}
    local _emitter_1 = cc.ParticleSystemQuad:create(self:getResourcePath("1.plist"))
        _emitter_1:setPosition(width*0.15,height*1.1)    -- position of particle
        :setVisible(true)
        :setScale(1.5)
        :addTo(self)

    local _emitter_1_action = cc.Sequence:create({
        cc.DelayTime:create(0.3),
        cc.CallFunc:create(function(el,data)
           el:setVisible(true)
        end),
        cc.DelayTime:create(13.7),
        cc.CallFunc:create(function(el,data)
            el:setEmissionRate(0)
        end),
        cc.DelayTime:create(1),
        cc.CallFunc:create(function(el,data)
           el:setVisible(false)
        end),
    })
    table.insert(self.data,{ node= _emitter_1, action=_emitter_1_action})

    local _emitter_2 = cc.ParticleSystemQuad:create(self:getResourcePath("2.plist"))
        _emitter_2:setPosition(width*0.45,height*1.2)    -- position of particle
        :setVisible(false)
        :setScale(1.5)
        :addTo(self)

    local _emitter_2_action = cc.Sequence:create({
        cc.CallFunc:create(function(el,data)
           el:setVisible(true)
        end),
        cc.DelayTime:create(14),
        cc.CallFunc:create(function(el,data)
            el:setEmissionRate(0)
        end),
        cc.DelayTime:create(1),
        cc.CallFunc:create(function(el,data)
           el:setVisible(false)
        end),
    })
    table.insert(self.data,{ node= _emitter_2, action=_emitter_2_action})

    local _emitter_3 = cc.ParticleSystemQuad:create(self:getResourcePath("3.plist"))
        _emitter_3:setPosition(width*0.75,height*1)    -- position of particle
        :setVisible(false)
        :setScale(1.5)
        :addTo(self)

    local _emitter_3_action = cc.Sequence:create({
        cc.CallFunc:create(function(el,data)
           el:setVisible(true)
        end),
        cc.DelayTime:create(14),
        cc.CallFunc:create(function(el,data)
            el:setEmissionRate(0)
        end),
        cc.DelayTime:create(1),
        cc.CallFunc:create(function(el,data)
           el:setVisible(false)
        end),
    })
    table.insert(self.data,{ node= _emitter_3, action=_emitter_3_action})

    local _emitter_4 = cc.ParticleSystemQuad:create(self:getResourcePath("4.plist"))
        _emitter_4:setPosition(360,height*0.78)    -- position of particle
        :setVisible(false)
        :addTo(self)

    local _emitter_4_action = cc.Sequence:create({
        cc.DelayTime:create(4.2),
        cc.CallFunc:create(function(el,data)
           el:setVisible(true)
        end),
        cc.DelayTime:create(0.4),
        cc.CallFunc:create(function(el,data)
            el:setEmissionRate(0)
        end),
        cc.DelayTime:create(5),
        cc.CallFunc:create(function(el,data)
           el:setVisible(false)
        end),
    })
    table.insert(self.data,{ node= _emitter_4, action=_emitter_4_action})

    local _emitter_5 = cc.ParticleSystemQuad:create(self:getResourcePath("4.plist"))
        _emitter_5:setPosition(360,0.45*height)    -- position of particle
        :setVisible(false)
        :addTo(self)

    local _emitter_5_action = cc.Sequence:create({
        cc.DelayTime:create(12.5),
        cc.CallFunc:create(function(el,data)
           el:setVisible(true)
        end),
        cc.DelayTime:create(1),
        cc.CallFunc:create(function(el,data)
            el:setEmissionRate(0)
        end),
        cc.DelayTime:create(2),
        cc.CallFunc:create(function(el,data)
           el:setVisible(false)
        end),
    })
    table.insert(self.data,{ node= _emitter_5, action=_emitter_5_action})

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
        cc.DelayTime:create(14.400),
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

    local rootSprite = display.newSprite()
    rootSprite:addTo(self)

    local rootSpriteAction = cc.Sequence:create({
        cc.CallFunc:create(function(el, data)
            self:beforeAnimationStart()
        end),
        cc.DelayTime:create(15.000),
        cc.CallFunc:create(function(el, data)
            self:afterAnimationEnd()
        end)
    })
    table.insert(self.data, { node = rootSprite, action = rootSpriteAction })

    --中间云
    local cloud1 = display.newSprite("#img_0.png")
    cloud1:setPosition(-468*width/720, 317*height/1334)
    cloud1:addTo(self)

    local cloud1_action = cc.Sequence:create({
        cc.DelayTime:create(4),
        cc.BezierTo:create(5.267, { 
            cc.p(-359*width/720, 428.333*height/1334), 
            cc.p(-68*width/720, 489*height/1334), 
            cc.p(-68*width/720, 489*height/1334)
        }),
        cc.BezierTo:create(5.333, { 
            cc.p(-68*width/720, 489*height/1334), 
            cc.p(-514.763*width/720, 269.236*height/1334), 
            cc.p(-468*width/720, 317*height/1334)
            })
        })
    table.insert(self.data, { node = cloud1, action = cloud1_action })

    -- 顶部云
    local cloud2 = display.newSprite("#img_0.png")
    cloud2:setPosition(360*width/720, 1609*height/1334)
    cloud2:setGlobalZOrder(994)
    cloud2:addTo(self)

    local cloud2_action = cc.Sequence:create({
        cc.BezierTo:create(4, { 
            cc.p(360*width/720, 1570.167*height/1334), 
            cc.p(360*width/720, 1378.167*height/1334), 
            cc.p(360*width/720, 1376*height/1334)
        }),
        cc.BezierTo:create(5.267, { 
            cc.p(360*width/720, 1373.833*height/1334), 
            cc.p(360*width/720, 1559.333*height/1334), 
            cc.p(360*width/720, 1596*height/1334)}
        )})
    table.insert(self.data, { node = cloud2, action = cloud2_action })

    -- 下面云
    local cloud3 = display.newSprite("#img_0.png")
    cloud3:setPosition(-228.585*width/720, -197.611*height/1334)
    cloud3:setGlobalZOrder(998)
    cloud3:addTo(self)

    local cloud3_action = cc.Sequence:create({
        cc.DelayTime:create(3.6),
        cc.BezierTo:create(5.667, { 
            cc.p(-228.585*width/720, -197.611*height/1334), 
            cc.p(232.313*width/720, 93.439*height/1334), 
            cc.p(479.415*width/720, 94.389*height/1334)
        }),
        cc.BezierTo:create(5.267, { 
            cc.p(931.786*width/720, 96.128*height/1334), 
            cc.p(1181.415*width/720, -85.611*height/1334), 
            cc.p(1181.415*width/720, -85.611*height/1334)
        })
    })
    table.insert(self.data, { node = cloud3, action = cloud3_action })
-- dragon1
    local dragon1 = display.newSprite()
    dragon1:setPosition(cc.p(0.5*width,0.8*height))
    :setScale(2)
    :addTo(self)

    local dragon1Frame={}
    for i=0,9 do
        dragon1Frame[i] = display.newSpriteFrame("#d1_0000"..i..".png")
    end

    for i=10,59 do
        dragon1Frame[i] = display.newSpriteFrame("#d1_000"..i..".png")
    end

    local dragon1_Animation = cc.Animation:createWithSpriteFrames(dragon1Frame,2/60)
    local dragon1_Animate = cc.Animate:create(dragon1_Animation)
    local dragon1_Action=cc.Sequence:create({
        cc.DelayTime:create(3.4),
        dragon1_Animate,
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end)

    })

    table.insert(self.data, { node = dragon1, action = dragon1_Action })

-- dragon1
    local dragon2 = display.newSprite()
    dragon2:setPosition(cc.p(0.5*width,0))
    :setAnchorPoint(0.5,0)
    :setScale(2)
    :addTo(self)

    local dragon2Frame={}
    for i=0,9 do
        dragon2Frame[i] = display.newSpriteFrame("#d2_0000"..i..".png")
    end

    for i=10,49 do
        dragon2Frame[i] = display.newSpriteFrame("#d2_000"..i..".png")
    end

    local dragon2_Animation = cc.Animation:createWithSpriteFrames(dragon2Frame,1.6/50)
    local dragon2_Animate = cc.Animate:create(dragon2_Animation)
    local dragon2_Action=cc.Sequence:create({
        cc.DelayTime:create(6.4),
        dragon2_Animate,
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end)

    })

    table.insert(self.data, { node = dragon2, action = dragon2_Action })

-- dragon1
    local dragon3 = display.newSprite()
    dragon3:setPosition(cc.p(0.5*width,0.5*height))
    :setAnchorPoint(0.5,0.5)
    :setScale(2)
    :addTo(self)

    local dragon3Frame={}
    for i=0,9 do
        dragon3Frame[i] = display.newSpriteFrame("#d3_0000"..i..".png")
    end
    for i=10,99 do
        dragon3Frame[i] = display.newSpriteFrame("#d3_000"..i..".png")
    end

    for i=100,197 do
        dragon3Frame[i] = display.newSpriteFrame("#d3_00"..i..".png")
    end

    local dragon3_Animation = cc.Animation:createWithSpriteFrames(dragon3Frame,6/180)
    local dragon3_Animate = cc.Animate:create(dragon3_Animation)
    local dragon3_Action=cc.Sequence:create({
        cc.DelayTime:create(8.1),
        dragon3_Animate,
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end)

    })

    table.insert(self.data, { node = dragon3, action = dragon3_Action })

    
    
end

function TestNode:easeBezierAction(x1, y1, x2, y2, action)
    local easeAction = cc.EaseBezierAction:create(action)
    easeAction:setBezierParamer(x1, y1, x2, y2)
    return easeAction
end

function TestNode:onExit()
    printInfo("TestNode onExit!!!!")
    display.removeSpriteFrames(self:getResourcePath("dragon1.plist"), self:getResourcePath("dragon1.png"))
    display.removeSpriteFrames(self:getResourcePath("dragon2.plist"), self:getResourcePath("dragon2.png"))
    display.removeSpriteFrames(self:getResourcePath("dragon3_1.plist"), self:getResourcePath("dragon3_1.png"))
    display.removeSpriteFrames(self:getResourcePath("dragon3_2.plist"), self:getResourcePath("dragon3_2.png"))
    display.removeSpriteFrames(self:getResourcePath("dragon3_3.plist"), self:getResourcePath("dragon3_3.png"))
    display.removeSpriteFrames(self:getResourcePath("dragon3_4.plist"), self:getResourcePath("dragon3_4.png"))
    display.removeSpriteFrames(self:getResourcePath("dragon3_5.plist"), self:getResourcePath("dragon3_5.png"))
    display.removeSpriteFrames(self:getResourcePath("dragon3_6.plist"), self:getResourcePath("dragon3_6.png"))
end
return TestNode