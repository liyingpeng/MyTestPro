//
//  ViewController.m
//  TestForDatarace
//
//  Created by 李应鹏 on 2018/4/19.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arr = @[].mutableCopy;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        for (int i = 0; i < 1000 ; i++) {
            [self.arr addObject:@(0)];
//        }
    });
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
////        for (int i = 0; i < 1000 ; i++) {
//            [self.arr addObject:@(0)];
////        }
//    });
    
    [self.arr addObject:@(1)];
//    for (int i = 0; i < 100 ; i++) {
//        NSLog(@"%@", self.arr);
//    }
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
