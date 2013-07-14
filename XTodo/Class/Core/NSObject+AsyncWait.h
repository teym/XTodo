//
//  NSObject+AsyncWait.h
//  TodoX
//
//  Created by teym on 13-5-28.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FinalAction)(id);
typedef void (^Action)(FinalAction);

@interface NSObject (AsyncWait)
-(id) asyncWait:(Action) act;
@end
