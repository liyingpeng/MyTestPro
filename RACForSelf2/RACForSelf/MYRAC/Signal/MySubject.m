//
//  MySubject.m
//  RACForSelf
//
//  Created by 李应鹏 on 2018/3/28.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "MySubject.h"
#import "MYSubscriber.h"

@interface MySubject ()

@end

@implementation MySubject

+ (instancetype)subject {
    return [self new];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.subscribers = @[].mutableCopy;
    }
    return self;
}

- (void)subscibeNext:(void(^)(id))next {
    MYSubscriber *subscriber = [MYSubscriber new];
    subscriber.next = next;
    [self.subscribers addObject:subscriber];
}

- (void)sendNext:(id)value {
    [self enumerateSubscribersUsingBlock:^(MYSubscriber *subscriber) {
        [subscriber sendNext:value];
    }];
}

- (void)enumerateSubscribersUsingBlock:(void(^)(MYSubscriber *subscriber))block {
    [self.subscribers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block(obj);
    }];
}

@end
