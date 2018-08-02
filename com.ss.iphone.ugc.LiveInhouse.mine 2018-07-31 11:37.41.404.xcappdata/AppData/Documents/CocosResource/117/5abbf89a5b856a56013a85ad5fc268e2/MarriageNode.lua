local MarriageNode=class("MarriageNode", require("app.gift.special.SpecialGiftNode"))

function MarriageNode:create(layer, msg)
    local node=MarriageNode.new(layer, msg)
    node:init(msg)
    return node
end
function MarriageNode:init(msg)
    display.loadSpriteFrames(self:getResourcePath("marriage.plist"), self:getResourcePath("marriage.png"))
    display.loadSpriteFrames(self:getResourcePath("bird.plist"), self:getResourcePath("bird.png"))
    self:setName("MarriageNode")
    self:setVisible(true)


--其他节点定义+动作
    local bgnode = display.newSprite("#certification2.png")
    bgnode:setVisible(false)
    :setAnchorPoint(0.5,0.5)
    :setOpacity(255)
    :setCascadeOpacityEnabled(true)

    local bgNodeWidth = bgnode:getContentSize().width
    local bgNodeHeight = bgnode:getContentSize().height

    local birdNode = display.newSprite("#bird_1.png")
    :setScale(0.9)
    :setAnchorPoint(0, 0)
    :addTo(bgnode,2)
    :setPosition(cc.p(40,0.6*bgNodeHeight+20))

    local birdAction = cc.Spawn:create({
            self:createAnimation(),
            cc.Sequence:create({
                cc.DelayTime:create(1.6),
                cc.CallFunc:create(function(el,data)
                    self:createHeartPetal(el)
                end)
            })
        })            

    local richNode = live.roundAvatarSprite(40,msg.userAvatarLocal):addTo(bgnode,2)
    richNode:setPosition(0.4*bgNodeWidth+17,0.5*bgNodeHeight-5)   
    :setAnchorPoint(0.5,0.5)
    :setVisible(true)
    richNode:setOnClickCallback(function()
        local event = live.LiveEvent:new(live.Constant.LIVE_EVENT_USER_CLICK,
            tostring(msg.userId), "")
        live.eventDispatcher:dispatch(event)
    end)

    local richAction = cc.Sequence:create({
        cc.DelayTime:create(3.4),
        cc.EaseIn:create(cc.FadeOut:create(0.6),0.6),
        cc.CallFunc:create(function(el, data)
            el:setOpacity(0)
            el:setVisible(false)
        end)
    })

    if (not msg.toUserAvatarLocal) then
        msg.toUserAvatarLocal = 'avatar_local.png'
    end

    local anchorNode = live.roundAvatarSprite(40,msg.toUserAvatarLocal):addTo(bgnode,2)
    anchorNode:setPosition(0.5*bgNodeWidth+57,0.5*bgNodeHeight-5)   
    :setAnchorPoint(0.5,0.5)
    :setVisible(true)
    anchorNode:setOnClickCallback(function()
        local event = live.LiveEvent:new(live.Constant.LIVE_EVENT_USER_CLICK,
            tostring(msg.toUserId), "")
        live.eventDispatcher:dispatch(event)
    end)

    local anchorAction = cc.Sequence:create({
        cc.DelayTime:create(3.4),
        cc.EaseIn:create(cc.FadeOut:create(0.6),0.6),
        cc.CallFunc:create(function(el, data)
            el:setOpacity(0)
            el:setVisible(false)
        end)
    })

    local bgAction=cc.Sequence:create({
        cc.CallFunc:create(function(el,data)
            self:beforeAnimationStart()
            el:setPosition(cc.p(0.5*display.width,display.height+bgNodeHeight))
            el:setVisible(true)
            self:createFlowerPetal(el)
        end),
        cc.EaseIn:create(cc.MoveTo:create(1.6,cc.p(0.5*display.width,0.5*display.height)),1.6),    
		cc.MoveBy:create(0.6,cc.p(0,60)),
        cc.MoveBy:create(0.4,cc.p(0,-30)),
        cc.MoveBy:create(0.4,cc.p(0,30)),
        cc.MoveBy:create(0.6,cc.p(0,-60)),
        cc.FadeOut:create(0.4),
        cc.CallFunc:create(function(el,data)
            self:afterAnimationEnd()
            el:setVisible(false)
        end)
    })

    local fly1 = display.newSprite("#butterfly.png")
    fly1:setVisible(false)
    :setAnchorPoint(0.5,0.5)
    :setOpacity(255)
    :setRotation(35)
    :addTo(bgnode,2)

    local flyAction1 = cc.Sequence:create({
        cc.CallFunc:create(function(el,data)
            el:setPosition(cc.p(0.2*bgNodeWidth+50,0.4*bgNodeHeight+50))
            el:setVisible(true)
        end),
        cc.Repeat:create(cc.Sequence:create({
			cc.ScaleTo:create(0.4,0.7,1),
			cc.ScaleTo:create(0.4,1,1)
			}),5)
    })

    local fly2 = display.newSprite("#butterfly2.png")
    fly2:setScale(0.8)
    :setVisible(false)
    :setAnchorPoint(0.5,0.5)
    :setOpacity(255)
    :setRotation(-45)
    :addTo(bgnode,2)

    local flyAction2 = cc.Sequence:create({
        cc.CallFunc:create(function(el,data)
            el:setPosition(cc.p(0.7*bgNodeWidth+50,0.3*bgNodeHeight))
            el:setVisible(true)
        end),
        cc.Repeat:create(cc.Sequence:create({
			cc.ScaleTo:create(0.4,0.6,0.8),
			cc.ScaleTo:create(0.4,0.8,0.8)
			}),5)
    })

    local strGift = textPack[send_mysterious_gift]
    local giftDescNode = cc.LabelTTF:create(strGift, 'fonts/arial.ttf',28)
    giftDescNode:setString(" "..msg.giftDesc.." ")
    giftDescNode:enableStroke(cc.c4b(78, 102, 243, 255), 6)
    giftDescNode:setAnchorPoint(0.5, 0.5)
    :setPosition(0.5*display.width,0.75*display.height)
    :setVisible(false)
    :addTo(self,3)

    local giftDescAction = cc.Sequence:create({
        cc.DelayTime:create(1.6),
        cc.CallFunc:create(function(el, data)
            el:setScale(0.05)
            el:setVisible(true)
        end),
        cc.Spawn:create({
            cc.ScaleTo:create(1,1),
            cc.FadeIn:create(1)
        }),        
        cc.DelayTime:create(1),
        cc.FadeOut:create(0.4),
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end)
    })

    self.data = {}

    local data1 = {node=bgnode,action=bgAction}
    table.insert(self.data,data1)

    data1 = {node=richNode,action=richAction}
    table.insert(self.data,data1)

    data1 = {node=anchorNode,action=anchorAction}
    table.insert(self.data,data1)

    data1 = {node=fly1,action=flyAction1}
    table.insert(self.data,data1)

    data1 = {node=fly2,action=flyAction2}
    table.insert(self.data,data1)

    data1 = {node=birdNode,action=birdAction}
    table.insert(self.data,data1)

    data1 = {node=giftDescNode,action=giftDescAction}
    table.insert(self.data,data1)

    self:addChild(bgnode, 3)
