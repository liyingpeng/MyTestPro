local HotAirBalloonNode=class("HotAirBalloonNode", require("app.gift.special.SpecialGiftNode"))

function HotAirBalloonNode:init()
    self.require3D = true
    self:setName("HotAirBalloonNode")
    self:setVisible(true)
    self.winsize=display

    local w = display.width
    local h = display.height

    local ownerAction = cc.Sequence:create({
            -- cc.DelayTime:create(3.5),
            cc.CallFunc:create(function(el,data)
                self:beforeAnimationStart();
                el:align(display.CENTER, 0.5*w, h * 0.6)
                el:setOpacity(255)
                el:setVisible(true)
            end),
            cc.FadeIn:create(1),
            cc.DelayTime:create(5),
            cc.FadeOut:create(1),
            cc.CallFunc:create(function(el,data)
                self:afterAnimationEnd()
                el:setOpacity(255)
                el:setVisible(false); 
            end)
        });

    local data1 = {node=self.layer.ownerNode,action=ownerAction}
    table.insert(self.data,data1)

    -- 粒子效果

    local _emitter= cc.ParticleSystemQuad:create(self:getResourcePath("shine.plist"));
    _emitter:setPosition(0.24*w,0.2*h)

    local batch=cc.ParticleBatchNode:createWithTexture(_emitter:getTexture())
    batch:addChild(_emitter)
    self:addChild(batch)

     local _emitter2= cc.ParticleSystemQuad:create(self:getResourcePath("shine.plist"));
    _emitter2:setPosition(0.15*w,0.65*h)

    local batch2=cc.ParticleBatchNode:createWithTexture(_emitter2:getTexture())
    batch2:addChild(_emitter2)
    self:addChild(batch2)

    local balloons ={
        -- 远处气球 左 中 右
        {
            spr="balloon_pink.c3b",
            pos={0.1*w,-0.1*h, -500},
            rotate={0,0,0},
            scale=0.5,

            pos_by={{7,-0.2*w,1.7*h,-100}},
            rotate_by={{8,0,-130,0}},
        },
        {
            spr="balloon_blue.c3b",
            pos={0.35*w,-0.1*h, -100},
            rotate={20,0,0},
            scale=0.6,

            pos_by={{6,-0.23*w,1.4*h, -200}},
            rotate_by={{8,-30,190,0}},
        },
        {
            spr="balloon_purple.c3b",
            pos={0.7*w,0.1*h, -600},
            rotate={0,0,0},
            scale=0.6,

            pos_by={
                {4,-0.15*w,0.78*h, -50},
                {3,0.1*w,0.55*h, 150}
            },
            rotate_by={
                 {4,0,-100,0},
                 {4,0,60,0}
            },
        },
        -- 近处气球 上 中 下
        {
            spr="balloon_purple.c3b",
            -- spr="balloon_purple.c3b",
            pos={0.35*w, 0.5*h, 0},
            rotate={0,0,0},
            scale=1.5,

            pos_by={
                {2, 0.1*w,0.2*h, 100},
                {6, -0.4*w,0.5*h, -120}
            },
            rotate_by={
                {2, 2, -80, 0},
                {6, -6, 240, 0}
            },
        },
        {
            spr="balloon_blue.c3b",
            -- spr="balloon_blue.c3b",
            pos={0.8*w,0.2*h, -100},
            rotate={0,0,0},
            scale=1.2,

            pos_by={
                {5, 0.1*w, 0.6*h, 60},
                {3, -0.12*w, 0.4*h, 60},
            },
            rotate_by={
                {5, 0, 150, 0},
                {3, 0, -90, 0}
            },
        },
        {
            spr="balloon_pink.c3b",
            pos={0.5*w,-0.3*h, 190},
            rotate={20,0,0},
            scale=1.6,

            pos_by={
                {4, -0.15*w,0.8*h, 160},
                {4, 0.075*w,0.6*h, -40},
            },
            rotate_by={
                {8,-20, -380, 0}
            },
        },

    }

    local hearts ={
        -- 深色气球 上->下
        {
            spr="heart_deep.c3b",
            pos={0.8*w,0.5*h, 200},
            rotate={0,0,0},
            scale=1.8,

            pos_by={
                {2.5,-0.05*w,0.25*h,-100},
                {2.5,0.05*w,0.35*h,-100}
            },
            rotate_by={{5,-15,10,0}},
        },
        {
            spr="heart_deep.c3b",
            pos={0.17*w,0.2*h, 200},
            rotate={0,0,0},
            scale=1.5,

            pos_by={
                {3,-0.1*w,0.5*h,-250},
                {5,0.15*w,0.5*h,550}
            },
            rotate_by={{8,-5,30,0}},
        },
        {
            spr="heart_deep.c3b",
            pos={0.37*w,0.05*h, 100},
            rotate={-10,-30,0},
            scale=3,

            pos_by={
                {2.5,0.1*w,0.65*h,-350},
                {3.5,0.25*w,0.75*h,250}
            },
            rotate_by={
                {8,40,100,0}
            },
        },
        {
            spr="heart_deep.c3b",
            pos={0.5*w,-0.25*h, 0},
            rotate={-10,-30,0},
            scale=2,

            pos_by={
                {3.5,0.2*w,0.75*h,-350},
                {3.5,-0.3*w,0.8*h,150}
            },
            rotate_by={
                {8,40,-20,0}
            },
        },
        {
            spr="heart_deep.c3b",
            pos={0.7*w,0.15*h, 100},
            rotate={-10,30,0},
            scale=2,

            pos_by={
                {2.5,0.1*w,0.35*h,150},
                {4.5,-0.1*w,0.7*h,-200}
            },
            rotate_by={
                {8,40,-20,0}
            },
        },
        -- 浅色气球 上->下
        {
            spr="heart_light.c3b",
            pos={0.6*w,0.5*h, 100},
            rotate={0,-10,0},
            scale=1,

            pos_by={
                {4.5,0.15*w,0.65*h,-100},
               
            },
            rotate_by={{4.5,-15,10,0}},
        },
        {
            spr="heart_light.c3b",
            pos={0.8*w,0.2*h, 250},
            rotate={5,10,0},
            scale=1.2,

            pos_by={
                {3,-0.1*w,0.55*h,-80},
                {4,0.15*w,0.55*h,100},
               
            },
            rotate_by={{4,-15,10,0}},
        },
        {
            spr="heart_light.c3b",
            pos={0.2*w,-0.1*h,0},
            rotate={5,15,0},
            scale=2,

            pos_by={
                {3.5,0.1*w,0.65*h,-80},
                {4.5,-0.15*w,0.75*h,100},
               
            },
            rotate_by={
                {2.5,15,20,0},
                {4.5,0,-40,0}
            },
        },
        {
            spr="heart_light.c3b",
            pos={0.75*w,-0.21*h,400},
            rotate={5,-15,-2},
            scale=2,

            pos_by={
                {2.5,-0.1*w,0.5*h,-80},
                {4.5,0.15*w,0.65*h,100},
               
            },
            rotate_by={
                {2.5,-15,40,1},
                {4.5,0,30,1}
            },
        },
       
    }




    -- 远处气球 左 中 右
    local balloonsNode ={}
    local balloonsAction ={}

    for i = 1, #balloons do
        balloonsNode[i] = cc.Sprite3D:create(self:getResourcePath(balloons[i]['spr']))
        :setTexture ("blue颜色.png")
        :setScale(balloons[i]['scale'])
        :setPosition3D(cc.vec3(balloons[i]['pos'][1],balloons[i]['pos'][2],balloons[i]['pos'][3]))
        :setRotation3D(cc.vec3(balloons[i]['rotate'][1],balloons[i]['rotate'][2],balloons[i]['rotate'][3]))
        :setCullFaceEnabled(false) 
        -- :setForceDepthWrite(true)
        :addTo(self)

        local moveActions={}
        local rotateActions={}
        for j=1,#balloons[i]['pos_by'] do
            if j%2==1 then
                moveActions[j] =  cc.MoveBy:create(balloons[i]['pos_by'][j][1],cc.vec3(balloons[i]['pos_by'][j][2],balloons[i]['pos_by'][j][3],balloons[i]['pos_by'][j][4]))
            else
                moveActions[j] =  cc.EaseSineOut:create(cc.MoveBy:create(balloons[i]['pos_by'][j][1],cc.vec3(balloons[i]['pos_by'][j][2],balloons[i]['pos_by'][j][3],balloons[i]['pos_by'][j][4])))
            end
            
        end

        for j=1,#balloons[i]['rotate_by'] do
            rotateActions[j] =  cc.EaseSineOut:create(cc.RotateBy:create(balloons[i]['rotate_by'][j][1], cc.vec3(balloons[i]['rotate_by'][j][2],balloons[i]['rotate_by'][j][3],balloons[i]['rotate_by'][j][4])))
        end

        balloonsAction[i] = cc.Sequence:create({
            cc.Spawn:create({
                cc.Sequence:create(moveActions),
                cc.Sequence:create(rotateActions),
            })
        })

        data1 = {node=balloonsNode[i],action=balloonsAction[i]}
        table.insert(self.data,data1)
    end

    local heartsNode ={}
    local heartsAction ={}

    for i = 1, #hearts do
        heartsNode[i] = cc.Sprite3D:create(self:getResourcePath(hearts[i]['spr']))
        :setVisible(true)
        :setScale(hearts[i]['scale'])
        :setPosition3D(cc.vec3(hearts[i]['pos'][1],hearts[i]['pos'][2],hearts[i]['pos'][3]))
        :setRotation3D(cc.vec3(hearts[i]['rotate'][1],hearts[i]['rotate'][2],hearts[i]['rotate'][3]))
        :addTo(self)

        local moveActions={}
        local rotateActions={}
        for j=1,#hearts[i]['pos_by'] do
            moveActions[j] =  cc.MoveBy:create(hearts[i]['pos_by'][j][1],cc.vec3(hearts[i]['pos_by'][j][2],hearts[i]['pos_by'][j][3],hearts[i]['pos_by'][j][4]))
        end

        for j=1,#hearts[i]['rotate_by'] do
            rotateActions[j] =  cc.RotateBy:create(hearts[i]['rotate_by'][j][1], cc.vec3(hearts[i]['rotate_by'][j][2],hearts[i]['rotate_by'][j][3],hearts[i]['rotate_by'][j][4]))
        end

        heartsAction[i] = cc.Sequence:create({
            cc.Spawn:create({
                cc.Sequence:create(moveActions),
                cc.Sequence:create(rotateActions),
            })
            
        })

        data1 = {node=heartsNode[i],action=heartsAction[i]}
        table.insert(self.data,data1)
    end


    -- 平行光

    local directionLight = cc.DirectionLight:create(cc.vec3(0,0,-100), cc.c3b(255, 255, 255))
        :setEnabled(true)
        :addTo(self)

    -- 环境光
    local ambientLight = cc.AmbientLight:create(cc.c3b(50, 50, 50))
        :setEnabled(true)
        :addTo(self)


end
function HotAirBalloonNode:onExit()


end

function HotAirBalloonNode:create(layer, msg)
    local node = HotAirBalloonNode.new(layer, msg)
    node:init()
    return node
end

return HotAirBalloonNode
