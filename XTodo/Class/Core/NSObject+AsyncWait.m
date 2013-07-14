//
//  NSObject+AsyncWait.m
//  TodoX
//
//  Created by teym on 13-5-28.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "NSObject+AsyncWait.h"

@implementation NSObject (AsyncWait)
-(id) asyncWait:(Action)act
{
    NSLog(@"asy wait");
    __block BOOL complate__ = NO;
    __block id  obj__ = nil;
    FinalAction fact = ^(id obj){
        complate__ = YES;
        obj__ = obj;
    };
    dispatch_async(dispatch_get_main_queue(), ^{
        act(fact);
    });
    while (!complate__) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
    return obj__;
}
@end
