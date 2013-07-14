//
//  ProcessInfo.h
//  XTodo
//
//  Created by teym on 13-6-23.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProcessInfo : NSObject
@property (readonly) float process;
@property (readonly) NSUInteger allCount;
@property (readonly) float doneCount;

+(ProcessInfo*) processWithAll:(NSUInteger) all done:(float)done;
@end
