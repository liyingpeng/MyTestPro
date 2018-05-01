//
//  ViewController.m
//  TestForAsyncToSync
//
//  Created by 李应鹏 on 2018/4/10.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//
//    [self asyncTaskWithComplete:^{
//        dispatch_semaphore_signal(sema);
//        NSLog(@"task has done...");
//    }];
//    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_enter(group);

    [self asyncTaskWithComplete:^{
        dispatch_group_leave(group);
    }];

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"task has done...");
    });
    
    NSLog(@"running...");
    
    [[NSNotificationCenter defaultCenter]
     addObserverForName:UIApplicationWillResignActiveNotification
     object:nil
     queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification *_Nonnull note) {
         [self pauseRecording];
     }];
    [[NSNotificationCenter defaultCenter]
     addObserverForName:UIApplicationDidBecomeActiveNotification
     object:nil
     queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification *_Nonnull note) {
         [self startRecording];
     }];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)pauseRecording {
    NSLog(@"pauseRecording");
}

- (void)startRecording {
    NSLog(@"startRecording");
}

- (void)asyncTaskWithComplete:(dispatch_block_t)complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        !complete ?: complete();
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
