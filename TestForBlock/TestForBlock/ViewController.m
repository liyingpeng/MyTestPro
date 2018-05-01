//
//  ViewController.m
//  TestForBlock
//
//  Created by 李应鹏 on 2018/4/24.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, copy) void(^block3)(void);
@property (nonatomic, assign) NSInteger interger;
@end

@implementation ViewController

static int static_global_i = 2;

int global_i = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    static int static_k = 3;
    // 一、 block 捕获外部变量
        // 1. 自动变量
        // 2. 函数参数
        // 3. 静态变量
        // 4. 静态全局变量
        // 5. 全局变量
    int var = 4;
    NSObject * obj = [[NSObject alloc]init];
    void (^block1)(void) = ^{
        global_i++;
        static_global_i++;
        static_k++;
    };
    
    void (^block2)(void) = ^{
        NSLog(@"%@", obj);
    };
    
    self.block3 = ^{
        NSLog(@"%d", var);
    };
    
    NSLog(@"%@", block1);
    NSLog(@"%@", block2);
    NSLog(@"%@", self.block3);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
