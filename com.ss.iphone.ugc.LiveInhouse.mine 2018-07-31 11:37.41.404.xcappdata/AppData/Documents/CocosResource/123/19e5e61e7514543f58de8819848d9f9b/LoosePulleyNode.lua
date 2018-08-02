local LoosePulleyNode=class("LoosePulleyNode", require("app.gift.special.SpecialGiftNode"))

function LoosePulleyNode:init()
    self:setName("LoosePulleyNode")
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
            cc.EaseSineOut:create(cc.MoveBy:create(1,cc.p(-display.width*0.9,-display.height*0.15))),
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


    local sea = display.newSprite(self:getResourcePath("loose_pulley_newwater_00010.png"))
        :setOpacity(0)
        :setAnchorPoint(0.5,0)
        :setPosition(cc.p(display.width*0.5,-display.height*0.05))
        :addTo(self,1)
        :setScale(2)

    local animateAction = live.createFrames(5,10,39,self:getResourcePath("loose_pulley_newwater_000"),2/15,2)
    local showAction = cc.Sequence:create({
        cc.Spawn:create({
            cc.FadeIn:create(1),
            cc.MoveTo:create(3.5,cc.p(display.width*0.5,0)),
            }),
        cc.FadeOut:create(1)
        })
    local seaAction = cc.Spawn:create({
        animateAction,
        showAction
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

function LoosePulleyNode:yellowwork()
    -- body
    local yellow = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_firestart.plist"))
        :setAnchorPoint(0.5,0)
        :setPosition(display.width*0.2,display.height*0.6)
        :setAutoRemoveOnFinish(true)
        :addTo(self,3)

    local yellowAction = cc.Sequence:create({
        cc.MoveTo:create(1,cc.p(display.width*0.2,display.height*0.8)),
        cc.CallFunc:create(function(el,data)
            self:yellowfirework()
            el:removeFromParent()
        end)
    })

    yellow:runAction(yellowAction)
end

function LoosePulleyNode:yellowfirework()
    -- body
    local yellowfire = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_firework.plist"))
        :setPosition(display.width*0.2,display.height*0.8)
        :addTo(self,5)
end

function LoosePulleyNode:yellowwork2()
    -- body
    local yellow = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_firestart.plist"))
        :setAnchorPoint(0.5,0)
        :setPosition(display.width*0.8,display.height*0.3)
        :setAutoRemoveOnFinish(true)
        :addTo(self,1)

    local yellowAction = cc.Sequence:create({
        cc.MoveTo:create(0.6,cc.p(display.width*0.8,display.height*0.5)),
        cc.CallFunc:create(function(el,data)
            self:yellowfirework2()
            el:removeFromParent()
        end)
    })

    yellow:runAction(yellowAction)
end

function LoosePulleyNode:yellowfirework2()
    -- body
    local yellowfire = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_firework.plist"))
        :setPosition(display.width*0.8,display.height*0.5)
        :addTo(self,5)
end

function LoosePulleyNode:bluework()
    -- body
    local blue = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_bluefirestart.plist"))
        :setAnchorPoint(0.5,0)
        :setPosition(display.width*0.2,display.height*0.3)
        :setAutoRemoveOnFinish(true)
        :addTo(self,3)

    local blueAction = cc.Sequence:create({
        cc.MoveTo:create(1,cc.p(display.width*0.2,display.height*0.5)),
        cc.CallFunc:create(function(el,data)
            self:bluefirework()
            el:removeFromParent()
        end)
    })

    blue:runAction(blueAction)
end

function LoosePulleyNode:bluefirework()
    -- body
    local bluefire = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_bluefirework.plist"))
        :setPosition(display.width*0.2,display.height*0.5)
        :addTo(self,5)
end

function LoosePulleyNode:bluework2()
    -- body
    local blue = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_bluefirestart.plist"))
        :setAnchorPoint(0.5,0)
        :setPosition(display.width*0.7,display.height*0.6)
        :setAutoRemoveOnFinish(true)
        :addTo(self,3)

    local blueAction = cc.Sequence:create({
        cc.MoveTo:create(0.4,cc.p(display.width*0.7,display.height*0.8)),
        cc.CallFunc:create(function(el,data)
            self:bluefirework2()
            el:removeFromParent()
        end)
    })

    blue:runAction(blueAction)
end

function LoosePulleyNode:bluefirework2()
    -- body
    local bluefire = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_bluefirework.plist"))
        :setPosition(display.width*0.7,display.height*0.8)
        :addTo(self,5)
end

function LoosePulleyNode:pinkwork()
    -- body
    local pink = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_pinkfirestart.plist"))
        :setAnchorPoint(0.5,0)
        :setPosition(display.width*0.6,display.height*0.4)
        :setAutoRemoveOnFinish(true)
        :addTo(self,3)

    local pinkAction = cc.Sequence:create({
        cc.MoveTo:create(1,cc.p(display.width*0.6,display.height*0.7)),
        cc.CallFunc:create(function(el,data)
            self:pinkfirework()
            el:removeFromParent()
        end)
    })

    pink:runAction(pinkAction)
end

function LoosePulleyNode:pinkfirework()
    -- body
    local pinkfire = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_pinkfirework.plist"))
        :setPosition(display.width*0.6,display.height*0.7)
        :addTo(self,5)
end

function LoosePulleyNode:pinkwork2()
    -- body
    local pink = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_pinkfirestart.plist"))
        :setAnchorPoint(0.5,0)
        :setPosition(display.width*0.4,display.height*0.5)
        :setAutoRemoveOnFinish(true)
        :addTo(self,3)

    local pinkAction = cc.Sequence:create({
        cc.MoveTo:create(0.3,cc.p(display.width*0.4,display.height*0.6)),
        cc.CallFunc:create(function(el,data)
            self:pinkfirework2()
            el:removeFromParent()
        end)
    })

    pink:runAction(pinkAction)
end

function LoosePulleyNode:pinkfirework2()
    -- body
    local pinkfire = cc.ParticleSystemQuad:create(self:getResourcePath("loose_pulley_pinkfirework.plist"))
        :setPosition(display.width*0.4,display.height*0.6)
        :addTo(self,5)
end

function LoosePulleyNode:onExit()
    -- body
    cc.Director:getInstance():getTextureCache():removeTextureForKey("loose_pulley_yacht.png")
    cc.Director:getInstance():getTextureCache():removeTextureForKey("loose_pulley_yachtshadow.png")
    printInfo("yacht exit!!!!!!!!!!!!")
end

function LoosePulleyNode:create(layer, msg)
    local node = LoosePulleyNode.new(layer, msg)
    node:init()
    return node
end

return LoosePulleyNode
