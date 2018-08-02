//
//  HTSCountTimer.h
//  PopupViewDemo
//
//  Created by lixinlei on 2018/1/31.
//  Copyright © 2018年 com.bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTSCountTimer : NSObject

+ (instancetype)countDownTimerWithCount:(NSUInteger)count interval:(float)interval callBack:(void(^)(NSUInteger remainCount))callBack complete:(void(^)(void))complete;

+ (instancetype)countTimerWithCount:(NSUInteger)count interval:(float)interval callBack:(void(^)(NSUInteger remainCount))callBack complete:(void(^)(void))complete;

- (void)start;
- (void)pause;
- (void)cancel;
- (BOOL)running;

@end
