//
//  HTSCountTimer.m
//  PopupViewDemo
//
//  Created by lixinlei on 2018/1/31.
//  Copyright © 2018年 com.bytedance. All rights reserved.
//

#import "HTSCountTimer.h"

@interface HTSCountTimer ()

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign) NSUInteger maxCount;
@property (nonatomic, assign) NSUInteger countNum;
@property (nonatomic, assign) float interval;
@property (nonatomic, copy) void(^callBack)(NSUInteger remainCount);
@property (nonatomic, copy) void(^complete)(void);
@property (nonatomic, assign) BOOL isCountDown;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation HTSCountTimer

- (instancetype)initWithCount:(NSUInteger)count interval:(float)interval callBack:(void(^)(NSUInteger remainCount))callBack complete:(void(^)(void))complete countDown:(BOOL)countDown
{
    self = [super init];
    if (self) {
        self.maxCount = count;
        self.isCountDown = countDown;
        if (countDown) {
            self.countNum = count;
        } else {
            self.countNum = 0;
        }
        self.interval = interval;
        self.callBack = callBack;
        self.complete = complete;
        self.queue = dispatch_queue_create("HTSCountTimer_Timer_Queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

+ (instancetype)countDownTimerWithCount:(NSUInteger)count interval:(float)interval callBack:(void(^)(NSUInteger remainCount))callBack complete:(void(^)(void))complete
{
    return [[self alloc] initWithCount:count interval:interval callBack:callBack complete:complete countDown:YES];
}

+ (instancetype)countTimerWithCount:(NSUInteger)count interval:(float)interval callBack:(void(^)(NSUInteger remainCount))callBack complete:(void(^)(void))complete
{
    return [[self alloc] initWithCount:count interval:interval callBack:callBack complete:complete countDown:NO];
}

- (void)start
{
    if (self.isCountDown) {
        self.countNum = self.maxCount;
    } else {
        self.countNum = 0;
    }
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1ull * NSEC_PER_SEC)), self.interval * NSEC_PER_SEC, 0);
    __weak typeof (self) weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        __strong typeof (self) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (strongSelf.isCountDown) {
                strongSelf.countNum--;
            } else {
                strongSelf.countNum++;
            }
            !strongSelf.callBack ?: strongSelf.callBack(strongSelf.countNum);
            [strongSelf completeIfNeeded];
        });
    });
    dispatch_resume(_timer);
}

- (void)completeIfNeeded
{
    if (self.isCountDown) {
        if (self.countNum <= 0) {
            if (!_timer) return;
            dispatch_source_cancel(_timer);
            _timer = nil;
            !self.complete ?: self.complete();
        }
    } else {
        if (self.countNum >= self.maxCount) {
            if (!_timer) return;
            dispatch_source_cancel(_timer);
            _timer = nil;
            !self.complete ?: self.complete();
        }
    }
}

- (void)cancel
{
    if (!_timer) return;
    dispatch_source_cancel(_timer);
    _timer = nil;
    _complete = nil;
}

- (void)pause
{
    if (!_timer) return;
    dispatch_suspend(_timer);
}

- (BOOL)running {
    return !!_timer;
}

@end
