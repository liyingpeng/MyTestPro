//
//  HTSAsyncTransaction.m
//  TestForAsyncLayer
//
//  Created by 李应鹏 on 2017/10/29.
//  Copyright © 2017年 李应鹏. All rights reserved.
//

#import "HTSAsyncTransaction.h"
#import "HTSAsyncTransactionScheduler.h"
#import "HTSAsyncDefine.h"

@interface HTSAsyncTransactionOperation : NSObject
- (instancetype)initWithOperationCompletionBlock:(hts_async_transaction_operation_completion_block_t)operationCompletionBlock;
@property (nonatomic, copy) hts_async_transaction_operation_completion_block_t operationCompletionBlock;
@property (atomic, strong) id value;
@end

@implementation HTSAsyncTransactionOperation

- (instancetype)initWithOperationCompletionBlock:(hts_async_transaction_operation_completion_block_t)operationCompletionBlock
{
    if ((self = [super init])) {
        _operationCompletionBlock = operationCompletionBlock;
    }
    return self;
}

- (void)dealloc
{
    NSAssert(_operationCompletionBlock == nil, @"Should have been called and released before -dealloc");
}

- (void)callAndReleaseCompletionBlock:(BOOL)canceled;
{
    HTSDisplayAssertMainThread();
    if (_operationCompletionBlock) {
        _operationCompletionBlock(self.value, canceled);
        // Guarantee that _operationCompletionBlock is released on main thread
        _operationCompletionBlock = nil;
    }
}

@end

@interface HTSAsyncTransaction ()

@property(atomic) HTSAsyncTransactionState state;

@end

@implementation HTSAsyncTransaction {
    NSMutableArray<HTSAsyncTransactionOperation *> *_operations;
    HTSAsyncTransactionScheduler *_scheduler;
}

- (instancetype)initWithCompletionBlock:(hts_async_transaction_completion_block_t)completionBlock {
    if ((self = [self init])) {
        _completionBlock = completionBlock;
        self.state = HTSAsyncTransactionStateOpen;
    }
    return self;
}

- (void)dealloc {
    NSAssert(self.state != HTSAsyncTransactionStateOpen, @"Uncommitted AsyncTransactions are not allowed");
}

- (void)addOperationWithBlock:(hts_async_transaction_operation_block_t)block
                        completion:(hts_async_transaction_operation_completion_block_t)completion {
    HTSDisplayAssertMainThread();
    NSAssert(self.state == HTSAsyncTransactionStateOpen, @"You can only add operations to open transactions");
    
    [self _ensureTransactionData];
    
    HTSAsyncTransactionOperation *operation = [[HTSAsyncTransactionOperation alloc] initWithOperationCompletionBlock:completion];
    [_operations addObject:operation];
    [_scheduler scheduleWithBlock:^{
        if (self.state != HTSAsyncTransactionStateCanceled) {
            operation.value = block();
        }
    }];
}

- (void)commit {
    HTSDisplayAssertMainThread();
    NSAssert(self.state == HTSAsyncTransactionStateOpen, @"You cannot double-commit a transaction");
    self.state = HTSAsyncTransactionStateCommitted;
    if ([_operations count] == 0) {
        if (_completionBlock) {
            _completionBlock(self, NO);
        }
    } else {
        [_scheduler notify:dispatch_get_main_queue() action:^{
            [self completeTransaction];
        }];
    }
}

- (void)cancel {
    HTSDisplayAssertMainThread();
    NSAssert(self.state != HTSAsyncTransactionStateOpen, @"You can only cancel a committed or already-canceled transaction");
    self.state = HTSAsyncTransactionStateCanceled;
}

- (void)completeTransaction
{
    HTSDisplayAssertMainThread();
    HTSAsyncTransactionState state = self.state;
    if (state != HTSAsyncTransactionStateComplete) {
        BOOL isCanceled = (state == HTSAsyncTransactionStateCanceled);
        for (HTSAsyncTransactionOperation *operation in _operations) {
            [operation callAndReleaseCompletionBlock:isCanceled];
        }
        self.state = HTSAsyncTransactionStateComplete;
        if (_completionBlock) {
            _completionBlock(self, isCanceled);
        }
    }
}

#pragma mark Helper Methods

- (void)_ensureTransactionData
{
    if (_scheduler == NULL) {
        _scheduler = [HTSAsyncTransactionScheduler shareInstance];
    }
    if (_operations == nil) {
        _operations = [[NSMutableArray alloc] init];
    }
}

@end
