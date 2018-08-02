//
//  ViewController.m
//  TestForPercent
//
//  Created by 李应鹏 on 2018/5/11.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"

@interface MyView:UIView

@end

@implementation MyView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
//        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            self.center = CGPointMake(self.center.x - 100, self.center.y);
//        } completion:^(BOOL finished) {
//            //
//        }];
        CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"position.x"];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.damping = 5;
        animation.stiffness = 300;
        animation.mass = 0.5f;
        animation.initialVelocity = 0;
        animation.fromValue = @(self.center.x + 10);
        animation.toValue = @(self.center.x);
        animation.duration = animation.settlingDuration;
        [self.layer addAnimation:animation forKey:nil];
    }
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyView *v = [[MyView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    v.backgroundColor = UIColor.redColor;
    [self.view addSubview:v];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
