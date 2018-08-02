//
//  ViewController.m
//  TestforMessageCache
//
//  Created by 李应鹏 on 2018/6/25.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"
#import <ojbc>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

IMP lookUp(id obj, SEL selector) {
    Class c = object_getClass(obj);
}


@end
