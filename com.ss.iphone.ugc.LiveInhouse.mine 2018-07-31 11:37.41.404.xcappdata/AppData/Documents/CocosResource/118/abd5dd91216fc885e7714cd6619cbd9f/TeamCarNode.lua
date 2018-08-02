local TeamCarNode=class("TeamCarNode", require("app.gift.special.SpecialGiftNode"))

local petal = {plist={'star_flow.plist','star_flow2.plist','star_flow3.plist','star_flow4.plist'},
position={cc.p(display.width*0.3,display.height+5),cc.p(-5,0.6*display.height),
cc.p(display.width*0.8,0.6*display.height),cc.p(-5,0.8*display.height)},index={1,-1,-2,1}
}
function TeamCarNode:create(layer, msg)
    local node=TeamCarNode.new(layer, msg)
    node:init(msg)
    return node
end
function TeamCarNode:init(msg)
    display.loadSpriteFrames(self:getResourcePath("blue_car.plist"), self:getResourcePath("blue_car.png"))
    display.loadSpriteFrames(self:getResourcePath("yellow_car.plist"), self:getResourcePath("yellow_car.png"))
    display.loadSpriteFrames(self:getResourcePath("red_car.plist"), self:getResourcePath("red_car.png"))
    
    self:setName("TeamCarNode")
    self:setVisible(true)

--红车节点定义+动作
    local redCarData = self:createRedCar();

    self.data = {}
    for key,var in ipairs(redCarData) do
        table.insert(self.data,var)
    end

--黄车节点定义+动作
    local balloonCarData = self:createBalloonCar()
    for key,var in ipairs(balloonCarData) do
        table.insert(self.data,var)
    end

--蓝车节点定义+动作
    local blueCarData = self:createBlueCar(msg)
    for key,var in ipairs(blueCarData) do
        table.insert(self.data,var)
    end

end

