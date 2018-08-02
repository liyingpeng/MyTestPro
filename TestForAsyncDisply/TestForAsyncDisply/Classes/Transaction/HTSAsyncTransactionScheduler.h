//
//  HTSAsyncTransactionScheduler.h
//  TestForAsyncLayer
//
//  Created by 李应鹏 on 2017/10/29.
//  Copyright © 2017年 李应鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTSAsyncTransactionScheduler : NSObject
+ (instancetype)shareInstance;
- (void)scheduleWithBlock:(dispatch_block_t)block;
- (void)notify:(dispatch_queue_t)queue action:(dispatch_block_t)action;
@end
