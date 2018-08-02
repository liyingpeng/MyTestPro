//
//  MySubClass.m
//  TestForPrivateCategary
//
//  Created by 李应鹏 on 2018/5/14.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "MySubClass.h"
#import "MyClass+Private.h"

@implementation MySubClass

- (void)testFunc1 {
    [super testFunc1];
    NSLog(@"this is subclass");
}

@end
