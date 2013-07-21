//
//  NetService.h
//  XTodo
//
//  Created by teym on 13-7-21.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NetService : NSObject
+(void) startRequestWithPath:(NSString*)path success:(void(^)(id)) success failue:(void(^)(NSError*)) failue;
@end
