local WomanBoxNode=class("WomanBoxNode", require("app.gift.special.SpecialGiftNode"))
function WomanBoxNode:create(layer, msg)
    local node=WomanBoxNode.new(layer, msg)
    node:init()
    return node
end
function WomanBoxNode:init()
    display.loadSpriteFrames(self:getResourcePath("woman_box.plist"), self:getResourcePath("woman_box.png"))
    self:setName("WomanBoxNode")
    self:setVisible(true)
    --金主动作
    local ownerAction = cc.Sequence:create({
        cc.CallFunc:create(function(el, data)
            self:beforeAnimationStart() 
            el:align(display.CENTER, display.cx, display.cy + 120)
            el:setOpacity(0)
            el:setVisible(true)
        end),
        cc.FadeIn:create(0.5),
        cc.DelayTime:create(3),
        cc.FadeTo:create(0.5,100),
        --定义其他动作
        cc.CallFunc:create(function(el, data)
            self:afterAnimationEnd()
            el:setOpacity(255)
            el:setVisible(false)
        end)
    })

    local data1 = {node=self.layer.ownerNode,action=ownerAction}
    table.insert(self.data,data1)

    -- 盒子
    local box={}
    for i=0,11 do
        box[i] = display.newSpriteFrame("#box_00"..i..".png")
    end

    local boxAni= cc.Animation:createWithSpriteFrames(box,0.5/12)
    local animatebox = cc.Animate:create(boxAni)

    local node1 = display.newSprite("#box_001.png")
    node1:setAnchorPoint(0.5,0)
    :setPosition(cc.p(375,-500))
    :setScale(2)
    :setOpacity(255)

    local action1=cc.Sequence:create({
        cc.Spawn:create({
            cc.EaseBackOut:create(cc.MoveTo:create(0.5,cc.p(375,150))),
            cc.EaseIn:create(cc.ScaleTo:create(0.5,1),4)
            }),
        animatebox, --1
        cc.DelayTime:create(2.5),
        cc.Spawn:create({
            cc.ScaleTo:create(0.5,0.5),
            cc.MoveTo:create(0.5,cc.p(375,-300)),
            cc.FadeTo:create(0.5,160)
            }),
        cc.Hide:create()
    })
    data1 = {node=node1,action=action1}
    table.insert(self.data,data1)
    self:addChild(node1 ,2)

    --盒子背面
    local node2 = display.newSprite("#boxback.png")
    node2:setAnchorPoint(0.5,0)
    :setPosition(cc.p(255,290))
    :setScale(0.8)
    :setOpacity(255)

    local action2=cc.Sequence:create({
        cc.DelayTime:create(0.8),
        cc.EaseOut:create(cc.ScaleTo:create(0.2,1),50)
        -- cc.Show:create()
    })

    data1 = {node=node2,action=action2}
    table.insert(self.data,data1)
    node1:addChild(node2 , -6)

    --盒子盖子
    local node3 = display.newSprite("#boxtop_000.png")
    node3:setAnchorPoint(0.5,0)
    :setPosition(cc.p(252,210))
    :setScale(1)
    :setOpacity(255)

    local action3=cc.Sequence:create({
        cc.DelayTime:create(0.5),
        cc.EaseOut:create(cc.MoveTo:create(0.3,cc.p(252,170)),4),
        cc.Spawn:create({
            cc.EaseOut:create(cc.MoveTo:create(0.2,cc.p(252,400)),5),
            cc.RotateTo:create(0.2,20)
            }),   --1s
        cc.EaseIn:create(cc.MoveTo:create(0.3,cc.p(252,-110)),3),
        cc.RotateTo:create(0.1,0),
        cc.RotateTo:create(0.1,15),
        cc.RotateTo:create(0.1,0)  --1.6
    })

    data1 = {node=node3,action=action3}
    table.insert(self.data,data1)
    node1:addChild(node3 ,1)

    --左鞋 1.1s后
    local node4 = display.newSprite("#left.png")
    node4:setAnchorPoint(0.5,0.5)
    :setPosition(cc.p(250,150))
    :setScale(1)

    local action4=cc.Sequence:create({
        cc.DelayTime:create(1.1),
        cc.EaseOut:create(cc.BezierTo:create(0.5,{cc.p(250,150),cc.p(250,450),cc.p(350,400)}),2),
    })

    data1 = {node=node4,action=action4}
    table.insert(self.data,data1)
    node1:addChild(node4 ,-5)

    local node5 = display.newSprite("#perfume.png")
    node5:setAnchorPoint(0.5,0.5)
    :setPosition(cc.p(250,150))
    :setScale(1)
    :setOpacity(255)

    local action5=cc.Sequence:create({
        cc.DelayTime:create(1.1),
        cc.CallFunc:create(function()
            self:createPaper(node1)
        end),
        cc.EaseBackOut:create(cc.MoveTo:create(0.5,cc.p(250,380))), --1.6
        cc.CallFunc:create(function()
            self:createParticles()
        end),
    })

    data1 = {node=node5,action=action5}
    table.insert(self.data,data1)
    node1:addChild(node5 , -4)

    local node6 = display.newSprite("#right.png")
    node6:setAnchorPoint(0.5,0.5)
    :setPosition(cc.p(250,150))
    :setScale(1)
    :setOpacity(255)

    local action6=cc.Sequence:create({
        cc.DelayTime:create(1.1),
        cc.EaseOut:create(cc.BezierTo:create(0.5,{cc.p(250,150),cc.p(300,400),cc.p(400,350)}),2),
    })

    data1 = {node=node6,action=action6}
    table.insert(self.data,data1)
    node1:addChild(node6 ,-3)

    local node7 = display.newSprite("#pink_lip.png")
    node7:setAnchorPoint(0.5,0.5)
    :setPosition(cc.p(370,150))
    :setScale(1)
    :setOpacity(255)

    local action7=cc.Sequence:create({
        cc.DelayTime:create(1.1),
        cc.EaseOut:create(cc.BezierTo:create(0.5,{cc.p(370,150),cc.p(200,600),cc.p(140,350)}),2),
    })

    data1 = {node=node7,action=action7}
    table.insert(self.data,data1)
    node1:addChild(node7 ,-2)

    local node8 = display.newSprite("#red_lip.png")
    node8:setAnchorPoint(0.5,0.5)
    :setPosition(cc.p(370,150))
    :setScale(1)
    :setOpacity(255)

    local action8=cc.Sequence:create({
        cc.DelayTime:create(1.1),
        cc.EaseOut:create(cc.BezierTo:create(0.5,{cc.p(370,150),cc.p(200,600),cc.p(170,350)}),2),
    })

    data1 = {node=node8,action=action8}
    table.insert(self.data,data1)
    node1:addChild(node8 ,-1)

end

function WomanBoxNode:createParticles()
    -- body
    local star = cc.ParticleSystemQuad:create(self:getResourcePath("star_blink.plist"))
    star:setPosition(375,800)
        :setAnchorPoint(0.5,0.5)

    local starAction = cc.Sequence:create({
        cc.DelayTime:create(1.9),
        cc.CallFunc:create(function(el,data)
            el:removeFromParent()
        end)
        })

    self:addChild(star,2)
    star:runAction(starAction)
end

function WomanBoxNode:createPaper(box)
    -- body
    local paper1 = cc.ParticleSystemQuad:create(self:getResourcePath("box_redpaper.plist"))
        :setPosition(250,400)
        :setAutoRemoveOnFinish(true)
        :addTo(box,-5)
    local paper2 = cc.ParticleSystemQuad:create(self:getResourcePath("box_yellowpaper.plist"))
        :setPosition(250,420)
        :setAutoRemoveOnFinish(true)
        :addTo(box,-5)


    
end

function WomanBoxNode:onExit()
    printInfo("WomanBoxNode onExit!!!!")
    display.removeSpriteFrames(self:getResourcePath("woman_box.plist"), self:getResourcePath("woman_box.png"))
end
return WomanBoxNode