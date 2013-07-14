//
//  Member.h
//  TodoX
//
//  Created by teym on 13-5-23.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProcessInfo.h"
@class Group;
@interface Member : NSObject
@property (strong) NSString *       iden;
@property (strong) NSString *       name;
@property (strong) NSString *       image;
@property (strong) NSString *       email;
@property (weak)   Group *          owner;
@property (weak)   Group *          belong;
@property (strong) NSDictionary *   todos;
+(Member*) defaultMember;
+(NSDictionary *) toDict:(Member *) member;
+(BOOL) fromDict:(Member*) member dict:(NSDictionary *) dict env:(NSDictionary*) groups;
+(id) memberWithIden:(NSString*)iden;

-(ProcessInfo*) emergencyProcess;
-(ProcessInfo*) highlevelProcess;
-(ProcessInfo*) normallevelProcess;
-(ProcessInfo*) process;
@end
