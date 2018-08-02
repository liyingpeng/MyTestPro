local VineNode=class("VineNode", require("app.gift.special.SpecialGiftNode"))
function VineNode:create(layer, msg)
    local node=VineNode.new(layer, msg)
    node:init()
    return node
end
function VineNode:init()
    display.loadSpriteFrames(self:getResourcePath("vine.plist"), self:getResourcePath("vine.png"))
    self:setName("VineNode")

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
        --定义其他动作
        cc.Spawn:create({
            cc.FadeIn:create(0.6),
            cc.MoveBy:create(0.6, cc.p(0, -500))
        }),
        cc.DelayTime:create(3.8),
        cc.EaseIn:create(
            cc.Spawn:create({
                cc.FadeTo:create(0.4, 0),
                cc.ScaleTo:create(0.4, 1.1)
            }),3.0),
        cc.CallFunc:create(function(el, data)
            self:afterAnimationEnd() 
            el:setOpacity(255)
            el:setVisible(false)
        end)
    })

--其他节点定义+动作
    local vine = display.newSprite("#vine.png") --花藤
    vine:setVisible(false)
    :setAnchorPoint(0.5,0.48)

    local vineAction = cc.Sequence:create({
        cc.CallFunc:create(function(el,data) 
            el:setVisible(true)
        end),
        cc.DelayTime:create(4.8),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
        end)
    })

    local mask = cc.ClippingNode:create() -- 蒙板
        mask:setVisible(true)
        :setAnchorPoint(0.5,0.5)
        :setPosition(cc.p(w*0.5, h*0.5))
        :setContentSize(cc.size(w,h))
        :setAlphaThreshold(0.5)
        :addChild(vine)



    local maskAction = cc.Sequence:create({
        cc.CallFunc:create(function(el,data) 
            el:setVisible(true)
            end),
        cc.DelayTime:create(4.8),
        cc.CallFunc:create(function(el,data) 
            el:setVisible(false)
            end)
        })

    local node3 = cc.Node:create():addChild(display.newSprite("#mask.png")) --蒙版形状
      node3:setAnchorPoint(0.5,1)
      :setVisible(false)
      :setPosition(cc.p(0.5*w, 0.1*h))


    local action3 = cc.Sequence:create({
        cc.CallFunc:create(function(el,data) 
            el:setVisible(true)
              :setScale(0.01)
            end),
        cc.EaseIn:create(cc.ScaleTo:create(0.2,0,0.2),3),
        cc.EaseIn:create(cc.ScaleTo:create(0.2,0.5,0.2),3),
        cc.EaseIn:create(cc.ScaleTo:create(0.2,1.0,0.2),3),
        cc.EaseIn:create(cc.ScaleTo:create(0.2,1.0,0.8),3),
        cc.EaseIn:create(cc.ScaleTo:create(0.2,1.0,1.8),3),
        cc.DelayTime:create(3.3),
        cc.FadeOut:create(0.5),
        cc.CallFunc:create(function(el,data)
            el:setVisible(false)
          end)
        })
    local size = mask:getContentSize()

    vine:setPosition(cc.p(size.width/2, size.height/2))
    mask:setStencil(node3)


    local butterfliesInfo ={ 
        {      --黄蝴蝶
            spr='#butterfly1_000.png',
            ax=0.5,
            ay=0.5,
            px=0.3*w,
            py=0.2*h,
            appear=0.4,
            deg=80,
            bezier={
                dur=2.5,
                p1={w*0.2,h*0.38},
                p2={w*0.8,h*0.45},
                des={w*0.85,h*0.28},
            },
            remain=0.5,
            rotate={
                dur=1,
                deg=-70,
            }
        },
        {      --蓝蝴蝶
            spr='#butterfly2_000.png',
            ax=0.55,
            ay=0.45,
            px=0.65*w,
            py=0.5*h,
            appear=0.3,
            deg=-80,
            bezier={
                dur=2.2,
                p1={w*0.6,h*0.5},
                p2={w*0.45,h*0.5},
                des={w*0.25,h*0.43},
            },
            remain=2,
            rotate={
                dur=0,
                deg=0,
            }
        },
    }

    local flowersInfo = {
        {      --1
            spr='#flower3.png',
            ax=0,
            ay=0,
            px=0.05,
            py=0.5,
            delay=1.4,
            scale=0.7,
            rotate=0
        },
        {      --2
            spr='#flower4.png',
            ax=1,
            ay=0,
            px=0.3,
            py=0.03,
            delay=0.8,
            scale=0.9,
            rotate=20
        },
        {      --3
            spr='#flower4.png',
            ax=0.5,
            ay=0,
            px=0.83,
            py=0.47,
            delay=2.3,
            scale=0.8,
            rotate=15
        },
        {      --4
            spr='#flower4.png',
            ax=0.5,
            ay=0,
            px=0.94,
            py=0.26,
            delay=1.6,
            scale=0.6,
            rotate=10
        },
        {      --5
            spr='#flower4.png',
            ax=0.5,
            ay=0,
            px=0.73,
            py=0.1,
            delay=1.4,
            scale=0.7,
            rotate=0
        }
    }

    local bloomInfo ={
       {                -- 1
            style=2,
            len=7,
            ax=0.5,
            ay=0,
            px=0.15,
            py=0.15,
            delay=0.9,
            rotate=-90,
            scale=0.6
        },
        {               -- 2
            style=1,
            len=16,
            ax=0.5,
            ay=0,
            px=0.17,
            py=0.08,
            delay=0.7,
            rotate=-10,
            scale=0.8
        },
        {               -- 3
            style=1,
            len=16,
            ax=0.5,
            ay=0,
            px=0.18,
            py=0.28,
            delay=1.4,
            rotate=-125,
            scale=0.7
        },
        {               -- 4
            style=1,
            len=16,
            ax=0.5,
            ay=0,
            px=0.22,
            py=0.2,
            delay=1.5,
            rotate=0,
            scale=0.9
        },
        {               --5
            style=2,
            len=7,
            ax=0.5,
            ay=0,
            px=0.25,
            py=0.35,
            delay=1.4,
            rotate=0,
            scale=0.8
        },
        {               --6
            style=1,
            len=16,
            ax=0.5,
            ay=0,
            px=0.24,
            py=0.44,
            delay=2.5,
            rotate=-100,
            scale=1
        },
        {               --7
            style=1,
            len=16,
            ax=0.5,
            ay=0,
            px=0.45,
            py=0.08,
            delay=1.1,
            rotate=-80,
            scale=1
        },
        {               --8
            style=1,
            len=16,
            ax=0.5,
            ay=0,
            px=0.75,
            py=0.15,
            delay=0.9,
            rotate=-90,
            scale=1
        },
        {           --9
            style=2,
            len=7,
            ax=0.5,
            ay=0,
            px=0.83,
            py=0.05,
            delay=1,
            rotate=0,
            scale=1
        },
        {           --10
            style=1,
            len=16,
            ax=0.5,
            ay=0,
            px=1,
            py=0.28,
            delay=1.2,
            rotate=-110,
            scale=0.9
        },
        {           --11
            style=2,
            len=7,
            ax=0.5,
            ay=0,
            px=0.84,
            py=0.46,
            delay=2.1,
            rotate=-110,
            scale=0.8
        },
        {           --12
            style=1,
            len=7,
            ax=0.5,
            ay=0,
            px=0.9,
            py=0.42,
            delay=2.2,
            rotate=-110,
            scale=1
        },
    }

    local leafInfo={
        {           --1
            spr='#leaf3.png',
            ax=1,
            ay=0,
            px=0.05,
            py=0.5,
            delay=1,
            scale=0.4,
            rotate=0
        },
        {            --2
            spr='#leaf1.png',
            ax=0,
            ay=0,
            px=0.04,
            py=0.48,
            delay=1,
            scale=0.4,
            rotate=0
        },
        {           --3
            spr='#leaf1.png',
            ax=0,
            ay=1,
            px=0.16,
            py=0.39,
            delay=1.6,
            scale=0.6,
            rotate=0
        },
        {           --4
            spr='#leaf1.png',
            ax=0,
            ay=0,
            px=0.14,
            py=0.2,
            delay=1.5,
            scale=0.5,
            rotate=0
        },
        {           --5
            spr='#leaf3.png',
            ax=1,
            ay=0,
            px=0.1,
            py=0.1,
            delay=1,
            scale=0.5,
            rotate=-30
        },
        {           --6
            spr='#leaf3.png',
            ax=1,
            ay=0,
            px=0.28,
            py=0.03,
            delay=1.2,
            scale=0.5,
            rotate=-10
        },
        {           --7
            spr='#leaf1.png',
            ax=0,
            ay=0,
            px=0.27,
            py=0.02,
            delay=1.2,
            scale=0.5,
            rotate=-10
        },
        {           --8
            spr='#leaf3.png',
            ax=1,
            ay=0,
            px=0.37,
            py=0.03,
            delay=1.2,
            scale=0.5,
            rotate=-15
        },
        {           --9
            spr='#leaf2.png',
            ax=0,
            ay=0,
            px=0.36,
            py=0.02,
            delay=1.2,
            scale=0.5,
            rotate=-10
        },
        {           --10
            spr='#leaf3.png',
            ax=1,
            ay=0.5,
            px=0.67,
            py=0.09,
            delay=1.2,
            scale=0.5,
            rotate=-30
        },
        {           --11
            spr='#leaf1.png',
            ax=0,
            ay=0,
            px=0.67,
            py=0.07,
            delay=1.2,
            scale=0.8,
            rotate=-10
        },
        {           --12
            spr='#leaf3.png',
            ax=1,
            ay=0,
            px=0.97,
            py=0.21,
            delay=1.1,
            scale=0.5,
            rotate=-30
        },
        {           --13
            spr='#leaf3.png',
            ax=1,
            ay=0.5,
            px=0.85,
            py=0.35,
            delay=1.5,
            scale=0.5,
            rotate=-20
        },
        {           --14
            spr='#leaf1.png',
            ax=0,
            ay=0,
            px=0.87,
            py=0.33,
            delay=1.5,
            scale=0.6,
            rotate=-10
        },
    }
    -- 摆动效果
    local swingAction=cc.Sequence:create({
            cc.RotateBy:create(0.3,4),
            cc.RotateBy:create(0.3,-4),
            cc.RotateBy:create(0.3,-4),
            cc.RotateBy:create(0.3,4),   
        })

    --粒子效果
    local _emitter= cc.ParticleSystemQuad:create(self:getResourcePath("vine_stars.plist"));
    _emitter:setPosition(0,h)

    local batch=cc.ParticleBatchNode:createWithTexture(_emitter:getTexture())
    batch:addChild(_emitter)
    self:addChild(batch,5)

    local _emitter2= cc.ParticleSystemQuad:create(self:getResourcePath("shine.plist"));
    _emitter2:setPosition(0.24*w,0.2*h)

    local batch2=cc.ParticleBatchNode:createWithTexture(_emitter:getTexture())
    batch2:addChild(_emitter2)
    self:addChild(batch2,6)




    self.data = {}
    local data1 = {node=self.layer.ownerNode,action=ownerAction}
    table.insert(self.data,data1)

    data1 = {node=vine,action=vineAction}
    table.insert(self.data,data1)

    data1 = {node=mask,action=maskAction}
    table.insert(self.data,data1)

    data1 = {node=node3,action=action3}
    table.insert(self.data,data1)

    --蝴蝶
    local butterflies={}
    local butterflyActions = {}
    for i=1, #butterfliesInfo do
        butterflies[i]= display.newSprite(); 
        butterflies[i]:setAnchorPoint(butterfliesInfo[i]['ax'],butterfliesInfo[i]['ay'])
        :setPosition(butterfliesInfo[i]['px'],butterfliesInfo[i]['py'])
        :setVisible(false)
        :setOpacity(0)
        :addTo(self,7)
       
        local butterflyFrames= display.newFrames("butterfly"..i.."_00%d.png",0,2,true);
        local butterflyAnimation=cc.Animation:createWithSpriteFrames(butterflyFrames,0.4);
        butterflyActions[i]= cc.Sequence:create({
            cc.DelayTime:create(butterfliesInfo[i]['appear']),
            cc.CallFunc:create(function(el,data) 
                el:setVisible(true)
                    :setOpacity(255)
                end),
            cc.Spawn:create(
                cc.BezierTo:create(
                    butterfliesInfo[i]['bezier']['dur'],
                    {
                        cc.p(butterfliesInfo[i]['bezier']['p1'][1],butterfliesInfo[i]['bezier']['p1'][2]),
                        cc.p(butterfliesInfo[i]['bezier']['p2'][1],butterfliesInfo[i]['bezier']['p2'][2]),
                        cc.p(butterfliesInfo[i]['bezier']['des'][1],butterfliesInfo[i]['bezier']['des'][2])
                    }
                ),
                cc.RotateBy:create(butterfliesInfo[i]['bezier']['dur'],butterfliesInfo[i]['deg']),
                cc.Repeat:create(cc.Animate:create(butterflyAnimation),2)
            ),

            cc.RotateBy:create(butterfliesInfo[i]['rotate']['dur'],butterfliesInfo[i]['rotate']['deg']),
            cc.Animate:create(butterflyAnimation),
            cc.DelayTime:create(butterfliesInfo[i]['remain']),
            cc.CallFunc:create(function(el,data)
                el:setVisible(false)
              end)
            })
        data1 = {node=butterflies[i],action=butterflyActions[i]}
        table.insert(self.data,data1)
    end

    
    --花
    local flowers={}
    local flowersActions = {}

    for i=1,#flowersInfo do
        flowers[i]=display.newSprite(flowersInfo[i]['spr'])
        flowers[i]:setVisible(false)
            :setAnchorPoint(flowersInfo[i]['ax'],flowersInfo[i]['ay'])
            :setPosition(flowersInfo[i]['px']*w,flowersInfo[i]['py']*h)
            :setScale(0.2)
            :addTo(self,3)

        flowersActions[i]=cc.Sequence:create({
            cc.RotateTo:create(0,flowersInfo[i]['rotate']),
            cc.DelayTime:create(flowersInfo[i]['delay']),
            cc.CallFunc:create(function(el,data) 
                el:setVisible(true)
                    :setOpacity(255)
                end),
            cc.ScaleTo:create(0.4,flowersInfo[i]['scale']),
            cc.Repeat:create(swingAction:clone(),10),
            cc.DelayTime:create(3),
            cc.CallFunc:create(function(el,data)
                el:setVisible(false)
              end)
            })
        data1 = {node=flowers[i],action=flowersActions[i]}
        table.insert(self.data,data1)
    end

    --绽放的花
    local bloom={}
    local bloomActions = {}
    
    for i=1,#bloomInfo do
        bloom[i]=display.newSprite();
        bloom[i]:setAnchorPoint(bloomInfo[i]['ax'],bloomInfo[i]['ay'])
        :setPosition(bloomInfo[i]['px']*w,bloomInfo[i]['py']*h)
        :setVisible(false)
        :addTo(self,4)

        local bloomFrames= display.newFrames("flower"..bloomInfo[i]['style'].."_00%d.png",0,bloomInfo[i]['len']);
        local bloomAnimation=cc.Animation:createWithSpriteFrames(bloomFrames,0.07);
        bloomActions[i] = cc.Sequence:create({
            cc.ScaleTo:create(0,bloomInfo[i]['scale']),
            cc.RotateTo:create(0,bloomInfo[i]['rotate']),
            cc.DelayTime:create(bloomInfo[i]['delay']),
            cc.CallFunc:create(function(el)
                el:setVisible(true);
            end),
            cc.Animate:create(bloomAnimation),
            cc.Repeat:create(swingAction:clone(),10),
            cc.DelayTime:create(2),
            cc.CallFunc:create(function(el)
                el:setVisible(false);
            end)
            });
        data1 = {node=bloom[i],action= bloomActions[i]}
        table.insert(self.data,data1)
    end

    -- 叶子

    local leaf={}
    local leafActions={}

    for i=1,#leafInfo do
        leaf[i]=display.newSprite(leafInfo[i]['spr']) 
        leaf[i]:setVisible(false)
            :setAnchorPoint(leafInfo[i]['ax'],leafInfo[i]['ay'])
            :setPosition(leafInfo[i]['px']*w,leafInfo[i]['py']*h)
            :addTo(self,5)

        leafActions[i]=cc.Sequence:create({
            cc.ScaleTo:create(0,0),
            cc.RotateTo:create(0,leafInfo[i]['rotate']),
            cc.DelayTime:create(leafInfo[i]['delay']),
            cc.CallFunc:create(function(el,data)
                el:setVisible(true)
            end),
            cc.ScaleTo:create(0.5,leafInfo[i]['scale']),
            cc.Repeat:create(swingAction:clone(),10),
            cc.CallFunc:create(function(el,data)
                el:setVisible(false)
              end)
        })
        data1 = {node=leaf[i],action= leafActions[i]}
        table.insert(self.data,data1)
    end

    self:addChild(mask,2)
end

function VineNode:setSafeAnchor(node, anchorX, anchorY)
    local diffX = anchorX * node:getContentSize().width  * (node:getScaleX() - 1)
    local diffY = anchorY * node:getContentSize().height * (node:getScaleY() - 1)

    node:setAnchorPoint(anchorX, anchorY)
    node:setPositionX(node:getPositionX() + diffX)
    node:setPositionY(node:getPositionY() + diffY)
end

function VineNode:onExit()
    printInfo("VineNode onExit!!!!")
    display.removeSpriteFrames(self:getResourcePath("vine.plist"), self:getResourcePath("vine.png"))
end

return VineNode
























