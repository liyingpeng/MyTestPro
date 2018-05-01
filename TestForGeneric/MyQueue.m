//
//  MyQueue.m
//  TestForGeneric
//
//  Created by 李应鹏 on 2018/5/1.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "MyQueue.h"

@interface MyQueue ()
@property (nonatomic, strong) NSMutableArray<id> *array;
@end

@implementation MyQueue

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.array = @[].mutableCopy;
    }
    return self;
}

- (id)dequeue {
    if (self.array.count > 0) {
        id value = self.array[0];
        [self.array removeObject:value];
        return value;
    }
    return nil;
}

- (void)enqueue:(id)value {
    [self.array addObject:value];
}

@end
