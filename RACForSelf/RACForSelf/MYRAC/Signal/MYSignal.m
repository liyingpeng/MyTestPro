//
//  MYSignal.m
//  RACForSelf
//
//  Created by 李应鹏 on 2018/3/28.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "MYSignal.h"
#import "MYSubscriber.h"

@interface MYSignal ()

@property (nonatomic, copy) void(^didSubsribe)(MYSubscriber *subscriber);

@end

@implementation MYSignal

+ (instancetype)createSignal:(void(^)(MYSubscriber *))didSubscribe {
    MYSignal *signal = [MYSignal new];
    signal.didSubsribe = didSubscribe;
    return signal;
}

- (void)subscribe:(MYSubscriber *)subscriber {
    if (self.didSubsribe) {
        self.didSubsribe(subscriber);
    }
}

- (void)subscibeNext:(void(^)(id))next {
    MYSubscriber *subscriber = [MYSubscriber new];
    subscriber.next = next;
    [self subscribe:subscriber];
}

// 这里有一个很重要的概念，就是任何的信号转换即是对原有的信号进行订阅从而产生新的信号
- (instancetype)flattenMap:(MYSignal *(^)(id value))block {
    return [MYSignal createSignal:^(MYSubscriber *subscriber) {
        // 对原有信号进行订阅
        [self subscibeNext:^(id x) {
            // 产生新的信号
            MYSignal *signal = block(x);
            [signal subscibeNext:^(id x) {
                [subscriber sendNext:x];
            }];
        }];
    }];
}

@end
