//
//  ViewController.m
//  TESTForRAC
//
//  Created by liyingpeng on 2018/3/31.
//  Copyright © 2018年 liyingpeng. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>

@interface TEST: NSObject

@end

@implementation TEST

- (void)dealloc {
    
}

@end

@interface ViewController ()

@property (nonatomic, strong) UIView *aView;

@property (nonatomic, strong) NSMutableArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    RACSubject *sub = [RACSubject subject];
//
//    [sub subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
//
//    [sub sendNext:@(1)];
    
    
    _arr = @[].mutableCopy;
    
    TEST *t = [TEST new];
    @autoreleasepool {
        [_arr addObject:t];

        [_arr removeObject:t];
    }
    
    
    
    
    self.aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    self.aView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.aView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
