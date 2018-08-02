//
//  MyHittestView.m
//  TestForHittest
//
//  Created by 李应鹏 on 2018/5/31.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "MyHittestView.h"

@implementation MyHittestView

// UIView 的事件透传

//通常我们会遇到这种需求，一个视图除了需要响应子视图的点击事件，其它空白地方希望能将点击事件透传到，比如自定义了一个“导航栏”，除了左右两边按钮，希望其它部分点击能够透传到底下的视图。这个时候我们可以通过复写 hitTest 方法，具体实现如图，只响应子视图的事件，而非子视图区域部分的交互事件则透传到响应链中的下一个响应者。

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.hidden || self.alpha < FLT_EPSILON || self.userInteractionEnabled) {
        return [super hitTest:point withEvent:event];
    }
    
    UIView *targetView = nil;
    for (UIView *v in self.subviews) {
        if ((targetView = [super hitTest:[v convertPoint:point fromView:self] withEvent:event])) {
            break;
        }
    }
    return targetView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
