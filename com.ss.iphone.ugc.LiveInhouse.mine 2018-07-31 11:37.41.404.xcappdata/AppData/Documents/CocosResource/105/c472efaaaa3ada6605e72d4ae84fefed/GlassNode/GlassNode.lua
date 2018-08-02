local GlassNode=class("GlassNode", require("app.gift.special.SpecialGiftNode"))
function GlassNode:create(layer, msg)
	local node=GlassNode.new(layer, msg)
	node:init()
	return node
end
function GlassNode:init()
	display.loadSpriteFrames(self:getResourcePath("glass_elems.plist"), self:getResourcePath("glass_elems.png"))
	self:setName("GlassNode")
	self:setVisible(true)
--金主动作
    local ownerNodeWidth = self.layer.ownerNode.width
    local ownerNodeHeight = self.layer.ownerNode.height
	local ownerAction = cc.Sequence:create({
		 cc.CallFunc:create(function(el,data)
            self:beforeAnimationStart()
            el:setPosition(0.5 * display.width, 0.6 * display.height + ownerNodeHeight*0.5)
            el:setAnchorPoint(0.5,0.5)
            el:setScale(0.05)
            el:setOpacity(255)
            el:setVisible(true)
        end),
        cc.Spawn:create({
            cc.MoveBy:create(0.5,cc.p(-0.525*ownerNodeWidth, -0.525*ownerNodeHeight)),
            cc.ScaleTo:create(0.5,1.1)
            }),
        cc.Spawn:create({
            cc.MoveBy:create(0.2, cc.p(0.05*ownerNodeWidth, 0.05*ownerNodeHeight)),
            cc.ScaleTo:create(0.2,1)
            }),
        cc.DelayTime:create(3),
         cc.Spawn:create({
            cc.MoveBy:create(0.5,cc.p(0.475*ownerNodeWidth, 0.475*ownerNodeHeight)),
            cc.FadeOut:create(0.2),
            cc.ScaleTo:create(0.5,0.05)
            }),
        cc.CallFunc:create(function(el,data)
            self:afterAnimationEnd()
            el:setVisible(false)
            el:setScale(1)
        end)
	})
--其他节点定义+动作
local node1 = display.newSprite("#glass_elem_black.png") -- 底图
      node1:setVisible(false)
      :setAnchorPoint(0.5,0.5)

local action1 = cc.Sequence:create({
	  cc.CallFunc:create(function(el,data) 
        el:setVisible(true)
	  	end),
	  cc.DelayTime:create(4),
	  cc.CallFunc:create(function(el,data) 
	  	el:setVisible(false)
	  	end)
	})

local node2 = cc.ClippingNode:create() -- 蒙板
	  node2:setVisible(false)
	  :setAnchorPoint(0.5,0.5)
      :setPosition(cc.p(display.width*0.5, display.height*0.5))
      :setContentSize(cc.size(display.width,display.height))
      :setAlphaThreshold(0.5)
      :addChild(node1)

local action2 = cc.Sequence:create({
	  cc.CallFunc:create(function(el,data) 
        el:setVisible(true)
	  	end),
	 cc.DelayTime:create(4),
	  cc.CallFunc:create(function(el,data) 
	  	el:setVisible(false)
	  	end)
	})


local node3 = cc.Node:create():addChild(display.newSprite("#star_mask_elem.png"))
      :setAnchorPoint(cc.p(0.5,0.5))
      :setPosition(cc.p(display.width/2, display.height/2))

local action3 = cc.Sequence:create({
    cc.CallFunc:create(function(el,data) 
    	el:setScale(0)
        el:setVisible(true)
	  	end),
	cc.EaseIn:create(cc.ScaleTo:create(0.8,2),3),
	cc.DelayTime:create(0.2),
	cc.EaseIn:create(cc.ScaleTo:create(0.8,3),3),
	cc.DelayTime:create(0.2),
	cc.EaseIn:create(cc.ScaleTo:create(0.8,5),3),
	cc.DelayTime:create(0.2),
	cc.EaseIn:create(cc.ScaleTo:create(0.8,9),3),
	cc.DelayTime:create(0.2),
	  cc.CallFunc:create(function(el,data)
	  el:setVisible(false)
	  end)
	})

local size = node2:getContentSize()
      node1:setPosition(cc.p(size.width/2, size.height/2))
      node2:setStencil(node3)

	self.data = {}
	local data1 = {node=self.layer.ownerNode,action=ownerAction}
	table.insert(self.data,data1)
	data1 = {node=node1,action=action1}
	table.insert(self.data,data1)
	data1 = {node=node2,action=action2}
	table.insert(self.data,data1)
	data1 = {node=node3,action=action3}
	table.insert(self.data,data1)
	self:addChild(node2,2)

end

function GlassNode:onExit()
	printInfo("GlassNode onExit!!!!")
	display.removeSpriteFrames(self:getResourcePath("glass_elems.plist"), self:getResourcePath("glass_elems.png"))
end
return GlassNode