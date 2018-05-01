//
//  ViewController.m
//  RACForSelf
//
//  Created by 李应鹏 on 2018/3/28.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import "MYSubscriber.h"
#import "MYSignal.h"
#import "MySubject.h"

@interface ViewController ()

@end

@interface ViewController ()
@property (nonatomic, strong) RACSubject *subject;
@property (nonatomic, strong) MySubject *mySubject;
@property (nonatomic, strong) RACDisposable *dis;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.dis = [[self test] subscribeNext:^(NSNumber * _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    RACSubject *subject = [RACSubject subject];
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@(0)];
//    [subject sendCompleted];
//
//    [self.mySubject subscibeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
//    [self.mySubject sendNext:@(1)];
//
//    [[self mySignal] subscibeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (RACSignal<NSNumber *> *)test {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@(0)];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"disposed");
        }];
    }];
}

- (RACSubject *)subject {
    if (!_subject) {
        _subject = [RACSubject subject];
    }
    return _subject;
}

- (MySubject *)mySubject {
    if (!_mySubject) {
        _mySubject = [MySubject subject];
    }
    return _mySubject;
}

- (MYSignal *)mySignal {
    return [MYSignal createSignal:^(MYSubscriber *subscriber) {
        [subscriber sendNext:@(0)];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
