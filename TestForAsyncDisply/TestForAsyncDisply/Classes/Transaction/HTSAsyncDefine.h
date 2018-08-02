//
//  HTSAsyncDefine.h
//  TestForAsyncLayer
//
//  Created by 李应鹏 on 2017/10/29.
//  Copyright © 2017年 李应鹏. All rights reserved.
//

#ifndef HTSAsyncDefine_h
#define HTSAsyncDefine_h

#define HTSDisplayAssertMainThread() NSAssert([NSThread isMainThread], @"This method must be called on the main thread")
#define HTSDisplayAssert(condition, desc, ...) NSAssert(condition, desc, ##__VA_ARGS__)

#endif /* HTSAsyncDefine_h */
