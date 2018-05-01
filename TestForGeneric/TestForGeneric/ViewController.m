//
//  ViewController.m
//  TestForGeneric
//
//  Created by 李应鹏 on 2018/5/1.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"
#import "MyQueue.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyQueue<NSString *> *queue = [MyQueue new];
    [queue enqueue:@"hahah"];
    NSLog(@"dequeue: %@", [queue dequeue]);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
