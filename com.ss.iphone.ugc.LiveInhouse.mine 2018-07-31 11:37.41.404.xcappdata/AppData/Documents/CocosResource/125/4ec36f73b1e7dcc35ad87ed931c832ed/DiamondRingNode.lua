local DiamondRingNode=class("DiamondRingNode", require("app.gift.special.SpecialGiftNode"))

function DiamondRingNode:init()
    display.loadSpriteFrames(self:getResourcePath("ring.plist"), self:getResourcePath("ring.png"))
    self:setName("DiamondRingNode")

    local w=display.size.width
    local h=display.size.height
--金主动作
    local ownerAction = cc.Sequence:create({
        cc.CallFunc:create(function(el, data)
            self:beforeAnimationStart() 
            el:align(display.CENTER, display.cx, display.cy + 500)
            el:setOpacity(0)
            el:setVisible(true)
        end),
        -- 定义其他动作
        cc.Spawn:create({
            cc.FadeIn:create(0.2),
            cc.MoveBy:create(0.2, cc.p(0, -400))
        }),
        cc.DelayTime:create(2.4),
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

--其他节点定义+动作
    local spriteBox = display.newSprite("#ring_007.png")
    spriteBox:setAnchorPoint(0.5,0.5)
    :setPosition(0.5*w,0.3*h+100)
    :addTo(self,2)
    :setScale(0.4)
    :setVisible(true)

    local boxAction =cc.Sequence:create({
        cc.EaseSineOut:create(cc.ScaleTo:create(0.5,1)),
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end),

    })

    local spriteOpen = display.newSprite();
    spriteOpen:setAnchorPoint(0.5,0.5)
    :setPosition(0.5*w,0.3*h+100)
    :addTo(self,2)
    :setVisible(true)

    local openFrame={}
    for i=1,8 do
        if i<4 then
            openFrame[i] = display.newSpriteFrame("#ring_00"..(i+6)..".png")
        else
            openFrame[i] = display.newSpriteFrame("#ring_0"..(i+6)..".png")
        end    
    end

    local openAnimation = cc.Animation:createWithSpriteFrames(openFrame,.5/8)
    local openAnimate = cc.Animate:create(openAnimation)
    local openAction=cc.Sequence:create({
        cc.DelayTime:create(0.5),
        openAnimate,
        cc.DelayTime:create(1.6),
        cc.FadeOut:create(.4),
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end),

    })

    local stars={}
    local starsPos={{0.3,0.3},{0.4,0.35},{0.55,0.33},{0.6,0.25},{0.5,0.23},{0.35,0.26},{0.5,0.3},{0.5,0.23}}
    local starsScale={0.35,0.25,0.35,0.24,0.35,0.2,0.18,0.2}
    local starsDelay={0.7,0.9,0.8,0.9,1,0.7,0.8,1}

    for i=1,8 do
        stars[i] = display.newSprite('#star.png');
        stars[i]:setVisible(false)
        :setPosition((starsPos[i][1])*w, starsPos[i][2]*h+100)
        :setScale(starsScale[i])
        :addTo(self,4)
    end
    
    local starsActions={}
    for i=1,8 do
        starsActions[i]= cc.Sequence:create({
            cc.DelayTime:create(0.4+starsDelay[i]),
            cc.CallFunc:create(function(el,data)
                el:setVisible(true)
            end),
            cc.FadeIn:create(.4),
            cc.FadeOut:create(.4),
            cc.FadeIn:create(.4),
            cc.FadeOut:create(.4),
            cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end),
        })
    end

    self.data = {}

    local data1 = {node=self.layer.ownerNode,action=ownerAction}
    table.insert(self.data,data1)

    data1 = {node=spriteBox,action=boxAction}
    table.insert(self.data,data1)

    data1 = {node=spriteOpen,action=openAction}
    table.insert(self.data,data1)

    for i=1,8 do
        data1 = {node=stars[i],action=starsActions[i]}
        table.insert(self.data,data1)
    end
end

function DiamondRingNode:onExit()
    printInfo("DiamondRingNode onExit!!!!")
    display.removeSpriteFrames(self:getResourcePath("ring.plist"), self:getResourcePath("ring.png"))
end

function DiamondRingNode:create(layer, msg)
    local node=DiamondRingNode.new(layer, msg)
    print(node:beforeAnimationStart())
    node:init()
    return node
end
return DiamondRingNode