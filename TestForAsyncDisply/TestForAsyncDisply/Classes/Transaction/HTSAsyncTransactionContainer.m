//
//  HTSAsyncTransactionContainer.m
//  TestForAsyncLayer
//
//  Created by 李应鹏 on 2017/10/29.
//  Copyright © 2017年 李应鹏. All rights reserved.
//

#import "HTSAsyncTransactionContainer.h"
#import "HTSAsyncTransaction.h"
#import "HTSAsyncTransactionGroup.h"
#import <objc/runtime.h>

static const char *HTSDisplayAssociatedTransactionsKey = "HTSAssociatedTransactions";
static const char *HTSDisplayAssociatedCurrentTransactionKey = "HTSAssociatedCurrentTransaction";
static const char *HTSAsyncTransactionIsContainerKey = "HTSTransactionIsContainer";

@implementation CALayer(HTSAsyncTransactionContainer)

- (NSHashTable *)asyncLayerTransactions {
    return objc_getAssociatedObject(self, HTSDisplayAssociatedTransactionsKey);
}

- (void)setAsyncLayerTransactions:(NSHashTable * _Nullable)asyncLayerTransactions {
    objc_setAssociatedObject(self, HTSDisplayAssociatedTransactionsKey, asyncLayerTransactions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isAsyncContainer {
    CFBooleanRef isContainerBool = (__bridge CFBooleanRef)objc_getAssociatedObject(self, HTSAsyncTransactionIsContainerKey);
    BOOL isContainer = (isContainerBool == kCFBooleanTrue);
    return isContainer;
}

- (void)setIsAsyncContainer:(BOOL)isAsyncContainer {
    objc_setAssociatedObject(self, HTSAsyncTransactionIsContainerKey, (id)(isAsyncContainer ? kCFBooleanTrue : kCFBooleanFalse), OBJC_ASSOCIATION_ASSIGN);
}

- (HTSAsyncTransaction *)currentAsyncTransaction {
    return objc_getAssociatedObject(self, HTSDisplayAssociatedCurrentTransactionKey);
}

- (void)setCurrentAsyncTransaction:(HTSAsyncTransaction *)currentAsyncTransaction {
    objc_setAssociatedObject(self, HTSDisplayAssociatedCurrentTransactionKey, currentAsyncTransaction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)parentTransactionContainer {
    CALayer *containerLayer = self;
    while (containerLayer && !containerLayer.isAsyncContainer) {
        containerLayer = containerLayer.superlayer;
    }
    return containerLayer;
}

- (void)cancelAsyncTransactions {
    HTSAsyncTransaction *currentTransaction = self.currentAsyncTransaction;
    [currentTransaction commit];
    self.currentAsyncTransaction = nil;
    for (HTSAsyncTransaction *transaction in [self.asyncLayerTransactions copy]) {
        [transaction cancel];
    }
}

- (HTSAsyncTransaction *)asyncTransaction {
    HTSAsyncTransaction *transaction = [self currentAsyncTransaction];
    if (!transaction) {
        NSHashTable *transactions = self.asyncLayerTransactions;
        if (transactions == nil) {
            transactions = [NSHashTable hashTableWithOptions:NSHashTableObjectPointerPersonality];
            self.asyncLayerTransactions = transactions;
        }
        __weak CALayer *weakSelf = self;
        transaction = [[HTSAsyncTransaction alloc] initWithCompletionBlock:^(HTSAsyncTransaction *completedTransaction, BOOL cancelled) {
            __strong CALayer *self = weakSelf;
            if (self == nil) {
                return;
            }
            [transactions removeObject:completedTransaction];
        }];
        [transactions addObject:transaction];
        self.currentAsyncTransaction = transaction;
    }
    [[HTSAsyncTransactionGroup mainTransactionGroup] addTransactionContainer:self];
    return transaction;
}

@end
