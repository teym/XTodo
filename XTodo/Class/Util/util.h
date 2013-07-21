//
//  util.h
//  XTodo
//
//  Created by teym on 13-6-23.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#ifndef XTodo_util_h
#define XTodo_util_h
#import <Foundation/Foundation.h>
#define	LogOut(format,...);      NSLog(@"[%s][%d]"format,__func__,__LINE__,##__VA_ARGS__);
#define BLOCK_SAFE_RUN(block, ...) (block ? block(__VA_ARGS__) : nil);
#endif
