local BearNode=class("BearNode", require("app.gift.special.SpecialGiftNode"))

function BearNode:init()
    self:setName("BearNode")
    display.loadSpriteFrames(self:getResourcePath("bear.plist"), self:getResourcePath("bear.png"))

    local width, height = display.width, display.height
    local starsConfig = {
        [1] = {
            x = 0.02 * width,
            y = height,
            --[[ 格式：
                { [1] = moveY, [2] = moveTime, [3] = fadeTo }
            ]]
            [1] = { -0.7 * height, 0.7 },
            [2] = { 0.02 * height, 0.15 }, 
            [3] = { -0.02 * height, 1.2 },
            [4] = { 0.04 * height, 1 },
            [5] = { 0, 0.6 },
            [6] = { 0, 0.15, 200 },
            [7] = { -0.5 * height, 0.2 }
        },
        [2] = {
            x = 0.15 * width,
            y = height * 1.1,
            [1] = { -0.73 * height, 0.85 },
            [2] = { 0.02 * height, 0.15 }, 
            [3] = { -0.02 * height, 1 },
            [4] = { 0.04 * height, 1 },
            [5] = { 0, 0.3 },
            [6] = { 0, 0.3, 150 },
            [7] = { -0.5 * height, 0.2 }
        },
        [3] = {
            x = 0.31 * width,
            y = height * 1.05,
            [1] = { -0.63 * height, 0.8 },
            [2] = { 0.02 * height, 0.15 }, 
            [3] = { -0.02 * height, 0.9 },
            [4] = { 0.04 * height, 1 },
            [5] = { 0, 0.05 },
            [6] = { 0, 0.15, 200 },
            [7] = { -0.5 * height, 0.2 }
        },
        [4] = {
            x = 0.62 * width,
            y = height * 1.1,
            [1] = { -0.75 * height, 0.9 },
            [2] = { 0.02 * height, 0.15 }, 
            [3] = { -0.02 * height, 1.1 },
            [4] = { 0.04 * height, 1 },
            [5] = { 0, 0.2 },
            [6] = { 0, 0.15, 200 },
            [7] = { -0.5 * height, 0.2 }
        },
        [5] = {
            x = 0.75 * width,
            y = height,
            [1] = { -0.7 * height, 0.7 },
            [2] = { 0.02 * height, 0.15 }, 
            [3] = { -0.02 * height, 1.2 },
            [4] = { 0.04 * height, 1 },
            [5] = { 0, 0.6 },
            [6] = { 0, 0.15, 200 },
            [7] = { -0.5 * height, 0.2 }
        },
        [6] = {
            x = 0.87 * width,
            y = height * 1.05,
            [1] = { -0.63 * height, 0.8 },
            [2] = { 0.02 * height, 0.15 }, 
            [3] = { -0.02 * height, 0.9 },
            [4] = { 0.04 * height, 1 },
            [5] = { 0, 0.05 },
            [6] = { 0, 0.15, 200 },
            [7] = { -0.5 * height, 0.2 }
        },
    }

    -- root --------
    local root = display.newSprite()
    local rootAction = cc.Sequence:create({
        cc.CallFunc:create(function(el, data)
            self:beforeAnimationStart()
        end),
        cc.DelayTime:create(4.5),
        cc.CallFunc:create(function(el, data)
            self:afterAnimationEnd()
        end)
    })

    -- owner -------
    local ownerAction = cc.Sequence:create({
        cc.DelayTime:create(0.1),
        cc.CallFunc:create(function(el,data)
            el:align(display.CENTER, display.cx, display.height * 0.65 + 80)
            :setOpacity(0)
            :setVisible(true)
        end),
        cc.DelayTime:create(0.7),
        cc.FadeIn:create(0.3),
        cc.DelayTime:create(3),
        cc.FadeOut:create(0.3),
        cc.CallFunc:create(function(el,data)
            el:setVisible(false)
            :setOpacity(255)
        end)
    });

    -- bg ---------
    local bg = display.newSprite('#bg.png')
    :align(display.CENTER_BOTTOM, display.cx, -50)
    :setScale(.7)
    :setOpacity(0)

    bg:setScaleX(1.3)
    local bgAction = cc.Sequence:create({
        cc.FadeIn:create(0.3),
        cc.DelayTime:create(3.9),
        cc.FadeOut:create(0.3)
    })

    -- cloud1 -----
    local cloud1 = display.newSprite('#cloud1.png')
    :align(display.CENTER_BOTTOM, width * 0.23, height)
    :setOpacity(0)

    local cloud1Action = cc.Spawn:create({
        cc.EaseSineInOut:create(cc.FadeIn:create(0.4)),
        cc.Sequence:create({
            cc.EaseSineInOut:create(cc.MoveBy:create(0.4, cc.p(0, -0.83 * height))),
            cc.MoveBy:create(0.1, cc.p(0, 0.03 * height)),
            cc.MoveBy:create(1.34, cc.p(0.05 * width, 0)),
            cc.MoveBy:create(1.34, cc.p(-0.1 * width, 0)),
            cc.Spawn:create({
                cc.MoveBy:create(1.34, cc.p(0.1 * width, 0)),
                cc.Sequence:create({
                    cc.DelayTime:create(1),
                    cc.FadeOut:create(0.3)
                })
            })
        })
    })

    -- cloud2 -----
    local cloud2 = display.newSprite('#cloud2.png')
    :align(display.CENTER_BOTTOM, width * 0.58, height)
    :setOpacity(0)

    local cloud2Action = cc.Spawn:create({
        cc.EaseSineInOut:create(cc.FadeIn:create(0.5)),
        cc.Sequence:create({
            cc.EaseSineInOut:create(cc.MoveBy:create(0.5, cc.p(0, -0.88 * height))),
            cc.MoveBy:create(0.1, cc.p(0, 0.03 * height)),
            cc.MoveBy:create(1.34, cc.p(-0.05 * width, 0)),
            cc.MoveBy:create(1.34, cc.p(0.1 * width, 0)),
            cc.Spawn:create({
                cc.MoveBy:create(1.34, cc.p(-0.1 * width, 0)),
                cc.Sequence:create({
                   cc.DelayTime:create(0.9),
                    cc.FadeOut:create(0.3)
                })
            })
        })
    })

    -- cloud3 -----
    local cloud3 = display.newSprite('#cloud3.png')
    :align(display.CENTER_BOTTOM, width * 0.8, height)
    :setOpacity(0)

    local cloud3Action = cc.Spawn:create({
        cc.EaseSineInOut:create(cc.FadeIn:create(0.6)),
        cc.Sequence:create({
            cc.DelayTime:create(0.1),
            cc.EaseSineInOut:create(cc.MoveBy:create(0.5, cc.p(0, -0.75 * height))),
            cc.MoveBy:create(0.08, cc.p(0, 0.01 * height)),
            cc.MoveBy:create(1.34, cc.p(-0.05 * width, 0)),
            cc.MoveBy:create(1.34, cc.p(0.1 * width, 0)),
            cc.Spawn:create({
                cc.MoveBy:create(1.34, cc.p(-0.1 * width, 0)),
                cc.Sequence:create({
                    cc.DelayTime:create(0.8),
                    cc.FadeOut:create(0.3)
                })
            })
        })
    })

    -- bear ------
    local bear = display.newSprite('#body.png')
    :setScale(.8)
    :align(display.CENTER, display.cx, height * 1.1)
    :setOpacity(0)

    local bearAction = cc.Spawn:create({
        cc.EaseSineInOut:create(cc.FadeIn:create(0.6)),
        cc.Sequence:create({
            cc.EaseSineInOut:create(cc.MoveBy:create(0.6, cc.p(0, -0.65 * height))),
            cc.MoveBy:create(0.2, cc.p(0, 0.02 * height)),
            cc.RotateBy:create(0.6, -5),
            cc.RotateBy:create(1.1, 10),
            cc.RotateBy:create(1.1, -10),
            cc.RotateBy:create(0.6, 5),
            cc.Spawn:create({
                cc.MoveBy:create(0.3, cc.p(0, -0.4 * height)),
                cc.FadeTo:create(0.3, 50) 
            })
        }) 
    })

    -- mouth ------
    local mouth = display.newSprite('#mouth.png')
    :setPosition(0.142 * width, 0.29 * height)
    :setOpacity(0)

    local mouthAction = cc.Spawn:create({
        cc.EaseSineInOut:create(cc.FadeIn:create(0.6)),
        cc.Repeat:create(cc.Sequence:create({
            cc.ScaleTo:create(0.8, 0.4),
            cc.ScaleTo:create(0.8, 1)
        }), 4)
    })

    -- bubbles ----
    local bubbles = display.newSprite('#bubbles.png')
    :align(display.LEFT_BOTTOM, 0.138 * width, 0.322 * height)
    :setScale(0.4)
    :setOpacity(0)

    local bubblesAction = cc.Spawn:create({
        cc.EaseSineInOut:create(cc.FadeIn:create(0.6)),
        cc.Repeat:create(cc.Sequence:create({
            cc.ScaleTo:create(1, 1),
            cc.ScaleTo:create(1, 0.4)
        }), 4)
    })

    -- right hands ---
    local rightHand = display.newSprite('#right-hand.png')
    :align(display.RIGHT_TOP, 0.11 * width, 0.25 * height)
    :setOpacity(0)

    local rightHandAction = cc.Spawn:create({
        cc.EaseSineInOut:create(cc.FadeIn:create(0.6)),
        cc.Sequence:create({
            cc.DelayTime:create(0.2),
            cc.Repeat:create(cc.Sequence:create({
                cc.RotateBy:create(1.1, -30),
                cc.RotateBy:create(1.1, 30)
            }), 4)
        })
    })

    -- left hands ---
    local leftHand = display.newSprite('#lift-hand.png')
    :align(cc.p(0, 0.6), 0.15 * width, 0.3 * height)
    :setOpacity(0)
    :setLocalZOrder(-1)

    local leftHandAction = cc.Spawn:create({
        cc.EaseSineInOut:create(cc.FadeIn:create(0.6)),
        cc.Sequence:create({
            cc.DelayTime:create(0.2),
            cc.Repeat:create(cc.Sequence:create({
                cc.RotateBy:create(1.1, 30),
                cc.RotateBy:create(1.1, -30)
            }), 4)
        })
    })

    -- right brow  ---
    local rightBrow = display.newSprite('#brow2.png')
    :setPosition(0.098 * width, 0.34 * height)
    :setOpacity(0)

    local rightBrowAction = cc.Spawn:create({
        cc.EaseSineInOut:create(cc.FadeIn:create(0.6)),
        cc.Sequence:create({
            cc.DelayTime:create(0.2),
            cc.Repeat:create(cc.Sequence:create({
                cc.MoveBy:create(1.1, cc.p(-10, 10)),
                cc.MoveBy:create(1.1, cc.p(10, -10))
            }), 4)
        })
    })

    -- left brow  ---
    local leftBrow = display.newSprite('#brow1.png')
    :setPosition(0.134 * width, 0.38 * height)
    :setOpacity(0)

    local leftBrowAction = cc.Spawn:create({
        cc.EaseSineInOut:create(cc.FadeIn:create(0.6)),
        cc.Sequence:create({
            cc.DelayTime:create(0.2),
            cc.Repeat:create(cc.Sequence:create({
                cc.MoveBy:create(1.1, cc.p(-10, 10)),
                cc.MoveBy:create(1.1, cc.p(10, -10))
            }), 4)
        })
    })
     
    -- stars --------
    local stars = {}
    local starsAction = {}

    for i = 1, 6 do
        stars[i] = display.newSprite('#star.png')
        :align(display.LEFT_BOTTOM, starsConfig[i].x, starsConfig[i].y)
        :setScale(.7)
        :setOpacity(0)
    end

    for i = 1, 6 do
        starsAction[i] = cc.Spawn:create({
            cc.FadeIn:create(0.7),
            cc.Sequence:create({
                cc.MoveBy:create(starsConfig[i][1][2], cc.p(0, starsConfig[i][1][1])),
                cc.MoveBy:create(starsConfig[i][2][2], cc.p(0, starsConfig[i][2][1])),
                cc.MoveBy:create(starsConfig[i][3][2], cc.p(0, starsConfig[i][3][1])),
                cc.MoveBy:create(starsConfig[i][4][2], cc.p(0, starsConfig[i][4][1])),
                cc.DelayTime:create(starsConfig[i][4][2]),
                cc.FadeTo:create(starsConfig[i][6][2], starsConfig[i][6][3]),
                cc.MoveBy:create(starsConfig[i][7][2], cc.p(0, starsConfig[i][7][1])),
            })
        })
    end

    -- run action ---
    table.insert(self.data, { node = self.layer.ownerNode, action = ownerAction })
    table.insert(self.data, { node = root, action = rootAction })
    table.insert(self.data, { node = cloud1, action = cloud1Action })
    table.insert(self.data, { node = cloud2, action = cloud2Action })
    table.insert(self.data, { node = cloud3, action = cloud3Action })
    table.insert(self.data, { node = bear, action = bearAction })
    table.insert(self.data, { node = bubbles, action = bubblesAction })
    table.insert(self.data, { node = mouth, action = mouthAction })
    table.insert(self.data, { node = rightHand, action = rightHandAction })
    table.insert(self.data, { node = leftHand, action = leftHandAction })
    table.insert(self.data, { node = rightBrow, action = rightBrowAction })
    table.insert(self.data, { node = leftBrow, action = leftBrowAction })
    table.insert(self.data, { node = bg, action = bgAction })
    for i = 1, 6 do table.insert(self.data, { node = stars[i], action = starsAction[i] }) end

    -- add child ---
    root:addChild(bg)
    root:addChild(cloud3)
    for i = 1, 6 do root:addChild(stars[i]) end
    root:addChild(bear)
    bear:addChild(bubbles)
    bear:addChild(mouth)
    bear:addChild(rightHand)
    bear:addChild(leftHand)
    bear:addChild(rightBrow)
    bear:addChild(leftBrow)
    root:addChild(cloud1)
    root:addChild(cloud2)
    self:addChild(root)
end

function BearNode:onExit()
    printInfo("bear  exit!!!!!!!!!!!!")
    display.removeSpriteFrames(self:getResourcePath("bear.plist"), self:getResourcePath("bear.png"))
end

function BearNode:create(layer, msg)
    local node = BearNode.new(layer, msg)
    node:init()
    return node
end

return BearNode

