//
//  MyClass.m
//  TestForPrivateCategary
//
//  Created by 李应鹏 on 2018/5/14.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "MyClass.h"
#import "MyClass+Private.h"

@implementation MyClass

- (void)wrapperFunc {
    [self testFunc1];
}

- (void)testFunc1 {
    NSLog(@"this is super class");
}

@end
