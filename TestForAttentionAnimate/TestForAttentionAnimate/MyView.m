//
//  MyView.m
//  TestForAttentionAnimate
//
//  Created by 李应鹏 on 2018/5/9.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "MyView.h"
#import <Masonry.h>

@interface MyView ()
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) NSTimer *rippleTimer;
@property (nonatomic, strong) UIView *attentionView;
@property (nonatomic, strong) UILabel *attentionLabel;
@end

@implementation MyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.centerView];
        [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
            make.width.height.mas_equalTo(60);
        }];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [self startPerform];
    }
}

- (void)startPerform {
    CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scale.values = @[@0, @1];
    scale.duration = 0.5;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scale.timingFunction = timingFunction;
    scale.removedOnCompletion = YES;
    [self.centerView.layer addAnimation:scale forKey:nil];
    [self performSelector:@selector(startRipple) withObject:nil afterDelay:0.5];
}

- (void)startRipple
{
    self.rippleTimer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(addRippleLayer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_rippleTimer forMode:NSRunLoopCommonModes];
    [self showAttention];
}

- (void)showAttention {
    [self addSubview:self.attentionView];
    [self.attentionView addSubview:self.attentionLabel];
    [self.attentionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self);
        make.height.mas_equalTo(20);
    }];
    [self.attentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.attentionView);
    }];
    
    [self layoutIfNeeded];
    [self.attentionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
    }];
    [UIView animateWithDuration:0.18 animations:^{
        [self layoutIfNeeded];
    }];
    
    CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scale.values = @[@0,@1];
    scale.duration = 0.3;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scale.timingFunction = timingFunction;
    scale.removedOnCompletion = YES;
    [self.attentionLabel.layer addAnimation:scale forKey:nil];
}

- (void)clickAttention:(UITapGestureRecognizer *)tap {
    [self closeRippleTimer];
    self.attentionLabel.text = @"已关注";
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = UIView.new;
        _centerView.backgroundColor = [UIColor redColor];
        _centerView.layer.cornerRadius = 30;
    }
    return _centerView;
}

- (UIView *)attentionView {
    if (!_attentionView) {
        _attentionView = UIView.new;
        _attentionView.backgroundColor = [UIColor whiteColor];
        _attentionView.layer.cornerRadius = 8;
        _attentionView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAttention:)];
        [_attentionView addGestureRecognizer:tap];
    }
    return _attentionView;
}

- (UILabel *)attentionLabel
{
    if (!_attentionLabel) {
        _attentionLabel = [UILabel new];
        _attentionLabel.textColor = [UIColor redColor];
        _attentionLabel.font = [UIFont systemFontOfSize:12.f];
        _attentionLabel.text = @"关注我";
    }
    return _attentionLabel;
}
- (void)rippleButtonTouched:(id)sender
{
    [self closeRippleTimer];
    [self addRippleLayer];
}

- (CGRect)makeEndRect
{
    return CGRectInset(self.centerView.frame, -20, -20);
}

- (void)addRippleLayer
{
    CAShapeLayer *rippleLayer = [[CAShapeLayer alloc] init];
    rippleLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.centerView.frame];
    rippleLayer.path = path.CGPath;
    rippleLayer.strokeColor = [UIColor greenColor].CGColor;
    rippleLayer.lineWidth = 2;
    rippleLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer insertSublayer:rippleLayer below:self.centerView.layer];
    
    //addRippleAnimation
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithOvalInRect:self.centerView.frame];
    CGRect endRect = [self makeEndRect];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];
    
    rippleLayer.path = endPath.CGPath;
    rippleLayer.opacity = 0.0;
    
    CABasicAnimation *rippleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    rippleAnimation.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
    rippleAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    rippleAnimation.duration = 1;
    
    CABasicAnimation *widthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    widthAnimation.fromValue = [NSNumber numberWithFloat:2];
    widthAnimation.toValue = [NSNumber numberWithFloat:0.0];
    widthAnimation.duration = 1;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.duration = 1;
    
    [rippleLayer addAnimation:opacityAnimation forKey:@""];
    [rippleLayer addAnimation:widthAnimation forKey:@""];
    [rippleLayer addAnimation:rippleAnimation forKey:@""];
    
    [self performSelector:@selector(removeRippleLayer:) withObject:rippleLayer afterDelay:1];
}

- (void)removeRippleLayer:(CAShapeLayer *)rippleLayer
{
    [rippleLayer removeFromSuperlayer];
    rippleLayer = nil;
}

- (void)closeRippleTimer
{
    if (_rippleTimer) {
        if ([_rippleTimer isValid]) {
            [_rippleTimer invalidate];
        }
        _rippleTimer = nil;
    }
}

- (CGSize)intrinsicContentSize {
    return self.centerView.frame.size;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
