local LoosePulleyNodeL=class("LoosePulleyNodeL", require("app.gift.special.SpecialGiftNode"))

function LoosePulleyNodeL:init()
    display.loadSpriteFrames(self:getResourcePath("loose_pulley_water.plist"), self:getResourcePath("loose_pulley_water.png"))
    self:setName("LoosePulleyNodeL")
    self:setVisible(true)
    local ownerAction = cc.Sequence:create({
            cc.CallFunc:create(function(el,data)
                self:beforeAnimationStart();
                el:align(display.LEFT_BOTTOM, 1.3 * display.width, 0.6 * display.height)
                el:setOpacity(255)
                el:setVisible(true)
            end),
            cc.DelayTime:create(0.5),
            cc.EaseSineOut:create(cc.MoveTo:create(1,cc.p(display.width*0.4,display.height*0.45))),
            cc.DelayTime:create(2),
            cc.EaseSineIn:create(cc.MoveTo:create(1,cc.p(-display.width*0.5,display.height*0.3))),
            cc.CallFunc:create(function(el,data)
                self:afterAnimationEnd();
                el:setVisible(false);
            end)
        });

    local yacht = display.newSprite(self:getResourcePath("loose_pulley_yacht.png"))
        :setVisible(true)
        :setAnchorPoint(0,0)
        :setPosition(cc.p(display.width,display.height*0.3))
        :addTo(self,2)

    local yachtAction= cc.Sequence:create({
            cc.DelayTime:create(0.5),
            cc.EaseSineOut:create(cc.MoveBy:create(1,cc.p(-display.width*0.8,-display.height*0.15))),
            cc.CallFunc:create(function()
                self:yellowwork()
                self:bluework2()
                self:yellowwork2()
            end),
            cc.DelayTime:create(0.2),
            cc.CallFunc:create(function()
                self:bluework()
                self:pinkwork2()
            end),
            cc.DelayTime:create(0.5),
            cc.CallFunc:create(function()
                self:pinkwork()
            end),
            cc.DelayTime:create(1.3),
            cc.EaseSineIn:create(cc.MoveTo:create(1,cc.p(-display.width*0.8,0)))
        })

    local yachtShadow = display.newSprite(self:getResourcePath("loose_pulley_yachtshadow.png"))
        :setVisible(true)
        :setAnchorPoint(0,0)
        :setPosition(cc.p(80,-50))
        :addTo(yacht,-1)


    -- local sea = display.newSprite(self:getResourcePath("loose_pulley_newwater_00010.png"))
    local sea = display.newSprite()
        -- :setOpacity(0)
        :setAnchorPoint(0.5,0)
        :setScale(2*display.width/1280,2)
        :setPosition(cc.p(display.width*0.5,-display.height*0.05))
        :addTo(self,1)
        -- :setScale(2)



    local allFrame={}
    for i=0,9 do
        allFrame[i] = display.newSpriteFrame("#water_00"..i..".png")
    end
    for i=10,14 do
        allFrame[i] = display.newSpriteFrame("#water_0"..i..".png")
    end

    local seaAnimation = cc.Animation:createWithSpriteFrames(allFrame,5/15)
    local seaAnimate = cc.Animate:create(seaAnimation)
    local seaAction=cc.Sequence:create({
        cc.Spawn:create({
            seaAnimate,
            cc.Sequence:create({
                cc.DelayTime:create(4.5),
                cc.FadeOut:create(0.5)
            })
            
        }),
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end)

    })

    local frontwater = display.newSprite(self:getResourcePath("loose_pulley_frontwater_0005.png"))
        :setScale(2)
        :setAnchorPoint(1,1)
        :setPosition(cc.p(400,100))
        :addTo(yacht,1)

    local frontwaterA = live.createFrames(5,5,23,self:getResourcePath("loose_pulley_frontwater_000"),2/15,1)
    local frontwaterAction = cc.Sequence:create({
        cc.DelayTime:create(0.6),
        frontwaterA
        })


    local data1 = {node=self.layer.ownerNode,action=ownerAction}
    table.insert(self.data,data1)
    data1 = {node=yacht,action=yachtAction}
    table.insert(self.data,data1)
    data1 = {node=sea,action=seaAction}
    table.insert(self.data,data1)
    data1 = {node=frontwater,action=frontwaterAction}
    table.insert(self.data,data1)

end

function LoosePulleyNodeL:yellowwork()
    -- body
    local yellow = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_firestart.plist"))
        :setAnchorPoint(0.5,0)
        :setPosition(display.width*0.3,display.height*0.6)
        :setAutoRemoveOnFinish(true)
        :addTo(self,3)

    local yellowAction = cc.Sequence:create({
        cc.MoveBy:create(0.3,cc.p(0,display.height*0.2)),
        cc.CallFunc:create(function(el,data)
            self:yellowfirework()
            el:removeFromParent()
        end)
    })

    yellow:runAction(yellowAction)
