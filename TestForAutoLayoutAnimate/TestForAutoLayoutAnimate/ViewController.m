//
//  ViewController.m
//  TestForAutoLayoutAnimate
//
//  Created by 李应鹏 on 2018/4/18.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

@interface MyView: UIView
@property (nonatomic, assign) NSInteger tagInfo;
@end
@implementation MyView
@end

@interface ViewController ()
@property (nonatomic, strong) NSArray *colorArr;
@property (nonatomic, strong) NSMutableArray *controls;
@property (nonatomic, strong) NSArray *sequence1;
@property (nonatomic, strong) NSArray *sequence2;
@property (nonatomic, strong) UIButton *clickButton;
@property (nonatomic, strong) UIView *container;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorArr = @[[UIColor redColor], [UIColor lightGrayColor], [UIColor greenColor], [UIColor blackColor], [UIColor yellowColor]];
    self.controls = @[].mutableCopy;
    self.sequence1 = @[@0,@1,@2,@3,@4];
    self.sequence2 = @[@4,@0,@1,@2];
    
    [self.view addSubview:self.container];
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(-10);
    }];

    for (UIColor *color in self.colorArr) {
        NSInteger index = [self.colorArr indexOfObject:color];
        MyView *v = [MyView new];
        v.tagInfo = index;
        v.backgroundColor = color;
        [self.container addSubview:v];
        [self.controls addObject:v];
    }
    
    [self.controls mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:5 leadSpacing:0 tailSpacing:0];
    [self.controls mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.container);
        make.width.height.mas_equalTo(100);
    }];
    
    [self.view addSubview:self.clickButton];
    [self.clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.width.height.mas_equalTo(100);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (UIButton *)clickButton {
    if (!_clickButton) {
        _clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clickButton setTitle:@"click" forState:UIControlStateNormal];
        [_clickButton setBackgroundColor:[UIColor lightGrayColor]];
        [_clickButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickButton;
}

- (UIView *)container {
    if (!_container) {
        _container = [UIView new];
        _container.backgroundColor = [UIColor greenColor];
    }
    return _container;
}

- (void)click {
    NSMutableArray *arr = @[].mutableCopy;
    for (MyView *v in self.controls) {
        for (NSNumber *tag in self.sequence2) {
            if (v.tagInfo == [tag integerValue]) {
                [arr addObject:v];
            }
        }
        if (![arr containsObject:v]) [v removeFromSuperview];
    }
    NSArray * result = [arr copy];
    
    [self.container layoutIfNeeded];

    [result enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *installedConstraints = [MASViewConstraint installedConstraintsForView:obj];
        for (MASConstraint *constraint in installedConstraints) {
            [constraint uninstall];
        }
    }];
    [result mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:5 leadSpacing:0 tailSpacing:0];
    [result mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.container);
        make.width.height.mas_equalTo(100);
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
