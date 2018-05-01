//
//  MyQueue.h
//  TestForGeneric
//
//  Created by 李应鹏 on 2018/5/1.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyQueue<T> : NSObject

- (void)enqueue:(T)value;
- (T)dequeue;

@end
