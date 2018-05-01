//
//  ViewController.m
//  TestDic
//
//  Created by 李应鹏 on 2018/4/3.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"

@interface TEST: NSObject

@property (nonatomic, strong) NSString *a;

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TEST *t;
    id hah = @{@"a" : @"b"};
    t = hah;
    NSString *s = t.a;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
