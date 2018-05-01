//
//  MyReplySubject.m
//  RACForSelf
//
//  Created by 李应鹏 on 2018/3/28.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "MyReplySubject.h"
#import "MYSubscriber.h"

@interface MyReplySubject ()
@property (nonatomic, strong) NSMutableArray *receivedValues;
@end

@implementation MyReplySubject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.receivedValues = @[].mutableCopy;
    }
    return self;
}

- (void)subscibeNext:(void(^)(id))next {
    MYSubscriber *subscriber = [MYSubscriber new];
    subscriber.next = next;
    for (id value in self.receivedValues) {
        [subscriber sendNext:value];
    }
    [self.subscribers addObject:subscriber];
}

- (void)sendNext:(id)value {
    [self.receivedValues addObject:value];
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