function TeamCarNode:createRedCar()
    --车身
    local car = display.newSprite("#red_car_shell.png");
    car:setVisible(false);
    car:setScale(1);
    car:setPosition(cc.p(display.size.width+0.5*car:getContentSize().width,0.7*display.size.height));
    --投影
    local shadow= display.newSprite("#red_car_shadow.png");
    shadow:setPosition(cc.p(0.5*car:getContentSize().width,0.44*car:getContentSize().height));
    car:addChild(shadow);
    --车身动作
    local carAction1 = cc.Sequence:create({
        cc.CallFunc:create(function(el)
            el:setPosition(cc.p(display.size.width+0.5*el:getContentSize().width,0.65*display.size.height));
            el:setVisible(true);
            self:createSnowPetal()
        end),
        cc.EaseIn:create(cc.MoveTo:create(0.4,cc.p(display.size.width-0.55*car:getContentSize().width,0.45*display.size.height)),1),
        cc.EaseIn:create(cc.MoveTo:create(1.4,cc.p(display.size.width*0.5,0.4*display.size.height)),1),
        cc.EaseOut:create(cc.MoveTo:create(0.4,cc.p(-0.5*car:getContentSize().width,0.2*display.size.height)),1),
        cc.CallFunc:create(function(el)
            el:setVisible(false);
        end)
    });

    local carAction = cc.Sequence:create({
        self:beforeAnimationStart();
        carAction1,
        cc.DelayTime:create(1.7),
        carAction1
    })
    
    --轮子
    local wheel = display.newSprite("#red_car_wheel_14.png");
    wheel:setPosition(cc.p(1.03*car:getContentSize().width,0.47*car:getContentSize().height));
    car:addChild(wheel);

    local enterFrames={};
    for i=1,5 do
        enterFrames[#enterFrames+1] = display.newSpriteFrame("red_car_wheel_"..i..".png");
    end
    local wheelEnterAnimation= cc.Animation:createWithSpriteFrames(enterFrames,0.1);
    local Am1=cc.Animate:create(wheelEnterAnimation);

    local slowFrames={};
    for i=6,65 do
        slowFrames[#slowFrames+1] = display.newSpriteFrame("red_car_wheel_"..i..".png");
    end
    local wheelSlowAnimation=cc.Animation:createWithSpriteFrames(slowFrames,1.4/59);
    local Am2=cc.Animate:create(wheelSlowAnimation);

    local exitFrames={};
    for i=65,70 do
        exitFrames[#exitFrames+1] = display.newSpriteFrame("red_car_wheel_"..i..".png");
    end
    local wheelExitAnimation = cc.Animation:createWithSpriteFrames(exitFrames,0.4/15);
    local Am3=cc.Animate:create(wheelExitAnimation);

    local wheelAction1 = cc.Sequence:create({
        Am1,Am2,AM3
        }); 

    local wheelAction = cc.Sequence:create({
        wheelAction1,
        cc.DelayTime:create(1.7),
        wheelAction1
    })   
    --车灯
    local light = display.newSprite("#red_car_light.png");
    light:setVisible(false);
    light:setPosition(cc.p(0.35*car:getContentSize().width,0.35*car:getContentSize().height));
    light:setOpacity(255*0.4); 

    local lightAction1= cc.Sequence:create({
        cc.DelayTime:create(0.8),
        cc.CallFunc:create(function(el)
                el:setOpacity(255*0.4);
                el:setVisible(true);
        end),
        cc.FadeTo:create(0.7,255),
        cc.FadeTo:create(0.3,255*0.4),
        cc.CallFunc:create(function(el)
            el:setVisible(false);
        end)
    });

    local lightAction = cc.Sequence:create({
        lightAction1,
        cc.DelayTime:create(1.7),
        lightAction1
    }) 

    car:addChild(light);

    local redCarData = {}

    local data1 = {node=car,action=carAction};
    table.insert(redCarData,data1);

    data1={node=wheel,action=wheelAction};
    table.insert(redCarData,data1);

    data1={node=light,action=lightAction};
    table.insert(redCarData,data1);

    self:addChild(car,1);

    return redCarData;
end

function TeamCarNode:createBalloonCar()
    --车身
    local car = display.newSprite("#balloon_car_shell2.png");
    car:setVisible(false);

    local carAction1 = cc.Sequence:create({
        cc.CallFunc:create(function(el)
            el:setPosition(cc.p(-0.5*el:getContentSize().width,0.6*display.size.height));
            el:setVisible(true);
        end),
        cc.EaseIn:create(cc.MoveTo:create(0.5,cc.p(0.5*display.size.width,0.4*display.size.height)),1),
        cc.EaseIn:create(cc.MoveTo:create(0.12,cc.p(0.495*display.size.width,0.395*display.size.height)),1),
        cc.EaseIn:create(cc.MoveTo:create(0.08,cc.p(0.5*display.size.width,0.4*display.size.height)),1),
        cc.DelayTime:create(0.8),
        cc.EaseIn:create(cc.MoveTo:create(0.06,cc.p(0.51*display.size.width,0.39*display.size.height)),1),
        cc.DelayTime:create(0.04);
        cc.EaseOut:create(cc.MoveTo:create(0.5,cc.p(display.size.width+0.5*car:getContentSize().width,0.2*display.size.height)),1),
        cc.CallFunc:create(function(el)
            el:setVisible(false);
        end)
        });
    
    local carAction = cc.Sequence:create({
        cc.DelayTime:create(2),
        carAction1,
        cc.DelayTime:create(1.7),
        carAction1
    })

    --车轮
    local rearTyre = display.newSprite()
    rearTyre:setPosition(cc.p(0,0.3*car:getContentSize().height-1))
    :setAnchorPoint(cc.p(0,0))
    :setScale(0.8)
    :addTo(car,2)

    local frontTyre = display.newSprite()
    frontTyre:setPosition(cc.p(0.32*car:getContentSize().width,1))
    :setAnchorPoint(cc.p(0,0))
    :addTo(car,2)

    local wheelframes = {}
    for i=1,9 do
        wheelframes[#wheelframes+1] = display.newSpriteFrame("wheel_roll_"..i..".png")
    end
    local tp1 = cc.Animation:createWithSpriteFrames(wheelframes,0.5/8)
    local rearAnimation = cc.Animate:create(tp1)
    local frontAnimation = cc.Animate:create(tp1)

    local rearTyreAction1 = cc.Sequence:create({
        rearAnimation,
        cc.DelayTime:create(1),
        rearAnimation
    })

    local rearTyreAction = cc.Sequence:create({
        cc.DelayTime:create(2),
        rearTyreAction1,
        cc.DelayTime:create(1.7),
        rearTyreAction1
    })

    local frontTyreAction1 = cc.Sequence:create({
        frontAnimation,
        cc.DelayTime:create(1),
        frontAnimation
    })

    local frontTyreAction = cc.Sequence:create({
        cc.DelayTime:create(2),
        frontTyreAction1,
        cc.DelayTime:create(1.7),
        frontTyreAction1
    })
    
    --后轮烟雾
    local rearfoam = display.newSprite()
    rearfoam:setPosition(cc.p(40,0.15*car:getContentSize().height))
    :setAnchorPoint(cc.p(1,0))
    :addTo(car,2)

    local rearfoamframes = {}
    for i=3,16 do
        rearfoamframes[#rearfoamframes+1] = display.newSpriteFrame("back_wheel_foam_"..i..".png")
    end

    local foam1 = cc.Animation:createWithSpriteFrames(rearfoamframes,0.4/13)
    local rearfoamAnimation = cc.Animate:create(foam1)
    local rearFoamAction1 = cc.Sequence:create({
        cc.DelayTime:create(0.4),
        rearfoamAnimation,
        cc.DelayTime:create(0.9),
        rearfoamAnimation
    })

    local rearFoamAction = cc.Sequence:create({
        cc.DelayTime:create(2),
        rearFoamAction1,
        cc.DelayTime:create(1.7),
        rearFoamAction1
    })
    --前轮烟雾
    local frontfoam = display.newSprite()
    frontfoam:setPosition(cc.p(0.43*car:getContentSize().width,-18))
    :setAnchorPoint(cc.p(1,0))
    :addTo(car,2)

    local frontfoamframes = {}
    for i=1,21 do
        frontfoamframes[#frontfoamframes+1] = display.newSpriteFrame("front_wheel_foam_"..i..".png")
    end

    local foam2 = cc.Animation:createWithSpriteFrames(frontfoamframes,0.6/20)
    local frontfoamAnimation = cc.Animate:create(foam2)
    local frontFoamAction1 = cc.Sequence:create({
        cc.DelayTime:create(1.7),
        frontfoamAnimation,
        cc.DelayTime:create(0.2),
    })

    local frontFoamAction = cc.Sequence:create({
        cc.DelayTime:create(2),
        frontFoamAction1,
        cc.DelayTime:create(1.7),
        frontFoamAction1
    })

    --车灯
    local rightLight1 = display.newSprite("#balloon_car_light.png");
    rightLight1:setPosition(cc.p(0.55*car:getContentSize().width,0.5*car:getContentSize().height));
    rightLight1:setRotation(0);
    rightLight1:setOpacity(255*0.9);
    rightLight1:setAnchorPoint(cc.p(0,1));
    rightLight1:setVisible(false);

    local rightLight2 = display.newSprite("#balloon_car_light.png");
    rightLight2:setPosition(cc.p(0.5*car:getContentSize().width,0.46*car:getContentSize().height));
    rightLight2:setRotation(-20);
    rightLight2:setOpacity(255*0.5);
    rightLight2:setAnchorPoint(cc.p(0,1));
    rightLight2:setVisible(false);

    local leftLight1 = display.newSprite("#balloon_car_light.png");
    leftLight1:setPosition(cc.p(0.92*car:getContentSize().width,0.55*car:getContentSize().height));
    leftLight1:setRotation(0);
    leftLight1:setOpacity(255*0.8);
    leftLight1:setAnchorPoint(cc.p(0,1));
    leftLight1:setVisible(false);

    local leftLight2 = display.newSprite("#balloon_car_light.png");
    leftLight2:setPosition(cc.p(0.92*car:getContentSize().width,0.55*car:getContentSize().height));
    leftLight2:setRotation(-25);
    leftLight2:setOpacity(255*0.5);
    leftLight2:setAnchorPoint(cc.p(0,1));
    leftLight2:setVisible(false);

    local rightLight1Action1 = cc.Sequence:create({
        cc.CallFunc:create(function(el)
            el:setRotation(0);
            el:setOpacity(0);
            el:setVisible(true);
        end),
        cc.DelayTime:create(0.7),
        cc.FadeTo:create(0.3,255*0.8),
        cc.Spawn:create({
            cc.RotateTo:create(0.5,-20),
            cc.FadeTo:create(0.5,255*0.2)
            }),
        cc.DelayTime:create(0.6),
        cc.CallFunc:create(function(el)
            el:setVisible(false);
        end)
        });

    local rightLight1Action = cc.Sequence:create({
        cc.DelayTime:create(2),
        rightLight1Action1,
        cc.DelayTime:create(1.7),
        rightLight1Action1
        });

    local rightLight2Action1 = cc.Sequence:create({
        cc.CallFunc:create(function(el)
            el:setRotation(-20);
            el:setOpacity(0);
            el:setVisible(true);
        end),
        cc.DelayTime:create(0.7),
        cc.FadeTo:create(0.3,255*0.6),
        cc.Spawn:create({
            cc.RotateTo:create(0.5,0),
            cc.FadeTo:create(0.5,255*0.2)
            }),
        cc.DelayTime:create(0.6),
        cc.CallFunc:create(function(el)
            el:setVisible(false);
        end)
        });

    local rightLight2Action = cc.Sequence:create({
        cc.DelayTime:create(2),
        rightLight2Action1,
        cc.DelayTime:create(1.7),
        rightLight2Action1
        });

    local leftLight1Action1 = cc.Sequence:create({
        cc.CallFunc:create(function(el)
            el:setRotation(0);
            el:setOpacity(0);
            el:setVisible(true);
        end),
        cc.DelayTime:create(0.7),
        cc.FadeTo:create(0.3,255*0.8),
        cc.Spawn:create({
            cc.RotateTo:create(0.5,-25),
            cc.FadeTo:create(0.5,255*0.2)
            }),
        cc.DelayTime:create(0.6),
        cc.CallFunc:create(function(el)
            el:setVisible(false);
        end)
        });

    local leftLight1Action = cc.Sequence:create({
        cc.DelayTime:create(2),
        leftLight1Action1,
        cc.DelayTime:create(1.7),
        leftLight1Action1
        });

    local leftLight2Action1 = cc.Sequence:create({
        cc.CallFunc:create(function(el)
            el:setRotation(-25);
            el:setOpacity(0);
            el:setVisible(true);
        end),
        cc.DelayTime:create(0.7),
        cc.FadeTo:create(0.3,255*0.6),
        cc.Spawn:create({
            cc.RotateTo:create(0.5,0),
            cc.FadeTo:create(0.5,255*0.2)
            }),
        cc.DelayTime:create(0.6),
        cc.CallFunc:create(function(el)
            el:setVisible(false);
        end)
        });

    local leftLight2Action = cc.Sequence:create({
        cc.DelayTime:create(2),
        leftLight2Action1,
        cc.DelayTime:create(1.7),
        leftLight2Action1
        });

    car:addChild(rightLight1);
    car:addChild(rightLight2);
    car:addChild(leftLight1);
    car:addChild(leftLight2);

    local balloonCarData = {}

    local data1={node=car,action=carAction};
    table.insert(balloonCarData,data1);

    data1= {node=rightLight1 ,action=rightLight1Action };
    table.insert(balloonCarData,data1);

    data1= {node=rightLight2,action=rightLight2Action };
    table.insert(balloonCarData,data1);

    data1= {node=leftLight1 ,action=leftLight1Action };
    table.insert(balloonCarData,data1);

    data1= {node=leftLight2 ,action=leftLight2Action }; --16
    table.insert(balloonCarData,data1);

    data1= {node=rearTyre ,action=rearTyreAction};
    table.insert(balloonCarData,data1);

    data1= {node=frontTyre ,action=frontTyreAction};
    table.insert(balloonCarData,data1);

    data1= {node=rearfoam ,action=rearFoamAction};
    table.insert(balloonCarData,data1);

    data1= {node=frontfoam ,action=frontFoamAction};
    table.insert(balloonCarData,data1);

    self:addChild(car,1);

    return balloonCarData;
end

function TeamCarNode:createBlueCar(msg)
    --车身
    local car = display.newSprite("#blue_car.png");
    car:setScale(0.04)
    :setPosition(cc.p(0.5*display.size.width,0.35*display.size.height))
    :setCascadeOpacityEnabled(true)
    :setVisible(false)
    --车身动作
    local carAction = cc.Sequence:create({
        cc.DelayTime:create(7.4),
        cc.CallFunc:create(function(el)
            el:setVisible(true)
            self:createStarPetal(1)
            self:createStarPetal(2)
            self:createStarPetal(3)
            self:createStarPetal(4)
        end),
        cc.EaseIn:create(cc.ScaleTo:create(1.8,1),1.6),
        cc.CallFunc:create(function(el)
            self:createStarPetal(3)
        end),
        cc.EaseIn:create(cc.MoveTo:create(0.1,cc.p(0.5*display.size.width,0.365*display.size.height)),0.1),
        cc.CallFunc:create(function(el)
            self:createStarPetal(2)
        end),
        cc.EaseIn:create(cc.MoveTo:create(0.1,cc.p(0.5*display.size.width,0.35*display.size.height)),0.1),
        cc.CallFunc:create(function(el)
            self:createStarPetal(1)
            self:createStarPetal(4)
        end),
        cc.DelayTime:create(2.3),
        cc.FadeOut:create(0.8),
        cc.CallFunc:create(function(el)
            self:afterAnimationEnd();
            el:setVisible(false);
        end)
    });
    
    --车灯
    local leftLight1 = display.newSprite("#blue_light.png")
    leftLight1:setAnchorPoint(cc.p(0.5,1))
    :setVisible(false)
    :setPosition(cc.p(0.2*car:getContentSize().width,0.4*car:getContentSize().height-10))
    :setOpacity(255*0.4)
    :addTo(car,2)

    local leftLight2 = display.newSprite("#blue_light.png")
    :setAnchorPoint(cc.p(0.5,1))
    :setVisible(false)
    :setPosition(cc.p(0.2*car:getContentSize().width,0.4*car:getContentSize().height-10))
    :setOpacity(255*0.4)
    :addTo(car,2)
    
    local rightLight1 = display.newSprite("#blue_light.png")
    rightLight1:setAnchorPoint(cc.p(0.5,1))
    :setFlippedX(true)
    :setVisible(false)
    :setPosition(cc.p(0.8*car:getContentSize().width,0.4*car:getContentSize().height-10))
    :setOpacity(255*0.4)
    :addTo(car,2)

    local rightLight2 = display.newSprite("#blue_light.png")
    rightLight2:setAnchorPoint(cc.p(0.5,1))
    :setFlippedX(true)
    :setVisible(false)
    :setPosition(cc.p(0.8*car:getContentSize().width,0.4*car:getContentSize().height-10))
    :setOpacity(255*0.4)
    :addTo(car,2)

    local leftLight1Action = cc.Sequence:create({
        cc.DelayTime:create(8.6),
        cc.CallFunc:create(function(el)
                el:setOpacity(255*0.4)
                el:setVisible(true)
                el:setScale(1,1.2)
        end),
        cc.FadeTo:create(0.4,255),
        cc.Spawn:create({
            cc.FadeTo:create(1.7,255*0.5),
            cc.RotateTo:create(1.7,-16),
        }),
        cc.DelayTime:create(1)
    })

    local leftLight2Action = cc.Sequence:create({
        cc.DelayTime:create(8.6),
        cc.CallFunc:create(function(el)
                el:setOpacity(255*0.4)
                el:setVisible(true)
                el:setScale(1,1.2)
        end),
        cc.FadeTo:create(0.4,255),
        cc.Spawn:create({
            cc.FadeTo:create(1.7,255*0.5),
            cc.RotateTo:create(1.7,16),
        }),
        cc.DelayTime:create(1)
    })

    local rightLight1Action = cc.Sequence:create({
        cc.DelayTime:create(8.6),
        cc.CallFunc:create(function(el)
                el:setOpacity(255*0.4)
                el:setVisible(true)
                el:setScale(1,1.2)
        end),
        cc.FadeTo:create(0.4,255),
        cc.Spawn:create({
            cc.FadeTo:create(1.7,255*0.5),
            cc.RotateTo:create(1.7,-16),
        }),
        cc.DelayTime:create(1)
    })

    local rightLight2Action = cc.Sequence:create({
        cc.DelayTime:create(8.6),
        cc.CallFunc:create(function(el)
                el:setOpacity(255*0.4)
                el:setVisible(true)
                el:setScale(1,1.2)
        end),
        cc.FadeTo:create(0.4,255),
        cc.Spawn:create({
            cc.FadeTo:create(1.7,255*0.5),
            cc.RotateTo:create(1.7,16),
        }),
        cc.DelayTime:create(1)
    })

    --带你去兜风
    local strGift = textPack[send_mysterious_gift]
    local giftDescNode = cc.LabelTTF:create(strGift, '',28)
    giftDescNode:enableStroke(cc.c4b(78, 102, 243, 255), 6)
    giftDescNode:setString(" "..msg.giftDesc.." ")

    giftDescNode:setAnchorPoint(0.5, 0.5)
    :setPosition(0.5*display.width,0.85*display.height)
    :setVisible(false)
    :addTo(self,3)

    local giftDescAction = cc.Sequence:create({
        cc.DelayTime:create(9.8),
        cc.CallFunc:create(function(el, data)
            el:setScale(0.05)
            el:setVisible(true)
        end),
        cc.Spawn:create({
            cc.ScaleTo:create(0.9,1),
            cc.FadeIn:create(0.9)
        }),        
        cc.DelayTime:create(1),
        cc.FadeOut:create(0.8),
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end)
    })
    

    --金主头像
    local richNode = live.roundAvatarSprite(100,msg.userAvatarLocal,cc.c4b(255,255,255,1)):addTo(self,1)
    :setPosition(0.3*display.width-30,0.7*display.height)
    :setAnchorPoint(0.5,0.5)
    :setVisible(false)
    richNode:setOnClickCallback(function()
        local event = live.LiveEvent:new(live.Constant.LIVE_EVENT_USER_CLICK,
            tostring(msg.userId), "")
        live.eventDispatcher:dispatch(event)
    end)

    local richNameNode = self:setUserName(msg.userName)
    richNameNode:setAnchorPoint(0.5,0.5)
    richNameNode:setPosition(0.5*richNode:getContentSize().width,-20)
    :setVisible(true)
    :addTo(richNode,3)

    local richAction = cc.Sequence:create({
        cc.DelayTime:create(9.1),
        cc.CallFunc:create(function(el, data)
            el:setPosition(0.5*display.width,0.35*display.height)
            el:setScale(0.05)
            el:setVisible(true)
        end),
        cc.Spawn:create({
            cc.ScaleTo:create(0.7,2),
            cc.MoveTo:create(0.7,cc.p(0.7*display.width,0.7*display.height))
        }),
        cc.DelayTime:create(1.9),
        cc.FadeOut:create(0.8),
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end)
    })

    --主播头像
    local toUserAvatarLocal = msg.toUserAvatarLocal
    if not toUserAvatarLocal or #toUserAvatarLocal == 0 then
        msg.toUserAvatarLocal = 'avatar_local.png'
    end

    local toUserName = msg.toUserName;
    if not toUserName or #toUserName == 0 then
        msg.toUserName = '主播'
    end

    local anchorNode = live.roundAvatarSprite(100, toUserAvatarLocal, cc.c4b(255,255,255,1)):addTo(self,1) 
    :setAnchorPoint(0.5,0.5)
    :setVisible(false)
    anchorNode:setOnClickCallback(function()
        local event = live.LiveEvent:new(live.Constant.LIVE_EVENT_USER_CLICK,
            tostring(msg.toUserId), "")
        live.eventDispatcher:dispatch(event)
    end)
    
    local anchorNameNode = self:setUserName(toUserName)
    anchorNameNode:setPosition(0.5*anchorNode:getContentSize().width,-20)
    :setAnchorPoint(0.5,0.5)
    :setVisible(true)
    :addTo(anchorNode,3)

    local anchorAction = cc.Sequence:create({
        cc.DelayTime:create(9.1),
        cc.CallFunc:create(function(el, data)
            el:setPosition(0.5*display.width,0.35*display.height)
            el:setScale(0.05)
            el:setVisible(true)
        end),
        cc.Spawn:create({
            cc.ScaleTo:create(0.7,2),
            cc.MoveTo:create(0.7,cc.p(0.3*display.width,0.7*display.height))
        }),
        cc.DelayTime:create(1.9),
        cc.FadeOut:create(0.8),
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end)
    })

    --爱心&from&to
    local loveHeart = display.newSprite("#heart.png")
    :setAnchorPoint(0.5,0.5)
    :setPosition(0.5*display.width,0.7*display.height)
    :setScale(0.05)
    :setVisible(false)
    :addTo(self,1)

    local loveHeartAction = cc.Sequence:create({
        cc.DelayTime:create(10.1),
        cc.CallFunc:create(function(el, data)
            el:setVisible(true)
        end),
        cc.ScaleTo:create(0.3,1),
        cc.ScaleTo:create(0.2,0.8),
        cc.DelayTime:create(1.1),
        cc.FadeOut:create(0.8),
        cc.CallFunc:create(function(el, data)
            el:setVisible(false)
        end)
    })

    local from = display.newSprite("#from.png")
    :setPosition(0,80)
    :setScale(0.3)
    :addTo(richNode,2)

    local to =display.newSprite("#to.png")
    :setPosition(10,80)
    :setScale(0.3)
    :addTo(anchorNode,2)

    --扫光
    local rightShine = display.newSprite("#right_shine.png")
    rightShine:setAnchorPoint(0,0)
    :setPosition(cc.p(0.7*car:getContentSize().width,0.25*car:getContentSize().height))
    :setScale(0.6)
    :setRotation(-15)
    :setVisible(true)
    :addTo(car,2)

    local leftShine = display.newSprite("#left_shine.png")
    leftShine:setAnchorPoint(1,0)
    :setPosition(cc.p(0.3*car:getContentSize().width,0.25*car:getContentSize().height))
    :setScale(0.6)
    :setRotation(15)
    :setVisible(true)
    :addTo(car,2)

    local rightShineAction = cc.Sequence:create({
        cc.DelayTime:create(9.3),
        cc.Spawn:create({
            cc.RotateTo:create(0.4,-25),
            cc.FadeTo:create(0.4,255*0.5)
        })
    })

    local leftShineAction = cc.Sequence:create({
        cc.DelayTime:create(9.3),
        cc.Spawn:create({
            cc.RotateTo:create(0.4,25),
            cc.FadeTo:create(0.4,255*0.5)
        })
    })


    local light1 = display.newSprite("#light.png")
    light1:setAnchorPoint(0.5,0.5)
    :setPosition(cc.p(0.2*car:getContentSize().width,0.8*car:getContentSize().height))
    :setRotation(-35)
    :setScale(0.4)
    :setOpacity(255*0.4)
    :setVisible(true)
    :addTo(car,3)

    local light2 = display.newSprite("#light.png")
    light2:setAnchorPoint(0.5,0.5)
    :setPosition(cc.p(0.2*car:getContentSize().width,0.8*car:getContentSize().height))
    :setRotation(-35)
    :setScale(0.4)
    :setOpacity(255*0.4)
    :setVisible(true)
    :addTo(car,3)

    local lightAction1 = cc.Sequence:create({
        cc.DelayTime:create(9.5),
        cc.Spawn:create({
            cc.FadeTo:create(1,255),
            cc.ScaleTo:create(1,0.8,0.4),
            cc.MoveTo:create(1.2,cc.p(0.7*car:getContentSize().width,0.8*car:getContentSize().height+10))
        }),
        cc.Spawn:create({
            cc.FadeTo:create(1,255*0.2),
            cc.ScaleTo:create(0.5,0.1,0.4),
            cc.MoveTo:create(0.5,cc.p(0.8*car:getContentSize().width,0.7*car:getContentSize().height))
        }),
        cc.CallFunc:create(function(el)
            el:setVisible(false);
        end)
    })

    local lightAction2 = cc.Sequence:create({
        cc.DelayTime:create(10.1),
        cc.Spawn:create({
            cc.FadeTo:create(1,255),
            cc.ScaleTo:create(1,0.8,0.4),
            cc.MoveTo:create(1.2,cc.p(0.7*car:getContentSize().width,0.8*car:getContentSize().height+10))
        }),
        cc.Spawn:create({
            cc.FadeTo:create(1,255*0.2),
            cc.ScaleTo:create(0.5,0.1,0.4),
            cc.MoveTo:create(0.5,cc.p(0.8*car:getContentSize().width,0.7*car:getContentSize().height))
        }),
        cc.CallFunc:create(function(el)
            el:setVisible(false);
        end)
    })

    local blueCarData = {}

    local data1 = {node=car,action=carAction};
    table.insert(blueCarData,data1);

    data1={node=leftLight1,action=leftLight1Action};
    table.insert(blueCarData,data1);

    data1={node=leftLight2,action=leftLight2Action};
    table.insert(blueCarData,data1);

    data1={node=rightLight1,action=rightLight1Action};
    table.insert(blueCarData,data1);

    data1={node=rightLight2,action=rightLight2Action};
    table.insert(blueCarData,data1);

    data1={node=richNode,action=richAction};
    table.insert(blueCarData,data1);

    data1={node=anchorNode,action=anchorAction};
    table.insert(blueCarData,data1);

    data1={node=giftDescNode,action=giftDescAction};
    table.insert(blueCarData,data1);

    data1={node=loveHeart,action=loveHeartAction};
    table.insert(blueCarData,data1);

    data1={node=leftShine,action=leftShineAction};
    table.insert(blueCarData,data1);

    data1={node=rightShine,action=rightShineAction};
    table.insert(blueCarData,data1);

    data1={node=light1,action=lightAction1};
    table.insert(blueCarData,data1);

    data1={node=light2,action=lightAction2};
    table.insert(blueCarData,data1);

    self:addChild(car,2);

    return blueCarData;
end

function TeamCarNode:setUserName(name)
    local strVolcano = textPack[volcano_live]
    local ownerNameNode = cc.LabelTTF:create(strVolcano, '',28)
    ownerNameNode:setScale(0.5)
    ownerNameNode:enableStroke(cc.c4b(78, 102, 243, 255), 6)
    ownerNameNode:setAnchorPoint(0, 0)
    ownerNameNode:setString(" " .. name .. " ")
    return ownerNameNode
end


function TeamCarNode:createSnowPetal()
    local snow = cc.ParticleSystemQuad:create(self:getResourcePath("snow_bg.plist"))

    snow:setPosition(display.width*0.5,0.5*display.height)

    snow:setAutoRemoveOnFinish(true)

    self:addChild(snow,-1)
end

function TeamCarNode:createStarPetal(n)

    local star = cc.ParticleSystemQuad:create(self:getResourcePath(petal['plist'][n]))

    star:setPosition(petal['position'][n])

    star:setAutoRemoveOnFinish(true)

    self:addChild(star,petal['index'][n])

    star:setEmissionRate(star:getTotalParticles()/0.1)

end

function TeamCarNode:onExit()
    printInfo("TeamCarNode onExit!!!!")
    display.removeSpriteFrames(self:getResourcePath("blue_car.plist"), self:getResourcePath("blue_car.png"))
    display.removeSpriteFrames(self:getResourcePath("yellow_car.plist"), self:getResourcePath("yellow_car.png"))
    display.removeSpriteFrames(self:getResourcePath("red_car.plist"), self:getResourcePath("red_car.png"))
end
return TeamCarNode
