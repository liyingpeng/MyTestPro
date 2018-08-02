//
//  ViewController.m
//  TestForTargetQueue
//
//  Created by 李应鹏 on 2018/6/1.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t queue = dispatch_queue_create(@"test".UTF8String, DISPATCH_QUEUE_SERIAL);

    dispatch_set_target_queue(queue, dispatch_get_main_queue());
    
    dispatch_async(queue, ^{
        //
    });

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