end

function MarriageNode:createAnimation()
    local birdFrames = {}
    for i = 1, 32 do
        birdFrames[#birdFrames + 1] = display.newSpriteFrame("bird_" .. i .. ".png")
    end
    local birdAction = cc.Animation:createWithSpriteFrames(birdFrames, 3.3/31 )
    local action = cc.Sequence:create({
        cc.CallFunc:create(function(el)
            el:show()
        end),
        cc.DelayTime:create(0.7),
        cc.Animate:create(birdAction)
    })
    return action
end

function MarriageNode:createFlowerPetal()

    local flower5 = cc.ParticleSystemQuad:create(self:getResourcePath("flower_elem_1.plist"))
    local flower6 = cc.ParticleSystemQuad:create(self:getResourcePath("flower_elem_2.plist"))
    local flower7 = cc.ParticleSystemQuad:create(self:getResourcePath("flower_elem_3.plist"))
    local flower8 = cc.ParticleSystemQuad:create(self:getResourcePath("flower_elem_4.plist"))

    flower5:setPosition(0.2*display.width,0.9*display.height)
    flower6:setPosition(0.4*display.width,0.6*display.height)
    flower7:setPosition(0.6*display.width,0.7*display.height)
    flower8:setPosition(0.9*display.width,0.4*display.height)

    flower5:setAutoRemoveOnFinish(true)
    flower6:setAutoRemoveOnFinish(true)
    flower7:setAutoRemoveOnFinish(true)
    flower8:setAutoRemoveOnFinish(true)

    self:addChild(flower5,4)
    self:addChild(flower6,1)
    self:addChild(flower7,1)
    self:addChild(flower8,1)

end

function MarriageNode:createHeartPetal(el)
    local heart_elem1 = cc.ParticleSystemQuad:create(self:getResourcePath("loveheart.plist"))
    local heart_elem2 = cc.ParticleSystemQuad:create(self:getResourcePath("loveheart.plist"))

    heart_elem1:setPosition(130,300)
    heart_elem2:setPosition(0.8*display.width,300)

    heart_elem1:setAutoRemoveOnFinish(true)
    heart_elem2:setAutoRemoveOnFinish(true)

    heart_elem1:addTo(el,2)
    heart_elem2:addTo(el,2)

end

function MarriageNode:onExit()
    printInfo("MarriageNode onExit!!!!")
    display.removeSpriteFrames(self:getResourcePath("marriage.plist"), self:getResourcePath("marriage.png"))
    display.removeSpriteFrames(self:getResourcePath("bird.plist"), self:getResourcePath("bird.png"))
end
return MarriageNode