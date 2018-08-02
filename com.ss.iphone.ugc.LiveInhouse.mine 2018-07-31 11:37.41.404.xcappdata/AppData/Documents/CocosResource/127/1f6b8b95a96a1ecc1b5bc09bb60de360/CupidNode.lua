local CupidNode=class("CupidNode", require("app.gift.special.SpecialGiftNode"))

function CupidNode:init()
    display.loadSpriteFrames(self:getResourcePath("cupid.plist"), self:getResourcePath("cupid.png"))
    self:setName("CupidNode")
    self:setVisible(true)
    local ownerAction = cc.Sequence:create({
            cc.CallFunc:create(function(el,data)
                self:beforeAnimationStart()
                el:align(display.CENTER, display.cx, display.cy + 80)
                el:setOpacity(0)
                el:setVisible(true)
            end),
            cc.DelayTime:create(0.5),
            cc.FadeIn:create(0.2),
            cc.DelayTime:create(3),
            cc.FadeOut:create(0.3),
            cc.CallFunc:create(function(el,data)
                self:afterAnimationEnd()
                el:setOpacity(255)
                el:setVisible(false)
            end)
        })

    local cupid = display.newSprite("#cupit.png")
        :setOpacity(0)
        :setAnchorPoint(0.5,0.5)
        :setPosition(cc.p(0.5*display.width,0.25*display.height))
        :setCascadeOpacityEnabled(true)
        :addTo(self,1)

    local cupidAction= cc.Sequence:create({
            cc.Spawn:create({
                cc.MoveTo:create(0.5,cc.p(display.width*0.5,display.height*0.35)),
                cc.FadeTo:create(0.3,255)
                }),
            cc.DelayTime:create(1.5),
            cc.FadeOut:create(0.3),
            cc.CallFunc:create(function(el,data)
                el:setVisible(false);
            end)
        })

    local arrow = display.newSprite("#sward.png")
        :setAnchorPoint(1,1)
        :setPosition(cc.p(cupid:getContentSize().width*0.5,cupid:getContentSize().height*0.3))
        :addTo(cupid,1)

    local arrowAction = cc.Sequence:create({
        cc.DelayTime:create(1.4),
        cc.BezierBy:create(0.4,{cc.p(0,0),cc.p(-display.width*0.2,display.height*0.1),cc.p(-display.width*0.6,-display.height*0.2)})
        })


    local lefthand = display.newSprite("#hand.png")
        :setAnchorPoint(1,0.3)
        :setPosition(cc.p(cupid:getContentSize().width*0.7,cupid:getContentSize().height*0.3))
        :addTo(cupid,2)

    local lefthandAction = cc.Sequence:create({
        cc.DelayTime:create(1.2),
        cc.ScaleTo:create(0.2,0.7,1),
        cc.ScaleTo:create(0,1,1,1)
        })

    local wingsA,wings
    wingsA,wings = display.newAnimation("qietu-flay_0000%s.png",0,6,0.5/6)
    wings:setAnchorPoint(0.5,0.5)
        :setPosition(cc.p(cupid:getContentSize().width*0.5,cupid:getContentSize().height*0.3))
        :addTo(cupid,-1)

    local wingsAction = cc.RepeatForever:create(cc.Animate:create(wingsA))

    local heart = display.newSprite("#heart.png")
        :setAnchorPoint(0.5,0)
        :setPosition(cc.p(display.width*0.5,display.height*0.2))
        :setOpacity(0)
        :setScale(0.3)
        :addTo(self,2)

    local heartAction = cc.Sequence:create({
        cc.DelayTime:create(2),
        cc.Spawn:create({
            cc.FadeIn:create(0.2),
            cc.ScaleTo:create(0.2,1)
            }),
        cc.Repeat:create(cc.Sequence:create({
            cc.RotateTo:create(0.1,10),
            cc.RotateTo:create(0.2,-10),
            cc.RotateTo:create(0,1,0)
            }),4),
        cc.Spawn:create({
            cc.FadeOut:create(0.2),
            cc.Sequence:create({
                cc.RotateTo:create(0.1,10),
                cc.RotateTo:create(0.1,0),
                })
            })
        })

    local heart1= cc.ParticleSystemQuad:create(self:getResourcePath("cupid_heart1.plist"))
        :setPosition(cc.p(display.width*0.5,display.height*0.4))
        :setOpacityModifyRGB(true)
        :setOpacity(255)
        :setVisible(true)
        :addTo(self,-1)

    local heart1Action = cc.RepeatForever:create(cc.Sequence:create({
            cc.DelayTime:create(0.3),
            cc.Show:create(),
            cc.DelayTime:create(0.5),
            cc.CallFunc:create(function(el,data)
                el:setVisible(false)
                el:resetSystem()
                end)
            })
        )

    local heart2= cc.ParticleSystemQuad:create(self:getResourcePath("cupid_heart2.plist"))
        :setPosition(cc.p(display.width*0.5,display.height*0.4))
        :setOpacityModifyRGB(true)
        :setVisible(false)
        :addTo(self,-1)

    local heart2Action = cc.RepeatForever:create(cc.Sequence:create({
            cc.DelayTime:create(0.3),
            cc.Show:create(),
            cc.DelayTime:create(0.5),
            cc.CallFunc:create(function(el,data)
                el:setVisible(false)
                el:resetSystem()
                end)
            })
        )

    local star1 = cc.ParticleSystemQuad:create(self:getResourcePath("cupid_star1.plist"))
        :setAnchorPoint(0.5,0.5)
        :setPosition(cc.p(display.width*0.5,display.height*0.3))
        :addTo(self,-1)

    local star1Action = cc.Sequence:create({
        cc.DelayTime:create(2),
        cc.CallFunc:create(function(el,data)
            el:setGlobalZOrder(2)
        end)
        })        

    local star2 = cc.ParticleSystemQuad:create(self:getResourcePath("cupid_star2.plist"))
        :setAnchorPoint(0.5,0.5)
        :setPosition(cc.p(display.width*0.3,display.height*0.2))
        :setVisible(false)
        :addTo(heart,1)

    local star2Action = cc.Sequence:create({
        cc.DelayTime:create(2.2),
        cc.CallFunc:create(function(el,data)
            el:setVisible(true)
        end)
        })

    local bigStar = display.newSprite("#star-max-pink.png")
        :setAnchorPoint(0.5,0.5)
        :setPosition(cc.p(display.width*0.56,display.height*0.31))
        :setOpacity(150)
        :addTo(self,5)

    local bigStarAction = cc.Sequence:create({
        cc.FadeOut:create(0.3),
        cc.DelayTime:create(0.7),
        cc.Place:create(cc.p(display.width*0.7,display.height*0.34)),
        cc.FadeIn:create(0.2),
        cc.FadeOut:create(0.1),
        cc.DelayTime:create(1.3),
        cc.Place:create(cc.p(display.width*0.4,display.height*0.45)),
        cc.Spawn:create({
            cc.ScaleTo:create(0.1,1.5),
            cc.FadeIn:create(0.1)
            }),
        cc.FadeOut:create(0.2)
        })

    local data1 = {node=self.layer.ownerNode,action=ownerAction}
    table.insert(self.data,data1)
    data1 = {node=cupid,action=cupidAction}
    table.insert(self.data,data1)
    data1 = {node=arrow ,action=arrowAction}
    table.insert(self.data,data1)
    data1 = {node=lefthand ,action=lefthandAction}
    table.insert(self.data,data1)
    data1 = {node=wings ,action=wingsAction}
    table.insert(self.data,data1)
    data1 = {node=heart ,action=heartAction}
    table.insert(self.data,data1)
    data1 = {node=heart1 ,action=heart1Action}
    table.insert(self.data,data1)
    data1 = {node=heart2 ,action=heart2Action}
    table.insert(self.data,data1)
    data1 = {node=star1 ,action=star1Action}
    table.insert(self.data,data1)
    data1 = {node=star2 ,action=star2Action}
    table.insert(self.data,data1)
    data1 = {node=bigStar ,action=bigStarAction}
    table.insert(self.data,data1)

end

function CupidNode:onExit()
    -- body
    display.removeSpriteFrames(self:getResourcePath("cupid.plist"), self:getResourcePath("cupid.png"))
end

function CupidNode:create(layer, msg)
    local node = CupidNode.new(layer, msg)
    node:init()
    return node
end

return CupidNode
