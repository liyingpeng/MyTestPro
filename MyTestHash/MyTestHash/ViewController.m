//
//  ViewController.m
//  MyTestHash
//
//  Created by liyingpeng on 2019/4/26.
//  Copyright © 2019 liyingpeng. All rights reserved.
//

#import "ViewController.h"

@interface TestObject : NSObject <NSCopying>

@end

@implementation TestObject

- (id)copyWithZone:(NSZone *)zone {
    return self;
//    return [[self.class allocWithZone:zone] init];
}

//- (NSUInteger)hash {
//    return [super hash];
//}
//
//- (BOOL)isEqual:(id)object {
//    BOOL equal = [super isEqual:object];
//    return YES;
//}

@end

@interface TestString : NSMutableString

@end

@implementation TestString

- (id)copyWithZone:(NSZone *)zone {
    id res = [super copyWithZone:zone];
    BOOL equal = res == self;
    return res;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    id res = [super mutableCopyWithZone:zone];
    BOOL equal = res == self;
    return res;
}
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NSMutableDictionary
    NSMutableDictionary *dic = @{}.mutableCopy;
    
    TestObject *objKey = [TestObject new];
    TestString *stringKey = [TestString stringWithString:@"a"];

    [dic setObject:@1 forKey:stringKey]; // dictionary 方法，key可以使任意实现nscopying协议对象
    [dic setObject:@2 forKey:stringKey];
    
    [dic setValue:@1 forKey:@"key"]; // setvalue forkey 方法是KVC方式 key只能是字符串
}


@end
