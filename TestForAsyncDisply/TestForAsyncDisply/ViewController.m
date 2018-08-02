//
//  ViewController.m
//  TestForAsyncDisply
//
//  Created by 李应鹏 on 2018/7/18.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"
#import "AsyncViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 50);
    [button setTitle:@"Async" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)click {
    [self.navigationController pushViewController:[AsyncViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
