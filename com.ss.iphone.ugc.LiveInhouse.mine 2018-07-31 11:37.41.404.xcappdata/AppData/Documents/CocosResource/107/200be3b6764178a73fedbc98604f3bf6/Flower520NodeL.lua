local Flower520Node = class("Flower520Node", require("app.gift.special.SpecialGiftNode"))

function Flower520Node:create(layer, msg)
    local node = Flower520Node.new(layer, msg)
    node:init()
    return node
end

function Flower520Node:init()
    display.loadSpriteFrames(self:getResourcePath("flowerBox.plist"), self:getResourcePath("flowerBox.png"))
    self:setVisible(true)
    
    local ownerNodeWidth = self.layer.ownerNode.width
    local ownerNodeHeight = self.layer.ownerNode.height

    local ownerAction = cc.Sequence:create({
        cc.DelayTime:create(1),
        cc.CallFunc:create(function(el,data)
            self:beforeFlowerAnimationStart()
            el:align(display.CENTER, display.cx, display.size.height - 100)
            el:setScale(0.05)
            el:setOpacity(255)
            el:setVisible(true)
        end),
        cc.ScaleTo:create(0.5,1.1),
        cc.ScaleTo:create(0.2,1),
        cc.DelayTime:create(3),
        cc.Spawn:create({
            cc.FadeOut:create(0.2),
            cc.ScaleTo:create(0.5,0.05)
            }),
        cc.CallFunc:create(function(el,data)
            self:afterFlowerAnimationEnd()
            el:setVisible(false)
            el:setOpacity(255)
            el:setScale(1)
        end)
    })

    local flowerBoxNode = display.newSprite("#flowerbox_elem.png")
    flowerBoxNode:setVisible(false)

    local flowerBoxAction = cc.Sequence:create({
        cc.CallFunc:create(function(el,data) 
           el:setAnchorPoint(0.5,0.5)
           el:setPosition(cc.p(display.width*0.5, -50))
           el:setScale(0.3)
           el:setOpacity(255)
           el:setVisible(true)
            end),
         cc.CallFunc:create(function(el,data) 
            self:createFlowerPetal(el)
            end),
        cc.Spawn:create({
            cc.EaseSineIn:create(cc.MoveBy:create(0.83, cc.p(0,20+ 0.5*display.height))),
            cc.ScaleTo:create(0.83, 0.54)
            }),
        cc.CallFunc:create(function(el,data) 
            self:createStarPetal(el)
            end),
        cc.ScaleTo:create(0.13, 0.5),
        cc.DelayTime:create(4.4),
        cc.CallFunc:create(function(el,data)
            el:setVisible(false)
         end)
        })

    self.data = {}
    local data1 = {node=self.layer.ownerNode,action=ownerAction}
    table.insert(self.data,data1)
    data1 = {node=flowerBoxNode,action=flowerBoxAction}
    table.insert(self.data,data1)

    self:addChild(flowerBoxNode,2)
end

function Flower520Node:createFlowerPetal()
    local flower1 = cc.ParticleSystemQuad:create(self:getResourcePath("flower_elem1.plist"))
    local flower2 = cc.ParticleSystemQuad:create(self:getResourcePath("flower_elem2.plist"))
    local flower3 = cc.ParticleSystemQuad:create(self:getResourcePath("flower_elem3.plist"))
    local flower4 = cc.ParticleSystemQuad:create(self:getResourcePath("flower_elem4.plist"))

    flower1:setPosition(display.width,0.7*display.height)
    flower2:setPosition(display.width,0.5*display.height)
    flower3:setPosition(display.width,0.6*display.height)
    flower4:setPosition(display.width,0.5*display.height)

    flower1:setAutoRemoveOnFinish(true)
    flower2:setAutoRemoveOnFinish(true)
    flower3:setAutoRemoveOnFinish(true)
    flower4:setAutoRemoveOnFinish(true)

    self:addChild(flower1,4)
    self:addChild(flower2,1)
    self:addChild(flower3,1)
    self:addChild(flower4,1)

end

function Flower520Node:createStarPetal()
    local star = cc.ParticleSystemQuad:create(self:getResourcePath("star_elems.plist"))
    star:setPosition(0.5*display.width, 0.5*display.height)

    star:setAutoRemoveOnFinish(true)
    self:addChild(star,3)
end

function Flower520Node:onExit() 
    printInfo('Flower520 exit!')
    display.removeSpriteFrames(self:getResourcePath("flowerBox.plist"), self:getResourcePath("flowerBox.png"))
    end

function Flower520Node:beforeFlowerAnimationStart()
    self:beforeAnimationStart()
    onSpecialAnimationStart()
end

function Flower520Node:afterFlowerAnimationEnd()
    self:afterAnimationEnd()
    onSpecialAnimationEnd()
end
return Flower520Node


