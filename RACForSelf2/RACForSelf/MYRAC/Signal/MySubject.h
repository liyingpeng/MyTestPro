//
//  MySubject.h
//  RACForSelf
//
//  Created by 李应鹏 on 2018/3/28.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MYSubscriber;

// 自实现热信号

// 热信号 自身有状态，因为存储了订阅者信息
@interface MySubject : NSObject

@property (nonatomic, strong) NSMutableArray *subscribers;

+ (instancetype)subject;

- (void)subscibeNext:(void(^)(id))next;

- (void)sendNext:(id)value;

@end
