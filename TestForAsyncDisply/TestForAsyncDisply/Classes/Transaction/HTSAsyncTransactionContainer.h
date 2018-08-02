//
//  HTSAsyncTransactionContainer.h
//  TestForAsyncLayer
//
//  Created by 李应鹏 on 2017/10/29.
//  Copyright © 2017年 李应鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HTSAsyncTransaction;

@protocol HTSAsyncTransactionContainer

- (void)cancelAsyncTransactions;

@property (nonatomic, assign) BOOL isAsyncContainer;
@property (nonatomic, strong, nullable) HTSAsyncTransaction *currentAsyncTransaction;

@end

@interface CALayer(HTSAsyncTransactionContainer) <HTSAsyncTransactionContainer>

@property (nonatomic, readonly, strong, nullable) NSHashTable *asyncLayerTransactions;

@property (nonatomic, readonly, strong, nullable) HTSAsyncTransaction *asyncTransaction;

@property (nonatomic, readonly, strong, nullable) CALayer *parentTransactionContainer;

@end

NS_ASSUME_NONNULL_END


