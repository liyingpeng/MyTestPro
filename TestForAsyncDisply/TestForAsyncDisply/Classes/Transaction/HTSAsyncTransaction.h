//
//  HTSAsyncTransaction.h
//  TestForAsyncLayer
//
//  Created by 李应鹏 on 2017/10/29.
//  Copyright © 2017年 李应鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HTSAsyncTransaction;

typedef id<NSObject> _Nullable(^hts_async_transaction_operation_block_t)(void);
typedef void(^hts_async_transaction_completion_block_t)(HTSAsyncTransaction *completedTransaction, BOOL canceled);
typedef void(^hts_async_transaction_operation_completion_block_t)(id _Nullable value, BOOL canceled);
typedef void(^hts_async_transaction_complete_async_operation_block_t)(id _Nullable value);
typedef void(^hts_async_transaction_async_operation_block_t) (hts_async_transaction_complete_async_operation_block_t completeOperationBlock);

typedef NS_ENUM(NSUInteger, HTSAsyncTransactionState) {
    HTSAsyncTransactionStateOpen = 0,
    HTSAsyncTransactionStateCommitted,
    HTSAsyncTransactionStateCanceled,
    HTSAsyncTransactionStateComplete
};

@interface HTSAsyncTransaction : NSObject

- (instancetype)initWithCompletionBlock:(nullable hts_async_transaction_completion_block_t)completionBlock;

@property (nonatomic, readonly, copy, nullable) hts_async_transaction_completion_block_t completionBlock;

@property (readonly, assign) HTSAsyncTransactionState state;

- (void)addOperationWithBlock:(hts_async_transaction_operation_block_t)block
                        completion:(hts_async_transaction_operation_completion_block_t)completion;

- (void)cancel;

- (void)commit;

@end

NS_ASSUME_NONNULL_END

