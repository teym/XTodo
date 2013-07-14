//
//  ProcessInfo.m
//  XTodo
//
//  Created by teym on 13-6-23.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "ProcessInfo.h"

@implementation ProcessInfo
+(ProcessInfo*) processWithAll:(NSUInteger)all done:(float)done
{
    return [[self alloc] initWithAll:all done:done];
}
-(id) initWithAll:(NSUInteger)all done:(float)done
{
    self = [super init];
    if(self)
    {
        _allCount = all;
        _doneCount = done;
        _process = (all == 0) ? 1.0f : (done/all);
    }
    return self;
}
-(NSString*) description
{
    return [NSString stringWithFormat:@"%1f/%u",self.doneCount,self.allCount];
}
@end
