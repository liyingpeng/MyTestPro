//
//  HTSAsyncLayer.m
//  HTSLiveRoomSDK
//
//  Created by 李应鹏 on 2017/10/23.
//

#import "HTSAsyncLayer.h"
#import "HTSAsyncTransaction.h"
#import "HTSAsyncDefine.h"
#import "HTSAsyncTransactionContainer.h"
#import <libkern/OSAtomic.h>

#define CHECK_CANCELLED_AND_RETURN_NIL(expr)                      if (isCancelledBlock()) { \
expr; \
return nil; \
} \

typedef BOOL(^htsasynclayer_iscancelled_block_t)(void);

@implementation HTSAsyncLayerDisplayTask
@end

@implementation HTSAsyncLayer

#pragma mark - Override

+ (id)defaultValueForKey:(NSString *)key {
    if ([key isEqualToString:@"displaysAsynchronously"]) {
        return @(YES);
    } else {
        return [super defaultValueForKey:key];
    }
}

- (instancetype)init {
    self = [super init];
    static CGFloat scale; //global
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    self.contentsScale = scale;
    _displaysAsynchronously = YES;
    return self;
}

- (void)dealloc {
    [self increase];
}

- (void)setNeedsDisplay {
    [self _cancelAsyncDisplay];
    [super setNeedsDisplay];
}

- (void)display {
    super.contents = super.contents;
    [self _displayAsync:_displaysAsynchronously];
}

#pragma mark - Private

- (void)_displayAsync:(BOOL)async {
    __strong id<HTSAsyncLayerDelegate> delegate = self.delegate;
    HTSAsyncLayerDisplayTask *task = [delegate newAsyncDisplayTask];
    if (!task.display) {
        if (task.willDisplay) task.willDisplay(self);
        self.contents = nil;
        if (task.didDisplay) task.didDisplay(self, YES);
        return;
    }
    
    hts_async_transaction_operation_completion_block_t completionBlock = ^(id<NSObject> value, BOOL canceled) {
        HTSDisplayAssertMainThread();
        if (!canceled) {
            UIImage *image = (UIImage *)value;
            self.contents = (id)image.CGImage;
            if (task.didDisplay) task.didDisplay(self, YES);
        }
    };
    
    htsasynclayer_iscancelled_block_t isCancelledBlock = nil;
    if (async) {
        int32_t value = self.value;
        __weak HTSAsyncLayer *weakSelf = self;
        isCancelledBlock = ^BOOL() {
            __strong HTSAsyncLayer *self = weakSelf;
            BOOL cancelled = self == nil || (value != self.value);
            return cancelled;
        };
    } else {
        isCancelledBlock = ^BOOL{
            return NO;
        };
    }
    
    CGRect bounds = self.bounds;
    __weak HTSAsyncLayer *weakSelf = self;
    hts_async_transaction_operation_block_t displayBlock = ^id {
        __strong HTSAsyncLayer *self = weakSelf;
        if (!self) return nil;
        CHECK_CANCELLED_AND_RETURN_NIL(if (task.didDisplay) task.didDisplay(self, NO));
        
        BOOL opaque = self.opaque;
        UIGraphicsBeginImageContextWithOptions(bounds.size, opaque, self.contentsScale);
        CHECK_CANCELLED_AND_RETURN_NIL(UIGraphicsEndImageContext());
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        task.display(context, bounds, isCancelledBlock);
        
        CHECK_CANCELLED_AND_RETURN_NIL(UIGraphicsEndImageContext());
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    };
    
    if (async) {
        if (task.willDisplay) task.willDisplay(self);
        self.isAsyncContainer = YES;
        CALayer *containerLayer = self.parentTransactionContainer;
        HTSAsyncTransaction *transaction = containerLayer.asyncTransaction;
        [transaction addOperationWithBlock:displayBlock completion:completionBlock];
    } else {
        if (task.willDisplay) task.willDisplay(self);
        UIImage *image = (UIImage *)displayBlock();
        self.contents = (id)image.CGImage;
        if (task.didDisplay) task.didDisplay(self, NO);
    }
}

- (void)_cancelAsyncDisplay {
    [self increase];
}

- (int32_t)increase {
    return OSAtomicIncrement32(&_value);
}

@end

