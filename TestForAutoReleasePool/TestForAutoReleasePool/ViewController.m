//
//  ViewController.m
//  TestForAutoReleasePool
//
//  Created by liyingpeng on 2018/4/7.
//  Copyright © 2018年 liyingpeng. All rights reserved.
//

#import "ViewController.h"

@interface TEST : NSObject

- (void)registAction:(void(^)(id))action;
- (void)performAction:(id)info;

@property(nonatomic, copy) void(^action)(id);
@end
@implementation TEST

- (void)dealloc {
    
}

- (void)registAction:(void(^)(id))action {
    NSCParameterAssert(action != nil);
//    self.action = action;
    @autoreleasepool {
        
        action(nil);
        action = nil;
    }
}

- (void)performAction:(id)info {
    @autoreleasepool {
        
        self.action(info);
    }
}

@end

@interface ViewController ()
@property (nonatomic, weak) NSString *weak_String;
@property (nonatomic, weak) NSString *weak_StringAutorelease;
@property (nonatomic, strong) TEST *t;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TEST *t = [TEST new];
    [t registAction:^(id info) {
        NSLog(@"%p", info);
        NSLog(@"%p", self);
    }];
    
//    [t performAction:self];
    self.t = t;
    
//    @autoreleasepool {
//        [self createString];
//        NSLog(@"------in the autoreleasepool------");
//        NSLog(@"%@", self.weak_String);
//        NSLog(@"%@\n\n", self.weak_StringAutorelease);
//    }
//    NSLog(@"------in the main()------");
//    NSLog(@"%@", self.weak_String);
//    NSLog(@"%@", self.weak_StringAutorelease);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)createString {
    
    NSString *string = [[NSString alloc] initWithFormat:@"Hello, World!"];    // 创建常规对象
    NSString *stringAutorelease = [NSString stringWithFormat:@"Hello, World! Autorelease"]; // 创建autorelease对象
    
    self.weak_String = string;
    self.weak_StringAutorelease = stringAutorelease;
    
    NSLog(@"------in the createString()------");
    NSLog(@"%@", self.weak_String);
    NSLog(@"%@\n\n", self.weak_StringAutorelease);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
