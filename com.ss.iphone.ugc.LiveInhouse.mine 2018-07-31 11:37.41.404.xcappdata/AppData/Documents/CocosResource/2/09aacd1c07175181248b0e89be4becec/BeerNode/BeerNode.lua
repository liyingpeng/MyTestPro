local BeerNode=class("BeerNode", require("app.gift.special.SpecialGiftNode"))

function BeerNode:init()
    display.loadSpriteFrames(self:getResourcePath("beer_elems.plist"), self:getResourcePath("beer_elems.png"))
    self:setName("BeerNode")
    self:setVisible(true)
    local ownerAction = cc.Sequence:create({
      cc.CallFunc:create(function(el,data)
            self:beforeBeerAnimationStart()
            el:align(display.CENTER, display.cx, display.height * 0.75)
            el:setScale(0.05)
            el:setOpacity(255)
            el:setVisible(true)
        end),
        cc.ScaleTo:create(0.5,1.1),
        cc.ScaleTo:create(0.2,1),
        cc.DelayTime:create(3.2),
        cc.ScaleTo:create(0.3,0.05),
        cc.CallFunc:create(function(el,data)
            self:afterBeerAnimationEnd()
            el:setVisible(false)
            el:setScale(1)
        end)
        })

    --左边的啤酒杯
    local beerLeftNode = display.newSprite("#beer_right_elem.png")
    beerLeftNode:setVisible(false)

    local beerLeftAction= cc.Sequence:create({
            cc.CallFunc:create(function(el,data)
                el:setPosition(cc.p(0,0.3*display.height + 204));
                el:setScale(1);
                el:setAnchorPoint(cc.p(1,0.5));
                el:setVisible(true);
                el:setCascadeOpacityEnabled(true);
                el:setOpacity(255);
            end),
            cc.Spawn:create({
                cc.EaseOut:create(cc.MoveBy:create(0.66, cc.p(400+60,0)),2),
                cc.RotateBy:create(0.66, 7)
                }),
            cc.MoveBy:create(0.12, cc.p(-20, 0)),
            cc.RotateBy:create(0.32, -5),
            cc.MoveBy:create(0.4, cc.p(-25,0)),
            cc.MoveBy:create(0.24, cc.p(15,0)),
            cc.MoveBy:create(0.4, cc.p(-60,0)),
            cc.MoveBy:create(0.56, cc.p(122, 0)),
            cc.DelayTime:create(0.16),
            cc.MoveBy:create(1, cc.p(-506,0)),
            cc.CallFunc:create(function(el,data)
                el:setVisible(false);
            end)
        })

    --右边的啤酒杯
    local beerRightNode = display.newSprite("#beer_left_elem.png")
    beerRightNode:setVisible(false)

    local beerRightAction = cc.Sequence:create({
        cc.CallFunc:create(function(el,data)
            el:setPosition(cc.p(display.width, 0.3*display.height + 215))
            el:setAnchorPoint(cc.p(0,0.5))
            el:setVisible(true)
            el:setCascadeOpacityEnabled(true)
            el:setOpacity(255)
            end),
        cc.Spawn:create({
            cc.EaseOut:create(cc.MoveBy:create(0.62, cc.p(-466,0)),2),
            cc.RotateBy:create(0.62, -7)
            }),
        cc.MoveBy:create(0.08, cc.p(20,0)),
        cc.RotateBy:create(0.4, 5),
        cc.MoveBy:create(0.4, cc.p(25,0)),
        cc.MoveBy:create(0.24, cc.p(-15,0)),
        cc.MoveBy:create(0.4, cc.p(101,0)),
        cc.MoveBy:create(0.56, cc.p(-122,0)),
        cc.DelayTime:create(0.16),
        cc.MoveBy:create(1, cc.p(506,0)),
        cc.CallFunc:create(function(el,data)
            el:setVisible(false)
            end)
        })

    --左边的star
    local starLeftNode = display.newSprite("#star_left_elem.png")
    starLeftNode:setVisible(false)

    local starLeftAction = cc.Sequence:create({
        cc.DelayTime:create(1.02),
        cc.CallFunc:create(function(el,data) 
            el:setPosition(cc.p(262 + 20, 0.3*display.height+340))
            el:setAnchorPoint(cc.p(0,0))
            el:setCascadeOpacityEnabled(true)
            el:setOpacity(255)
            el:setVisible(true)
            end),
        cc.DelayTime:create(0.32),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
            end),
        cc.DelayTime:create(0.4),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(true)
            end),
        cc.DelayTime:create(0.32),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
            end),
        cc.DelayTime:create(0.8),
        cc.CallFunc:create(function (el,data)
            el:setVisible(true)
        end),
        cc.DelayTime:create(0.32),
        cc.CallFunc:create(function(el,data)
            el:setVisible(false)
            end)
        })

    --右边的star
    local starRightNode = display.newSprite("#star_right_elem.png")
    starRightNode:setVisible(false)

    local starRightAction = cc.Sequence:create({
        cc.DelayTime:create(0.66),
        cc.CallFunc:create(function(el,data) 
            el:setAnchorPoint(cc.p(0,0))
            el:setPosition(cc.p(display.width - 407, 0.3*display.height + 316))
            el:setCascadeOpacityEnabled(true)
            el:setOpacity(255)
            el:setVisible(true)
            end),
        cc.DelayTime:create(0.32),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
            end),
        cc.DelayTime:create(0.48),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(true)
            end),
        cc.DelayTime:create(0.32),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
            end),
        cc.DelayTime:create(0.88),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(true)
            end),
        cc.DelayTime:create(0.32),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
            end)
        })

    --左边的spark
    local sparkLeftNode = display.newSprite("#spark_left_elem.png")
    sparkLeftNode:setAnchorPoint(cc.p(0,0))
    sparkLeftNode:setPosition(cc.p(260, 0.3*display.height+429))
    sparkLeftNode:setCascadeOpacityEnabled(true)
    sparkLeftNode:setOpacity(255)
    sparkLeftNode:setVisible(false)

    local sparkLeftAction = cc.Sequence:create({
        cc.DelayTime:create(0.5),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(true)
            end),
        cc.FadeTo:create(0.36, 60),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
            end),
        cc.DelayTime:create(0.4),
        cc.CallFunc:create(function(el,data) 
            el:setOpacity(255)
            el:setVisible(true)
            end),
        cc.DelayTime:create(0.4),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
            end),
        cc.DelayTime:create(0.72),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(true)
            end),
        cc.DelayTime:create(0.24),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
            end)
        })
    
    --右边的spark
    local sparkRightNode = display.newSprite("#spark_right_elem.png")
    sparkRightNode:setAnchorPoint(cc.p(0,0))
    sparkRightNode:setPosition(cc.p(380, 0.3*display.height+429))
    sparkRightNode:setCascadeOpacityEnabled(true)
    sparkRightNode:setOpacity(255)
    sparkRightNode:setVisible(false)

    local sparkRightAction = cc.Sequence:create({
        cc.DelayTime:create(0.5),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(true)
            end),
        cc.FadeTo:create(0.36, 60),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
            end),
        cc.DelayTime:create(0.4),
        cc.CallFunc:create(function(el,data) 
            el:setOpacity(255)
            el:setVisible(true)
            end),
        cc.DelayTime:create(0.4),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
            end),
        cc.DelayTime:create(0.72),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(true)
            end),
        cc.DelayTime:create(0.24),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
            end)
        })

    --中间的spark
    local  sparkMiddleNode = display.newSprite("#spark_middle_elem.png")
    sparkMiddleNode:setAnchorPoint(cc.p(0,0))
    sparkMiddleNode:setPosition(cc.p(320, 0.3*display.height+429))
    sparkMiddleNode:setCascadeOpacityEnabled(true)
    sparkMiddleNode:setOpacity(255)
    sparkMiddleNode:setVisible(false)

    local sparkMiddleAction = cc.Sequence:create({
        cc.DelayTime:create(0.5),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(true)
            end),
        cc.FadeTo:create(0.36, 60),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
            end),
        cc.DelayTime:create(0.4),
        cc.CallFunc:create(function(el,data) 
            el:setOpacity(255)
            el:setVisible(true)
            end),
        cc.DelayTime:create(0.4),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
            end),
        cc.DelayTime:create(0.72),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(true)
            end),
        cc.DelayTime:create(0.24),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
            end)
        })


    local data1 = {node=self.layer.ownerNode,action=ownerAction}
    table.insert(self.data,data1)
    data1 = {node=beerRightNode,action=beerLeftAction}
    table.insert(self.data,data1)
    data1 = {node=beerLeftNode,action=beerRightAction}
    table.insert(self.data,data1)
    data1 = {node=starLeftNode,action=starLeftAction}
    table.insert(self.data,data1)
    data1 = {node=starRightNode,action=starRightAction}
    table.insert(self.data,data1)
    data1 = {node=sparkLeftNode,action=sparkLeftAction}
    table.insert(self.data,data1)
    data1 = {node=sparkMiddleNode,action=sparkMiddleAction}
    table.insert(self.data, data1)
    data1 = {node=sparkRightNode,action=sparkRightAction}
    table.insert(self.data,data1)
    

    self:addChild(beerLeftNode,2)
    self:addChild(beerRightNode,1)
    self:addChild(starLeftNode,3)
    self:addChild(starRightNode,3)
    self:addChild(sparkLeftNode,3)
    self:addChild(sparkMiddleNode,3)
    self:addChild(sparkRightNode,3)

end

function BeerNode:beforeBeerAnimationStart()
    self:beforeAnimationStart()
    onSpecialAnimationStart()
end

function BeerNode:afterBeerAnimationEnd()
    self:afterAnimationEnd()
    onSpecialAnimationEnd()
end

function BeerNode:onExit()
    -- body
    printInfo("Beer  exit!!!!!!!!!!!!")
    display.removeSpriteFrames(self:getResourcePath("beer_elems.plist"), self:getResourcePath("beer_elems.png"))
end

function BeerNode:create(layer, msg)
    local node = BeerNode.new(layer, msg)
    node:init()
    return node
end

return BeerNode
