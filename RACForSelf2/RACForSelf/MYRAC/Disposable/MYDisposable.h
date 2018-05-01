//
//  MYDisposable.h
//  RACForSelf
//
//  Created by 李应鹏 on 2018/3/28.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYDisposable : NSObject

@property (nonatomic, assign, getter=isDisposed, readonly) BOOL disposed;

+ (instancetype)disposableWithBlock:(void(^)(void))block;

- (void)dispose;

@end
