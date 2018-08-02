//
//  HTSAsyncTransactionGroup.h
//  TestForAsyncLayer
//
//  Created by 李应鹏 on 2017/10/29.
//  Copyright © 2017年 李应鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HTSAsyncTransactionContainer;
@interface HTSAsyncTransactionGroup : NSObject

+ (HTSAsyncTransactionGroup *)mainTransactionGroup;
+ (void)commit;
- (void)addTransactionContainer:(id<HTSAsyncTransactionContainer>)container;

@end

NS_ASSUME_NONNULL_END
