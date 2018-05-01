//
//  MYSubscriber.h
//  RACForSelf
//
//  Created by 李应鹏 on 2018/3/28.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSubscriber : NSObject

@property (nonatomic, copy) void(^next)(id);

- (void)sendNext:(id)value;

@end
