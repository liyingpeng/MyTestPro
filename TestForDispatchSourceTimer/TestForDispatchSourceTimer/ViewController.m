//
//  ViewController.m
//  TestForDispatchSourceTimer
//
//  Created by 李应鹏 on 2018/5/15.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"
#import "HTSCountTimer.h"

@interface ViewController ()
@property (nonatomic, strong) HTSCountTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timer = [HTSCountTimer countTimerWithCount:10 interval:1 callBack:nil complete:^{
        //
    }];
    [self.timer start];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.timer cancel];
//        [self.timer cancel];
//    });
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
