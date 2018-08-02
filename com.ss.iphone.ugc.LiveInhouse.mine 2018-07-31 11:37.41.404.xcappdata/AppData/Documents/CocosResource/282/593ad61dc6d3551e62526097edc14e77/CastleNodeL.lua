local CastleNode=class("CastleNode", require("app.gift.special.SpecialGiftNode"))

function CastleNode:init()
    display.loadSpriteFrames(self:getResourcePath("castle_fireworks.plist"), self:getResourcePath("castle_fireworks.png"))
    self.require3D = true
    self:setName("CastleNode")
    self:setVisible(true)
    self.winsize=display

    local w = display.width
    local h = display.height

    local ownerAction = cc.Sequence:create({
            cc.DelayTime:create(3),
            cc.CallFunc:create(function(el,data)
                self:beforeAnimationStart();
                el:align(display.CENTER, 0.65*w, h * 0.6 + 80)
                el:setOpacity(255)
                el:setVisible(true)
                el:setScale(1.1)
            end),
            cc.FadeIn:create(1),
            cc.DelayTime:create(2), 
            cc.ScaleTo:create(1.5,0.8),
            cc.FadeOut:create(0.5),
            cc.CallFunc:create(function(el,data)
                self:afterAnimationEnd()
                el:setOpacity(255)
                el:setVisible(false); 
            end)
        });
    
    local chengbao = cc.Sprite3D:create(self:getResourcePath("castle.c3b"))
        :setVisible(true)
        :setScale(0.0005)
        :setPosition3D(cc.vec3(0.65*w,0.52*h, 600.0 *0.02* w / 720))
        :setRotation3D(cc.vec3(-90,-47,0))
        :addTo(self)

    local chengbaoAction = cc.Sequence:create({
            cc.RotateBy:create(3, cc.vec3(0, 62, 0)),
            cc.RotateBy:create(2, cc.vec3(0, -15, 0)),
            cc.DelayTime:create(3.2),
            cc.FadeOut:create(0.3)
        })

    local wheel = cc.Sprite3D:create(self:getResourcePath("castle_wheel.c3b"))
    local wheelAnimation=cc.Animation3D:create(self:getResourcePath("castle_wheel.c3b"))
    local wheelAnimate=cc.Repeat:create(cc.Animate3D:create(wheelAnimation),2)
    
    wheel:setScale(150)
    :setPosition3D(cc.vec3(-348000,-525000,10000))   --x z,y
    :setRotation3D(cc.vec3(90,0,10))
    :addTo(chengbao)
    :runAction(wheelAnimate)


    local horseAnimation=cc.Animation3D:create(self:getResourcePath("castle_unicornmotion.c3b"))
    local horseAnimate=cc.Animate3D:create(horseAnimation)

    local horse = cc.Sprite3D:create(self:getResourcePath("castle_unicornmotion.c3b"))
    :setRotation3D(cc.vec3(0,-10,0))
    :setScale(0.15)
    :addTo(self)

    local horseAction = cc.Sequence:create({
        cc.CallFunc:create(function(el)
            el:setPosition3D(cc.vec3(0.51*w,0.47*h, 270.0 * w / 720))
        end),
        cc.Spawn:create({
            cc.Repeat:create(horseAnimate,3),
            cc.Sequence:create({
                cc.Spawn:create({
                    cc.RotateBy:create(1.8,cc.vec3(0,280,0)),
                    cc.MoveBy:create(0.6,cc.vec3(0.03*h,0,150)),
                    cc.Sequence:create({
                        cc.DelayTime:create(0.6),
                        cc.MoveBy:create(0.3,cc.vec3(0.57*h,0.1*h,-300)),
                        cc.MoveBy:create(0.9,cc.vec3(-0.5*h,0.1*h,-300)),
                    })
                }),
                cc.Spawn:create({
                    cc.RotateBy:create(1.5,cc.vec3(0,120,0)),
                    cc.MoveBy:create(1.5,cc.vec3(-0.025*h,0.018*h,130)),
                }),
                cc.Spawn:create({
                    cc.RotateBy:create(1.5,cc.vec3(0,-30,0)),
                    cc.MoveBy:create(1.5,cc.vec3(0.18*h,-0.15*h,170)),
                }),
                cc.MoveBy:create(1.5,cc.vec3(0,0.25*h,380)),
            })
        })
    })

    
    local fireworks = display.newSprite();
    fireworks:setAnchorPoint(0.5,0.5)
    :setPosition(0.65*w,0.75*h)
    :setScale(1.1)
    :addTo(self)

    local fireworksFrame={}
    for i=67,99 do
       fireworksFrame[i-66] = display.newSpriteFrame("#fire_0"..i..".png")
    end
    for i=100,111 do
        fireworksFrame[i-66] = display.newSpriteFrame("#fire_"..i..".png")
    end

    local fireworksAnimation = cc.Animation:createWithSpriteFrames(fireworksFrame,3/45)
    local fireworksAnimate = cc.Animate:create(fireworksAnimation)
    local fireworksAction=cc.Sequence:create({
        cc.DelayTime:create(4.5),
        fireworksAnimate,
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end),

    })

    local rotateCamera = cc.Camera:create()
    rotateCamera:setCameraFlag(cc.CameraFlag.USER1)
    rotateCamera:addTo(self)
    chengbao:setCameraMask(cc.CameraFlag.USER1)
    horse:setCameraMask(cc.CameraFlag.USER1)

    local cameraAction = cc.Sequence:create({
            cc.MoveBy:create(3,cc.vec3(0,60,-50)),
            cc.MoveBy:create(1,cc.vec3(0.15*w,0,-50)),
            cc.MoveBy:create(3,cc.vec3(0,0,-120)),
        })
    
    local ambientLight = cc.AmbientLight:create(display.COLOR_WHITE)
        :setEnabled(true)
        :addTo(self)

    local data1 = {node=self.layer.ownerNode,action=ownerAction}
    table.insert(self.data,data1)

    data1 = {node=chengbao,action=chengbaoAction}
    table.insert(self.data,data1)

    data1 = {node=horse,action=horseAction}
    table.insert(self.data,data1)

    data1 = {node=fireworks,action=fireworksAction}
    table.insert(self.data,data1)

    data1 = {node=rotateCamera ,action=cameraAction}
    table.insert(self.data,data1)
end
function CastleNode:onExit()

end

function CastleNode:create(layer, msg)
    local node = CastleNode.new(layer, msg)
    node:init()
    return node
end

return CastleNode
