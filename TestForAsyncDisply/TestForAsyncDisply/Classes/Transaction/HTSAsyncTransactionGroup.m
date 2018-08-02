//
//  HTSAsyncTransactionGroup.m
//  TestForAsyncLayer
//
//  Created by 李应鹏 on 2017/10/29.
//  Copyright © 2017年 李应鹏. All rights reserved.
//

#import "HTSAsyncTransactionGroup.h"
#import "HTSAsyncDefine.h"
#import "HTSAsyncTransactionContainer.h"
#import "HTSAsyncTransaction.h"

@implementation HTSAsyncTransactionGroup {
    NSHashTable<id<HTSAsyncTransactionContainer>> *_containers;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _containers = [NSHashTable hashTableWithOptions:NSHashTableObjectPointerPersonality];
    }
    return self;
}

+ (HTSAsyncTransactionGroup *)mainTransactionGroup
{
    HTSDisplayAssertMainThread();
    static HTSAsyncTransactionGroup *mainTransactionGroup;
    
    if (mainTransactionGroup == nil) {
        mainTransactionGroup = [[HTSAsyncTransactionGroup alloc] init];
        [self registerTransactionGroupAsMainRunloopObserver:mainTransactionGroup];
    }
    return mainTransactionGroup;
}

+ (void)registerTransactionGroupAsMainRunloopObserver:(HTSAsyncTransactionGroup *)transactionGroup
{
    HTSDisplayAssertMainThread();
    static CFRunLoopObserverRef observer;
    HTSDisplayAssert(observer == NULL, @"A HTSAsyncTransactionGroup should not be registered on the main runloop twice");
    // defer the commit of the transaction so we can add more during the current runloop iteration
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFOptionFlags activities = (kCFRunLoopBeforeWaiting | // before the run loop starts sleeping
                                kCFRunLoopExit);          // before exiting a runloop run
    
    observer = CFRunLoopObserverCreateWithHandler(NULL,        // allocator
                                                  activities,  // activities
                                                  YES,         // repeats
                                                  INT_MAX,     // order after CA transaction commits
                                                  ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
                                                      HTSDisplayAssertMainThread();
                                                      [transactionGroup commit];
                                                  });
    CFRunLoopAddObserver(runLoop, observer, kCFRunLoopCommonModes);
    CFRelease(observer);
}

- (void)addTransactionContainer:(id<HTSAsyncTransactionContainer>)container
{
    HTSDisplayAssertMainThread();
    HTSDisplayAssert(container != nil, @"No container");
    [_containers addObject:container];
}

- (void)commit {
    HTSDisplayAssertMainThread();
    if ([_containers count]) {
        NSHashTable *containersToCommit = _containers;
        _containers = [NSHashTable hashTableWithOptions:NSHashTableObjectPointerPersonality];
        for (id<HTSAsyncTransactionContainer> container in containersToCommit) {
            HTSAsyncTransaction *transaction = container.currentAsyncTransaction;
            container.currentAsyncTransaction = nil;
            [transaction commit];
        }
    }
}

+ (void)commit {
    [[HTSAsyncTransactionGroup mainTransactionGroup] commit];
}

@end
