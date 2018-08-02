//
//  ViewController.m
//  TestForDispatchGroupWait
//
//  Created by 李应鹏 on 2018/5/22.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.starming.gcddemo.concurrentqueue",DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    //在group中添加队列的block
    dispatch_group_async(group, concurrentQueue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"1");
    });
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"2");
    });
    
    /*
     dispatch_group_wait & dispatch_group_notify 的首要区别就是wait 是 阻塞式的 notify非阻塞
     */
    
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_group_notify(group, concurrentQueue, ^{
        NSLog(@"can continue");
    });
    
    NSLog(@"main queue can continue");
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
