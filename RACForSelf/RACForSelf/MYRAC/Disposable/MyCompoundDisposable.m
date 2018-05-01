//
//  MyCompoundDisposable.m
//  RACForSelf
//
//  Created by 李应鹏 on 2018/3/29.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "MyCompoundDisposable.h"


@interface MyCompoundDisposable () {
    NSMutableArray *_disposables;
    BOOL _disposed;
}
@end

@implementation MyCompoundDisposable

- (void)dealloc
{
    _disposables = nil;
}

- (BOOL)isDisposed {
    return _disposed;
}

- (instancetype)initWithDisposables:(NSArray *)otherDisposables
{
    self = [super init];
    if (self) {
        _disposables = otherDisposables.mutableCopy;
    }
    return self;
}

- (instancetype)initWithBlock:(void (^)(void))block {
    MYDisposable *disposable = [MYDisposable disposableWithBlock:block];
    return [self initWithDisposables:@[ disposable ]];
}

- (void)addDisposable:(MYDisposable *)disposable {
    if (!disposable || [disposable isDisposed]) return;
    if (_disposed) {
        [disposable dispose];
    } else {
        [_disposables addObject:disposable];
    }
}

- (void)remove:(MYDisposable *)disposable {
    if (!disposable) return;
    [_disposables removeObject:disposable];
}

- (void)dispose {
    _disposed = YES;
    [_disposables enumerateObjectsUsingBlock:^(MYDisposable *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj dispose];
    }];
}

@end
