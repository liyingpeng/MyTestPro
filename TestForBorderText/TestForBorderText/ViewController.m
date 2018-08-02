//
//  ViewController.m
//  TestForBorderText
//
//  Created by 李应鹏 on 2018/7/23.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"
#import "THLabel.h"

#define kShadowOffsetY (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 4.0f : 2.0f)
#define kShadowBlur (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 10.0f : 5.0f)
#define kStrokeSize (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 6.0f : 3.0f)


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    THLabel *label = [THLabel new];
    //    [label setShadowColor:[UIColor colorWithWhite:0.0f alpha:0.75f]];
    //    [label setShadowOffset:CGSizeMake(0.0f, kShadowOffsetY)];
    ////    [label setShadowBlur:kShadowBlur];
    //    [label setStrokeColor:[UIColor blackColor]];
//    [label setStrokeSize:3];
    [label setGradientStartColor:[UIColor whiteColor]];
    [label setGradientEndColor:[UIColor blackColor]];
    
    label.frame = CGRectMake(0, 0, 300, 50);
    label.font = [UIFont systemFontOfSize:50];
    //    label.textColor = [UIColor redColor];
    //    label.strokePosition = THLabelStrokePositionOutside;
    //    [label setStrokeColor:[UIColor blackColor]];
    //    [label setStrokeSize:1];
    label.text = @"adfasdfasdf";
    [self.view addSubview:label];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
