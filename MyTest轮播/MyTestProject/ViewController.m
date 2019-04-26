//
//  ViewController.m
//  MyTestProject
//
//  Created by liyingpeng on 2019/4/22.
//  Copyright © 2019 liyingpeng. All rights reserved.
//

#import "ViewController.h"
#import "ScrollImageView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 轮播图
    ScrollImageView *scrollImageView = [[ScrollImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollImageView];
}

@end