end

function LoosePulleyNodeL:yellowfirework()
    -- body
    local yellowfire = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_firework.plist"))
        :setPosition(display.width*0.3,display.height*0.8)
        :addTo(self,5)
end

function LoosePulleyNodeL:yellowwork2()
    -- body
    local yellow = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_firestart.plist"))
        :setAnchorPoint(0.5,0)
        :setPosition(display.width*0.6,display.height*0.4)
        :setAutoRemoveOnFinish(true)
        :addTo(self,1)

    local yellowAction = cc.Sequence:create({
        cc.MoveBy:create(0.6,cc.p(0,display.height*0.4)),
        cc.CallFunc:create(function(el,data)
            self:yellowfirework2()
            el:removeFromParent()
        end)
    })

    yellow:runAction(yellowAction)
end

function LoosePulleyNodeL:yellowfirework2()
    -- body
    local yellowfire = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_firework.plist"))
        :setPosition(display.width*0.6,display.height*0.8)
        :addTo(self,5)
end

function LoosePulleyNodeL:bluework()
    -- body
    local blue = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_bluefirestart.plist"))
        :setAnchorPoint(0.5,0)
        :setPosition(display.width*0.25,display.height*0.3)
        :setAutoRemoveOnFinish(true)
        :addTo(self,3)

    local blueAction = cc.Sequence:create({
        cc.MoveBy:create(0.5,cc.p(0,display.height*0.3)),
        cc.CallFunc:create(function(el,data)
            self:bluefirework()
            el:removeFromParent()
        end)
    })

    blue:runAction(blueAction)
end

function LoosePulleyNodeL:bluefirework()
    -- body
    local bluefire = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_bluefirework.plist"))
        :setPosition(display.width*0.25,display.height*0.6)
        :addTo(self,5)
end

function LoosePulleyNodeL:bluework2()
    -- body
    local blue = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_bluefirestart.plist"))
        :setAnchorPoint(0.5,0)
        :setPosition(display.width*0.5,display.height*0.4)
        :setAutoRemoveOnFinish(true)
        :addTo(self,3)

    local blueAction = cc.Sequence:create({
        cc.MoveBy:create(0.4,cc.p(0,display.height*0.5)),
        cc.CallFunc:create(function(el,data)
            self:bluefirework2()
            el:removeFromParent()
        end)
    })

    blue:runAction(blueAction)
end

function LoosePulleyNodeL:bluefirework2()
    -- body
    local bluefire = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_bluefirework.plist"))
        :setPosition(display.width*0.5,display.height*0.9)
        :addTo(self,5)
end

function LoosePulleyNodeL:pinkwork()
    -- body
    local pink = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_pinkfirestart.plist"))
        :setAnchorPoint(0.5,0)
        :setPosition(display.width*0.45,display.height*0.4)
        :setAutoRemoveOnFinish(true)
        :addTo(self,3)

    local pinkAction = cc.Sequence:create({
        cc.MoveBy:create(1,cc.p(0,display.height*0.4)),
        cc.CallFunc:create(function(el,data)
            self:pinkfirework()
            el:removeFromParent()
        end)
    })

    pink:runAction(pinkAction)
end

function LoosePulleyNodeL:pinkfirework()
    -- body
    local pinkfire = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_pinkfirework.plist"))
        :setPosition(display.width*0.45,display.height*0.8)
        :addTo(self,5)
end

function LoosePulleyNodeL:pinkwork2()
    -- body
    local pink = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_pinkfirestart.plist"))
        :setAnchorPoint(0.5,0)
        :setPosition(display.width*0.35,display.height*0.5)
        :setAutoRemoveOnFinish(true)
        :addTo(self,3)

    local pinkAction = cc.Sequence:create({
        cc.MoveBy:create(0.3,cc.p(0,display.height*0.3)),
        cc.CallFunc:create(function(el,data)
            self:pinkfirework2()
            el:removeFromParent()
        end)
    })

    pink:runAction(pinkAction)
end

function LoosePulleyNodeL:pinkfirework2()
    -- body
    local pinkfire = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_pinkfirework.plist"))
        :setPosition(display.width*0.35,display.height*0.8)
        :addTo(self,5)
end

function LoosePulleyNodeL:onExit()
    -- body
    cc.Director:getInstance():getTextureCache():removeTextureForKey("loose_pulley_yacht.png")
    cc.Director:getInstance():getTextureCache():removeTextureForKey("loose_pulley_yachtshadow.png")
    printInfo("yacht exit!!!!!!!!!!!!")
end

function LoosePulleyNodeL:create(layer, msg)
    local node = LoosePulleyNodeL.new(layer, msg)
    node:init()
    return node
end

return LoosePulleyNodeL
