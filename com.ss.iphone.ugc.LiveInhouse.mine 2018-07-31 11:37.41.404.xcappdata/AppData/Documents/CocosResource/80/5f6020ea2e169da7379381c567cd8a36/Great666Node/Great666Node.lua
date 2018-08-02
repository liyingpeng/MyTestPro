local Great666Node=class("Great666Node", require("app.gift.special.SpecialGiftNode"))
function Great666Node:create(layer, msg)
    local node=Great666Node.new(layer, msg)
    node:init()
    return node
end
function Great666Node:init()
    display.loadSpriteFrames(self:getResourcePath("great_666.plist"), self:getResourcePath("great_666.png"))
    display.loadSpriteFrames(self:getResourcePath("hand_666.plist"), self:getResourcePath("hand_666.png"))
    self:setName("Great666Node")

--金主动作
    local w=display.size.width
    local h=display.size.height
    
    local ownerAction = cc.Sequence:create({
        cc.CallFunc:create(function(el, data)
            self:beforeAnimationStart() 
            el:align(display.CENTER, display.cx, display.cy + 500)
            el:setOpacity(255)
            el:setVisible(true)
        end),
        -- 定义其他动作
         cc.Spawn:create({
            cc.FadeTo:create(0.2, 255),
            cc.MoveTo:create(0.2, cc.p(0.5 * w-0.5*self.layer.ownerNode.width, 0.5 * h))
        }),

        cc.DelayTime:create(2.6),

        cc.EaseIn:create(
            cc.Spawn:create({
                cc.FadeTo:create(0.4, 0),
                cc.ScaleTo:create(0.4, 1.1)
            }),3.0),

        cc.CallFunc:create(function(el, data)
            self:afterAnimationEnd() 
            el:setVisible(false)
        end)
    })

    --666
    local sprite666 = display.newSprite();
    sprite666:setAnchorPoint(0.5,0)
    :setPosition(0.5*w,0.1*h)
    :addTo(self,2)
    :setVisible(true)

    local allFrame={}
    for i=12,67 do
        allFrame[i] = display.newSpriteFrame("#loose_pulley_000"..i..".png")
    end

    local animation666 = cc.Animation:createWithSpriteFrames(allFrame,2/56)
    local animate666 = cc.Animate:create(animation666)
    local action1=cc.Sequence:create({
        cc.DelayTime:create(0.5),
        animate666,
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end),

    })

    --  shadow
    local shadow= display.newSprite("#shadow.png") 
    shadow:setAnchorPoint(0.5,1)
    :setPosition(0.5*w,0.1*h)
    :addTo(self,2)
    :setVisible(false)

    local shadowAction = cc.Sequence:create({
        cc.DelayTime:create(0.5),
        cc.CallFunc:create(function(el, data)
            el:setVisible(true)
        end),
        cc.DelayTime:create(2),
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end),

    })  

    -- hand
    local rotateAction=cc.Sequence:create({
            cc.RotateBy:create(0.1,15),
            cc.MoveBy:create(0.05,cc.p(-0.01*w,0)),
            cc.RotateBy:create(0.1,-15),
            cc.RotateBy:create(0.1,-15),
            cc.MoveBy:create(0.05,cc.p(0.01*w,0)),
            cc.RotateBy:create(0.1,15),   
        })

    local hand1 = display.newSprite('#hand1.png')
    hand1:setVisible(false)
    :setAnchorPoint(0.7,0.4)
    :addTo(self,3)

    local hand2 = display.newSprite('#hand2.png')
    hand2:setVisible(false)
    :setAnchorPoint(0.3,0.2)
    :addTo(self,3)

    local hand3 = display.newSprite('#hand3.png')
    hand3:setVisible(false)
    :setAnchorPoint(0.2,0.2)
    :addTo(self,3)


    local hand4 = display.newSprite('#hand4.png')
    hand4:setVisible(false)
    :setAnchorPoint(0.7,0.3)
    :addTo(self,3)

    local handAction1=cc.Sequence:create({
        cc.DelayTime:create(0.5),
        cc.CallFunc:create(function(el,data)
            el:setPosition(1.5*w,0.45*h)
            el:setVisible(true)
        end),
        cc.EaseIn:create(cc.MoveTo:create(0.3,cc.p(w,0.45*h)),1),
        cc.Repeat:create(rotateAction,4),
        cc.FadeOut:create(0.8),
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end),

        })
 
    local handAction2=cc.Sequence:create({
        cc.DelayTime:create(0.7),
        cc.RotateTo:create(0,25),
        cc.CallFunc:create(function(el,data)
            el:setPosition(-0.5*w,0.45*h)
            el:setVisible(true)
        end),
        cc.EaseIn:create(cc.MoveTo:create(0.3,cc.p(0,0.45*h)),1),
        cc.Repeat:create(rotateAction:clone(),4),
        cc.FadeOut:create(0.3),
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end),

        })

    local handAction3=cc.Sequence:create({
        cc.RotateTo:create(0,15),
        cc.CallFunc:create(function(el,data)
            el:setPosition(-0.5*w,0.25*h)
            el:setVisible(true)
        end),
        cc.EaseIn:create(cc.MoveTo:create(0.3,cc.p(0,0.25*h)),1),
        cc.Repeat:create(rotateAction:clone(),5),
        cc.FadeOut:create(0.7),
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end),

        })

    local handAction4=cc.Sequence:create({
        cc.DelayTime:create(.3),
        cc.RotateTo:create(0,-15),
        cc.CallFunc:create(function(el,data)
            el:setPosition(1.5*w,0.25*h)
            el:setVisible(true)
        end),
        cc.EaseIn:create(cc.MoveTo:create(0.3,cc.p(w,0.25*h)),1),
        cc.Repeat:create(rotateAction:clone(),4),
        cc.FadeOut:create(0.9),
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end),

        })

    local stars={}
    stars[1] = display.newSprite('#start-yellow.png');
    stars[1]:setVisible(false)
    :setPosition(0.11*w,0.6*h)
    :setScale(.8)
    :addTo(self,4)

    stars[2] = display.newSprite('#start-yellow.png');
    stars[2]:setVisible(false)
    :setScale(.7)
    :setPosition(0.16*w,0.3*h)
    :addTo(self,4)

    stars[3] = display.newSprite('#start-yellow.png');
    stars[3]:setVisible(false)
    :setScale(.8)
    :setPosition(0.2*w,0.33*h)
    :addTo(self,4)

    stars[4] = display.newSprite('#start-blue.png');
    stars[4]:setVisible(false)
    :setScale(.8)
    :setPosition(0.2*w,0.14*h)
    :addTo(self,4)

    stars[5] = display.newSprite('#start-red.png');
    stars[5]:setVisible(false)
    :setScale(.6)
    :setPosition(0.4*w,0.4*h)
    :addTo(self,4)


    stars[6] = display.newSprite('#start-yellow.png');
    stars[6]:setVisible(false)
    :setPosition(0.6*w,0.38*h)
    :addTo(self,4)


    stars[7] = display.newSprite('#start-yellow.png');
    stars[7]:setVisible(false)
    :setScale(.8)
    :setPosition(0.82*w,0.4*h)
    :addTo(self,4)


    stars[8] = display.newSprite('#start-yellow.png');
    stars[8]:setVisible(false)
    :setScale(.8)
    :setPosition(0.8*w,0.17*h)
    :addTo(self,4)

    stars[9] = display.newSprite('#start-yellow.png');
    stars[9]:setVisible(false)
    :setScale(.8)
    :setPosition(0.21*w,0.17*h)
    :addTo(self,4)

    stars[10] = display.newSprite('#start-red.png');
    stars[10]:setVisible(false)
    :setPosition(0.42*w,0.3*h)
    :addTo(self,4)

    local starsAction = cc.Sequence:create({
        cc.CallFunc:create(function(el,data)
            el:setVisible(true)

        end),
        cc.Blink:create(1.7,4),
        cc.FadeOut:create(.3),
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end),
    })
    
    local starsActions={}
    for i=1,10 do
        starsActions[i]= cc.Sequence:create({
            cc.DelayTime:create(math.random(6,10)/10),
            starsAction:clone(),
        })
    end

    self.data = {}
    local data1 = {node=self.layer.ownerNode,action=ownerAction}
    table.insert(self.data,data1)

    data1 = {node=sprite666,action=action1}
    table.insert(self.data,data1)

    data1 = {node=shadow,action=shadowAction}
    table.insert(self.data,data1)

    data1 = {node=hand1,action=handAction1}
    table.insert(self.data,data1)

    data1 = {node=hand2,action=handAction2}
    table.insert(self.data,data1)

    data1 = {node=hand3,action=handAction3}
    table.insert(self.data,data1)

    data1 = {node=hand4,action=handAction4}
    table.insert(self.data,data1)

    for i=1,10 do
        data1 = {node=stars[i],action=starsActions[i]}
        table.insert(self.data,data1)
    end

end
function Great666Node:onExit()
    printInfo("Great666Node onExit!!!!")
    display.removeSpriteFrames(self:getResourcePath("great_666.plist"), self:getResourcePath("great_666.png"))
    display.removeSpriteFrames(self:getResourcePath("hand_666.plist"), self:getResourcePath("hand_666.png"))
end
return Great666Node