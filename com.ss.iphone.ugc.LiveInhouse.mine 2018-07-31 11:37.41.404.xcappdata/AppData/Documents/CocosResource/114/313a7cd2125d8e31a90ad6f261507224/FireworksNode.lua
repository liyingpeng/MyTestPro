local FireworksNode=class("FireworksNode", require("app.gift.special.SpecialGiftNode"))
function FireworksNode:create(layer, msg)
    local node=FireworksNode.new(layer, msg)
    node:init()
    return node
end
function FireworksNode:init()
    display.loadSpriteFrames(self:getResourcePath("fireworks.plist"), self:getResourcePath("fireworks.png"))
    self:setName("FireworksNode")
    self:setVisible(true)

    local ownerNodeWidth = self.layer.ownerNode.width
    local ownerNodeHeight = self.layer.ownerNode.height
--金主动作
    local ownerAction = cc.Sequence:create({
        cc.CallFunc:create(function(el, data)
            self:beforeAnimationStart() 
            el:align(display.CENTER, display.cx, display.cy + 200)
            el:setOpacity(255)
            el:setVisible(true)
        end),
        cc.DelayTime:create(4),
        --定义其他动作
        cc.CallFunc:create(function(el, data)
            self:afterAnimationEnd() 
            el:setVisible(false)
        end)
    })

    self.data = {}
    local data1 = {node=self.layer.ownerNode,action=ownerAction}
    table.insert(self.data,data1)

--其他节点定义+动作
    local node1 = display.newSprite("#yellow.png")
    node1:setVisible(false)
    :setAnchorPoint(0.5,0)
    :setOpacity(255) 

    local action1=cc.Sequence:create({
        cc.CallFunc:create(function(el,data)
            el:setPosition(cc.p(-node1:getContentSize().width,0))
            el:setRotation(45)
            el:setScale(0.8)
            el:setVisible(true)
        end),
        cc.Spawn:create({
            cc.MoveTo:create(0.5,cc.p(node1:getContentSize().width * 0.3,display.height*0.3)),
            cc.ScaleTo:create(0.5,0.8,0.9)
            }),
        cc.ScaleTo:create(0.5,0.8,0.7),
        cc.ScaleTo:create(0.5,0.8,0.9),
        cc.CallFunc:create(function(el)
            self:createPaperPetal(el)
            end),
        cc.DelayTime:create(2),
        cc.FadeOut:create(1),
        cc.CallFunc:create(function(el,data)
            el:setVisible(false)
        end)
    })


    local node2 = display.newSprite("#blue.png")
    node2:setVisible(false)
    :setAnchorPoint(0.5,0)
    :setOpacity(255) 

    local action2=cc.Sequence:create({
        cc.CallFunc:create(function(el,data)
            el:setPosition(cc.p(display.width + node2:getContentSize().width,0))
            el:setRotation(-45)
            el:setScale(0.7)
            el:setVisible(true)
        end),
        cc.Spawn:create({
            cc.MoveTo:create(0.5,cc.p(display.width - node2:getContentSize().width*0.4,display.height*0.3)),
            cc.ScaleTo:create(0.5,0.7,0.8)
            }),
        cc.ScaleTo:create(0.5,0.7,0.6),
        cc.ScaleTo:create(0.5,0.7,0.8),
        cc.DelayTime:create(2),
        cc.FadeOut:create(1),
        cc.CallFunc:create(function(el,data)
            el:setVisible(false)
        end)
    })
----------------------------------------------------------------------------------
local position = {blue={cc.p(0.4*display.width, 0.4*display.height + 50),
                        cc.p(0.5*display.width, 0.5*display.height + 30),
                        cc.p(0.7*display.width, 0.45*display.height)},
                 red={cc.p(0.3*display.width, 0.5*display.height-50),
                      cc.p(0.5*display.width+100, 0.5*display.height),
                      cc.p(0.65*display.width, 0.4*display.height)},
                 yellow={cc.p(0.5*display.width-100, 0.5*display.height + 50),
                         cc.p(0.5*display.width, 0.4*display.height),
                         cc.p(0.8*display.width, 0.5*display.height)}}
