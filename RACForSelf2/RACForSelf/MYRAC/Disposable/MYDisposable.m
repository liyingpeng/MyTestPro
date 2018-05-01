//
//  MYDisposable.m
//  RACForSelf
//
//  Created by 李应鹏 on 2018/3/28.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "MYDisposable.h"

@interface MYDisposable ()

@property (nonatomic, copy) void(^disposeBlock)(void);

@end

@implementation MYDisposable {
    BOOL _disposed;
}

- (void)dealloc
{
    self.disposeBlock = nil;
}

- (BOOL)isDisposed {
    return !self.disposeBlock;
}
 
- (instancetype)initWithBlock:(void(^)(void))block
{
    self = [super init];
    if (self) {
        self.disposeBlock = block;
    }
    return self;
}

+ (instancetype)disposableWithBlock:(void(^)(void))block {
    return [[self alloc] initWithBlock:block];
}

- (void)dispose {
    if (!_disposed) return;
    _disposed = YES;
    !self.disposeBlock ?: self.disposeBlock();
}

@end
