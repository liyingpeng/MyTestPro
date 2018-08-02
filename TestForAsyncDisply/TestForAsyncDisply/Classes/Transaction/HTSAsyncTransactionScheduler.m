//
//  HTSAsyncTransactionScheduler.m
//  TestForAsyncLayer
//
//  Created by 李应鹏 on 2017/10/29.
//  Copyright © 2017年 李应鹏. All rights reserved.
//

#import "HTSAsyncTransactionScheduler.h"
#import "HTSAsyncDefine.h"
#import <UIKit/UIApplication.h>

@interface HTSAsyncOperation: NSObject
@property(nonatomic, copy) dispatch_block_t action;
- (instancetype)initWithAction:(dispatch_block_t)action;
@end
@implementation HTSAsyncOperation
- (instancetype)initWithAction:(dispatch_block_t)action
{
    self = [super init];
    if (self) {
        self.action = action;
    }
    return self;
}
@end

@interface HTSAsyncDispatchEntry : NSObject
@property(nonatomic, assign) NSInteger threadCount;
- (void)pushAction:(HTSAsyncOperation *)action;
- (HTSAsyncOperation *)popNext;
- (BOOL)empty;
@end

@implementation HTSAsyncDispatchEntry {
    NSMutableArray<HTSAsyncOperation *> *_actions;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _actions = [NSMutableArray array];
        _threadCount = 0;
    }
    return self;
}

- (void)pushAction:(HTSAsyncOperation *)action {
    [_actions addObject:action];
}

- (HTSAsyncOperation *)popNext {
    HTSDisplayAssert(_actions.count != 0, @"No scheduled operations available");
    HTSAsyncOperation * res = _actions[0];
    [_actions removeObjectAtIndex:0];
    return res;
}

- (BOOL)empty {
    return _actions.count == 0;
}

@end

@interface GroupNotify : NSObject
@property(nonatomic, copy) dispatch_block_t block;
@property(nonatomic, strong) dispatch_queue_t queue;
@end

@implementation GroupNotify
@end

@implementation HTSAsyncTransactionScheduler {
    dispatch_queue_t _displayQueue;
    HTSAsyncDispatchEntry *_entry;
    NSInteger _pendingOperations;
    NSMutableArray *_notifies;
    NSRecursiveLock *_lock;
}

+ (instancetype)shareInstance
{
    static HTSAsyncTransactionScheduler *scheduler;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scheduler = [HTSAsyncTransactionScheduler new];
    });
    return scheduler;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _entry = [HTSAsyncDispatchEntry new];
        _displayQueue = dispatch_queue_create("hts.AsyncDisplay.AsyncTransactionScheduler.displayQueue", DISPATCH_QUEUE_CONCURRENT);
        _lock = [[NSRecursiveLock alloc] init];
        dispatch_set_target_queue(_displayQueue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0));
        _notifies = [NSMutableArray array];
        _pendingOperations = 0;
    }
    return self;
}

- (void)scheduleWithBlock:(dispatch_block_t)block {
    [_lock lock];
    HTSAsyncOperation *action = [[HTSAsyncOperation alloc] initWithAction:block];
    [_entry pushAction:action];
    ++_pendingOperations;
    NSUInteger maxThreads = [NSProcessInfo processInfo].activeProcessorCount * 2;
    if ([[NSRunLoop mainRunLoop].currentMode isEqualToString:UITrackingRunLoopMode]) --maxThreads;
    if (_entry.threadCount < maxThreads) {
        ++_entry.threadCount;
        __weak __typeof(self) weakSelf = self;
        dispatch_async(_displayQueue, ^{
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            [_lock lock];
            while (![_entry empty]) {
                HTSAsyncOperation * operation = [_entry popNext];
                [_lock unlock];
                if (operation.action) operation.action();
                [strongSelf leave];
                operation.action = nil;
                [_lock lock];
            }
            --_entry.threadCount;
            [_lock unlock];
        });
    }
    [_lock unlock];
}

- (void)leave {
    [_lock lock];
    --_pendingOperations;
    if (_pendingOperations == 0) {
        for (GroupNotify *notify in _notifies) {
            dispatch_async(notify.queue, notify.block);
        }
        [_notifies removeAllObjects];
    }
    [_lock unlock];
}

- (void)notify:(dispatch_queue_t)queue action:(dispatch_block_t)action {
    [_lock lock];
    if (_pendingOperations == 0) {
        dispatch_async(queue, action);
    } else {
        GroupNotify *notify = [GroupNotify new];
        notify.block = action;
        notify.queue = queue;
        [_notifies addObject:notify];
    }
    [_lock unlock];
}

@end