local rotation = {blue={20,40,80},red={45,25,65},yellow={10,30,60}}
local scale = {blue={0.3,0.6,0.5},red={0.3,0.4,0.3},yellow={0.3,0.5,0.2}}

for i = 1, 3 do

    local nodenameblue = display.newSprite("#bluestar.png")
    nodenameblue:setVisible(false)
    :setAnchorPoint(0.5,0.5)
    :setOpacity(255)
    :setScale(0.01)

    local nodenamered = display.newSprite("#redstar.png")
    nodenamered:setVisible(false)
    :setAnchorPoint(0.5,0.5)
    :setOpacity(255)
    :setScale(0.01)

    local nodenameyellow = display.newSprite("#yellowstar.png")
    nodenameyellow:setVisible(false)
    :setAnchorPoint(0.5,0.5)
    :setOpacity(255)
    :setScale(0.01)

    local actionnameblue = self:createStarAction(position['blue'][i],rotation['blue'][i],scale['blue'][i])
    local actionnamered = self:createStarAction(position['red'][i],rotation['red'][i],scale['red'][i])
    local actionnameyellow = self:createStarAction(position['yellow'][i],rotation['yellow'][i],scale['yellow'][i])

    data1 = {node=nodenamered,action=actionnamered}
    table.insert(self.data,data1)
    

    data1 = {node=nodenameblue,action=actionnameblue}
    table.insert(self.data,data1)

    data1 = {node=nodenameyellow,action=actionnameyellow}
    table.insert(self.data,data1)


    self:addChild(nodenameblue , 3+i)
    self:addChild(nodenamered , 3+i)
    self:addChild(nodenameyellow , 3+i)

end
--------------------------------------------------------------

    data1 = {node=node1,action=action1}
    table.insert(self.data,data1)

    data1 = {node=node2,action=action2}
    table.insert(self.data,data1)

    self:addChild(node1 , 1)
    self:addChild(node2 , 1)


end
function FireworksNode:createStarAction(position,rotation,scale)
    local action = cc.Sequence:create({
        cc.CallFunc:create(function(el,data)
            el:setPosition(position)
            el:setRotation(rotation)
            el:setVisible(true)
        end),
        cc.DelayTime:create(1.5),
        cc.ScaleTo:create(0.3,scale),
        cc.RotateBy:create(1.2,360),
        cc.Spawn:create({
            cc.ScaleTo:create(0.7,0.01),
            cc.FadeOut:create(0.7),
            }),
        cc.CallFunc:create(function(el,data)
            el:setVisible(false)
        end)
    })

    return action
end

function FireworksNode:createPaperPetal()
    local paper1 = cc.ParticleSystemQuad:create(self:getResourcePath("redpaper.plist"))
    local paper2 = cc.ParticleSystemQuad:create(self:getResourcePath("yellowleftpaper.plist"))
    local paper3 = cc.ParticleSystemQuad:create(self:getResourcePath("bluepaper.plist"))
    local paper4 = cc.ParticleSystemQuad:create(self:getResourcePath("yellowrightpaper.plist"))

    paper1:setEmissionRate(paper1:getTotalParticles()/0.2)
    paper2:setEmissionRate(paper2:getTotalParticles()/0.1)
    paper3:setEmissionRate(paper3:getTotalParticles()/0.2)
    paper4:setEmissionRate(paper4:getTotalParticles()/0.1)

    paper1:setPosition(0.3*display.width-10, 0.4*display.height + 15)
    paper2:setPosition(0.3*display.width-10, 0.4*display.height + 15)
    paper3:setPosition(0.7*display.width+20, 0.4*display.height)
    paper4:setPosition(0.7*display.width+20, 0.4*display.height)

    paper1:setAutoRemoveOnFinish(true)
    paper2:setAutoRemoveOnFinish(true)
    paper3:setAutoRemoveOnFinish(true)
    paper4:setAutoRemoveOnFinish(true)

    self:addChild(paper1,1)
    self:addChild(paper2,2)
    self:addChild(paper3,3)
    self:addChild(paper4,2)

end

function FireworksNode:onExit()
    printInfo("FireworksNode onExit!!!!")
    display.removeSpriteFrames(self:getResourcePath("fireworks.plist"), self:getResourcePath("fireworks.png"))
end
return FireworksNode