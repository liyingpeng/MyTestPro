//
//  ViewController.m
//  TestSemaphore
//
//  Created by 李应鹏 on 2018/3/29.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES)
        {
            long st = dispatch_semaphore_signal(sem);
            NSLog(@"test waiting signal : %d", st);
            sleep(2);
        }// end while
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES)
        {
            //假定连续5次超时50ms认为卡顿(当然也包含了单次超时250ms)
            dispatch_semaphore_wait(sem, dispatch_time(DISPATCH_TIME_NOW, DISPATCH_TIME_FOREVER));
            NSLog(@"test waiting awate");
            sleep(1);
        }// end while
    });
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
