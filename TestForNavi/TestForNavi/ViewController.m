//
//  ViewController.m
//  TestForNavi
//
//  Created by liyingpeng on 2018/4/10.
//  Copyright © 2018年 liyingpeng. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *left;
@property (nonatomic, strong) UIView *right;
@property (nonatomic, strong) UIButton *leftControl;
@property (nonatomic, strong) UIButton *rightControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftControl = [UIButton new];
    [self.leftControl setTitle:@"left" forState:UIControlStateNormal];
    [self.leftControl addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftControl];
    self.leftControl.backgroundColor =[UIColor blackColor];
    [self.leftControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.width.height.mas_equalTo(100);
    }];
    
    self.rightControl = [UIButton new];
    [self.rightControl setTitle:@"right" forState:UIControlStateNormal];
    [self.rightControl addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    self.rightControl.backgroundColor =[UIColor blackColor];
    [self.view addSubview:self.rightControl];
    [self.rightControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.view);
        make.width.height.mas_equalTo(100);
    }];
    
    self.container = [UIView new];
    self.container.backgroundColor =[UIColor lightGrayColor];
    [self.view addSubview:self.container];
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(100);
    }];
    
    self.left = [UIView new];
    self.left.backgroundColor = [UIColor redColor];
    [self.container addSubview:_left];
    [self.left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.container);
    }];
    
    self.right = [UIView new];
    self.right.backgroundColor = [UIColor greenColor];
    [self.container addSubview:_right];
    [self.right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.container);
        make.leading.equalTo(self.container.mas_trailing);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)leftClick {
    [self.left mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.container);
        make.trailing.equalTo(self.container.mas_leading);
    }];
    
    [self.right mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.container);
    }];
    
    [UIView animateWithDuration:0.35 animations:^{
        [self.container layoutIfNeeded];
    }];
}

- (void)rightClick {
    [self.left mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.container);
    }];
    
    [self.right mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.container);
        make.leading.equalTo(self.container.mas_trailing);
    }];
    
    [UIView animateWithDuration:0.35 animations:^{
        [self.container layoutIfNeeded];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
