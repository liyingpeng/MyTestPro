//
//  ViewController.m
//  TestForAttentionAnimate
//
//  Created by 李应鹏 on 2018/5/8.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"
#import <Masonry.h>

@interface ViewController ()
@property (nonatomic, strong) MyView *myView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myView = MyView.new;
    [self.view addSubview:self.myView];
    [self.myView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    [self.myView startPerform];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
