//
//  Group.h
//  TodoX
//
//  Created by teym on 13-5-23.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProcessInfo.h"
@class Member,Todo;
@interface Group : NSObject
@property (strong) NSString *       iden;
@property (strong) NSString *       name;
@property (strong) NSString *       image;
@property (weak)   Member *         owner;
@property (strong) NSDictionary *   members;
@property (strong) NSDictionary *   todos;
@property (strong) NSDate *         date;
+(Group*) defaultGroupFor:(Member*) member;
+(NSDictionary*) toDict:(Group *) group;
+(BOOL) fromDict:(Group *)group dict:(NSDictionary *) dict env:(NSDictionary *) env;
+(id) groupWithIden:(NSString *) iden;

-(Todo*) member:(Member*)from createTodoForMember:(Member *)mem;
-(void) removeTodo:(Todo*)todo forMember:(Member *)mem;
-(ProcessInfo*)process;
-(ProcessInfo*)processForMember:(Member*)mem;
@end
