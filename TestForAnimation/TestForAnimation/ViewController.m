//
//  ViewController.m
//  TestForAnimation
//
//  Created by 李应鹏 on 2018/7/25.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *v = [UIView new];
    v.frame = CGRectMake(100, 500, 100, 50);
    v.backgroundColor = [UIColor blackColor];
    [self.view addSubview:v];
    
    UIView * maskLayer = [UIView new];
    maskLayer.frame = CGRectMake(0, 0, 100, 0);
    maskLayer.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:96 / 255.0 blue:71 / 255.0 alpha:1.0];
    [v addSubview:maskLayer];
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size.height"];
//    animation.fromValue = @(0);
//    animation.toValue = @(50);
//    animation.repeatCount = 1;
//    animation.duration = 3;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    [maskLayer addAnimation:animation forKey:nil];
    [UIView animateWithDuration:3 animations:^{
        maskLayer.frame = CGRectMake(0, 0, 100, 50);;
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
