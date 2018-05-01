//
//  MYSignal.h
//  RACForSelf
//
//  Created by 李应鹏 on 2018/3/28.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MYSubscriber;

// 自实现冷信号

// 为什么要区分冷热信号
// 1.

// 如何将冷信号转换成热信号：广播

@interface MYSignal : NSObject

+ (instancetype)createSignal:(void(^)(MYSubscriber *))didSubscribe;

- (void)subscibeNext:(void(^)(id))next;

- (instancetype)flattenMap:(MYSignal *(^)(id value))block;

@end
