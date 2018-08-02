//
//  ViewController.m
//  TestForPrivateCategary
//
//  Created by 李应鹏 on 2018/5/14.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"
#import "MySubClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MySubClass *a = MySubClass.new;
    [a wrapperFunc];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
