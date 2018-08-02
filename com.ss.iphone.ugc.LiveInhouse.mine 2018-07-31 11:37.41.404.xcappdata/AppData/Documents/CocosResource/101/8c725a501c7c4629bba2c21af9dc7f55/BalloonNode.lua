local BalloonNode=class("BalloonNode", require("app.gift.special.SpecialGiftNode"))

function BalloonNode:init()
    display.loadSpriteFrames(self:getResourcePath("balloon_elems.plist"), self:getResourcePath("balloon_elems.png"));
    self:setAnchorPoint(cc.p(0,0))
    self:setName("BalloonNode")
    self:setVisible(true)

     -- 金主动作
    local ownerAction = cc.Sequence:create({
            cc.DelayTime:create(0.1),
            cc.CallFunc:create(function(el,data)
                self:beforeAnimationStart()
                el:align(display.CENTER_BOTTOM, display.cx, 0)
                el:setOpacity(255)
                el:setVisible(true)
            end),
            cc.EaseOut:create(cc.MoveBy:create(2,cc.p(100, 0.3*display.height)),3),
            cc.DelayTime:create(2),
            cc.MoveBy:create(1, cc.p(-80, 0.2*display.height)),
            cc.MoveBy:create(1.3, cc.p(50, 0.3*display.height)),
            cc.DelayTime:create(0.1),
            cc.CallFunc:create(function(el,data)
                self:afterAnimationEnd()
                el:setVisible(false)
            end)
        })
    -- 左白气球
    local balloonWordWhiteNode1 = display.newSprite("#balloon-white-word.png")
    balloonWordWhiteNode1:setVisible(false)

    local balloonWordWhiteNode1Action = cc.Sequence:create({
    	cc.DelayTime:create(0.1),
    	cc.CallFunc:create(function(el,data) 
                el:setPosition(cc.p(0, 0))
                el:setScale(1)
                el:setAnchorPoint(cc.p(0,1))
                el:setVisible(true)
                el:setCascadeOpacityEnabled(true)
                el:setOpacity(255)
    		end),
    	cc.EaseOut:create(cc.MoveBy:create(2.5, cc.p(30, 0.6*display.height)), 2),
    	cc.Spawn:create({
                cc.MoveBy:create(0.5, cc.p(0, 20)),
                cc.RotateBy:create(0.5, -10)
    		}),
    	cc.Spawn:create({
                cc.MoveBy:create(0.5, cc.p(0, -20)),
                cc.RotateBy:create(0.5, 15)
    		}),
    	cc.MoveBy:create(0.5, cc.p(0, -20)),
    	cc.EaseIn:create(cc.MoveBy:create(2, cc.p(0, 0.4*display.height + 437)),2),
    	cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
    		end)
    	})

    local balloonWordWhiteNode2 = display.newSprite("#balloon-white-word.png")
    balloonWordWhiteNode2:setVisible(false)

    local balloonWordWhiteNode2Action = cc.Sequence:create({
    	cc.DelayTime:create(1.5),
    	cc.CallFunc:create(function(el,data) 
            el:setAnchorPoint(cc.p(0,1))
            el:setPosition(cc.p(display.width*0.5+30, 30))
            el:setRotation(-30)
            el:setScale(1)
            el:setVisible(true)
            el:setOpacity(255)
            el:setCascadeOpacityEnabled(true)
    		end),
    	cc.Spawn:create({
            cc.EaseOut:create(cc.MoveBy:create(1.67,cc.p(-100, 0.5*display.height-30)),2),
            cc.RotateBy:create(1.67, 35)
    		}),
    	cc.EaseIn:create(cc.MoveBy:create(2.83, cc.p(80, 0.5*display.height + 437)),2),
    	cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
    		end)
    	})

    local balloonWordPinkNode1 = display.newSprite("#balloon-pink-word.png")
    balloonWordPinkNode1:setVisible(false)

    local balloonWordPinkNode1Action = cc.Sequence:create({
    	cc.DelayTime:create(0.1),
        cc.CallFunc:create(function(el,data) 
            el:setAnchorPoint(cc.p(1,1))
            el:setPosition(cc.p(display.width - 100, 0))
            el:setScale(1)
            el:setCascadeOpacityEnabled(true)
            el:setOpacity(254)
            el:setVisible(true)
        	end),
        cc.Spawn:create({
        	cc.EaseOut:create(cc.MoveBy:create(2,cc.p(20, 0.5*display.height)),2),
        	cc.Sequence:create({
        		  cc.DelayTime:create(1),
        		  cc.ScaleTo:create(1, 0.9)
        		})
        	}),
        cc.Spawn:create({
            cc.MoveBy:create(1, cc.p(0,-40)),
            cc.ScaleTo:create(1, 1)
        	}),
        cc.Spawn:create({
        	cc.MoveBy:create(1, cc.p(0,30)),
        	cc.ScaleTo:create(1, 1.1),
        	cc.Sequence:create({
        		cc.RotateBy:create(0.67, -10),
        		cc.RotateBy:create(0.37, 15)
        		})
        	}),
        cc.Spawn:create({
        	cc.EaseIn:create(cc.MoveBy:create(2, cc.p(0, 0.5*display.height + 406)),2),
            cc.RotateBy:create(2, 10)
        	}),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
        	end)
    	})
    --粉气球们的动作
    
    local balloonPinkNodeTable = {}
    local balloonPinkNodeActionTable = {}
    local pinkPath = {1,1.5,2,3,3.5,4}
    math.randomseed(tostring(os.time()):reverse():sub(1, 6)) 
    for i=6,1,-1 do
        balloonPinkNodeTable[i] = display.newSprite("#balloon-pink.png")
        balloonPinkNodeTable[i]:setVisible(false)

        balloonPinkNodeActionTable[i] = cc.Sequence:create({
            cc.DelayTime:create(math.random(1,10)*0.2),
        	cc.CallFunc:create(function(el,data) 
                el:setAnchorPoint(cc.p(0,1))
                el:setPosition(cc.p(pinkPath[i]/10*display.width, 0))
                el:setScale(1)
                el:setCascadeOpacityEnabled(false)
                el:setOpacity(244)
                el:setVisible(true)
        		end),
        	cc.MoveBy:create(2, cc.p(50, (math.abs(pinkPath[i] - 7))*0.1*display.height)),
        	cc.EaseIn:create(cc.MoveBy:create(2, cc.p(-30, 0.7*display.height)),2),
        	cc.CallFunc:create(function(el,data) 
                el:setVisible(false)
        		end)
        	})
    end

    balloonPinkNodeTable[7] = display.newSprite("#balloon-pink.png")
    balloonPinkNodeTable[7]:setVisible(false)
    
    balloonPinkNodeActionTable[7] = cc.Sequence:create({
        	cc.CallFunc:create(function(el,data) 
                el:setAnchorPoint(cc.p(0,1))
                el:setPosition(cc.p(0.8*display.width, 0))
                el:setScale(1)
                el:setCascadeOpacityEnabled(false)
                el:setOpacity(244)
                el:setVisible(true)
        		end),
        	cc.MoveBy:create(2, cc.p(-50, 0.6*display.height)),
        	cc.MoveBy:create(2, cc.p(30, 0.4*display.height)),
        	cc.CallFunc:create(function(el,data) 
                el:setVisible(false)
        		end)
        	})

    --白气球们的动作
    local balloonWhiteNodeTable = {}
    local balloonWhiteNodeActionTable = {}
    local whitePath = {2,4,-3,-2}
    for i=4,1,-1 do
    	balloonWhiteNodeTable[i] = display.newSprite("#balloon-white.png")
    	balloonWhiteNodeTable[i]:setVisible(false)

        balloonWhiteNodeActionTable[i] = cc.Sequence:create({
            cc.DelayTime:create(i*0.5),
        	cc.CallFunc:create(function(el,data) 
                el:setAnchorPoint(cc.p(0,1))
                el:setPosition(cc.p(i/10*display.width+100, 0))
                el:setScale(1)
                el:setCascadeOpacityEnabled(false)
                el:setOpacity(244)
                el:setVisible(true)
        		end),
        	cc.MoveBy:create(2, cc.p(whitePath[i]*100, 0.4*display.height)),
        	cc.MoveBy:create(2, cc.p(-whitePath[i]*50, 0.6*display.height)),
        	cc.CallFunc:create(function(el,data) 
                el:setVisible(false)
        		end)
        	})
    end

    local data = {}
    local data1 = {node=self.layer.ownerNode,action=ownerAction}

    table.insert(data,data1)
    data1 = {node=balloonWordWhiteNode1,action=balloonWordWhiteNode1Action}
    table.insert(data,data1)
    data1 = {node=balloonWordWhiteNode2,action=balloonWordWhiteNode2Action}
    table.insert(data,data1)
    data1 = {node=balloonWordPinkNode1,action=balloonWordPinkNode1Action}
    table.insert(data,data1)
    for i=7,1,-1 do
        data1 = {node=balloonPinkNodeTable[i],action=balloonPinkNodeActionTable[i]}
        table.insert(data,data1)
    end

    for i=4,1,-1 do
        data1 = {node=balloonWhiteNodeTable[i],action=balloonWhiteNodeActionTable[i]}
        table.insert(data,data1)
    end
   
    self.data = data

    self:addChild(balloonWordWhiteNode1, 2)
    self:addChild(balloonWordWhiteNode2,3)
    self:addChild(balloonWordPinkNode1,2)
    for i=7,1,-1 do
    	self:addChild(balloonPinkNodeTable[i],1)
    end
    
    for i=4,1,-1 do
    	self:addChild(balloonWhiteNodeTable[i],1)
    end

end

function BalloonNode:onExit()
	printInfo("balloon is over heiheihei")
	display.removeSpriteFrames(self:getResourcePath("balloon_elems.plist"), self:getResourcePath("balloon_elems.png"))
end

function BalloonNode:create(layer, msg)
	local node = BalloonNode.new(layer, msg)
	node:init()
	return node
end

return BalloonNode;
