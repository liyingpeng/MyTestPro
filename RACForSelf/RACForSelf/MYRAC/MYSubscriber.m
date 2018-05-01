//
//  MYSubscriber.m
//  RACForSelf
//
//  Created by 李应鹏 on 2018/3/28.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "MYSubscriber.h"

@interface MYSubscriber ()



@end

@implementation MYSubscriber

- (void)sendNext:(id)value {
    if (self.next) {
        self.next(value);
    }
}

@end
