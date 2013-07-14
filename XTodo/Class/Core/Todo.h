//
//  Todo.h
//  TodoX
//
//  Created by teym on 13-5-23.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProcessInfo.h"
@class Member,Group;
typedef enum {Emergency,High,Normal} TodoLevel;
@interface Todo : NSObject
@property (strong) NSString *       iden;
@property (strong) NSString *       title;
@property (strong) NSString *       todoDescription;
@property (weak)   Member *         creater;
@property (weak)   Member *         owner;
@property (assign) TodoLevel        level;
@property (weak)   Todo *           parent;
@property (strong) NSArray *        children;
@property (weak)   Group *          group;
+(Todo*) defaultTodoFor:(Member *)member group:(Group *) group;
+(NSDictionary *) toDict:(Todo *)todo;
+(BOOL) fromDict:(Todo*) todo dict:(NSDictionary *) dict env:(NSDictionary*) groups;
+(id) todoWithIden:(NSString*)iden;

-(ProcessInfo*) process;
-(Todo*) split;
-(void) upToProcess:(NSInteger) process;
@end
