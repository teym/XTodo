//
//  Member.m
//  TodoX
//
//  Created by teym on 13-5-23.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "Member.h"
#import "StdPch.h"

@implementation Member
+(Member*) defaultMember
{
    Member * member = [[self alloc] init];
    if(member)
    {
        member.iden = @"default@todo.com";
        member.name = @"default";
        member.email = member.iden;
    }
    return member;
}
+(NSDictionary *) toDict:(Member *)member
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:member.iden forKey:@"iden"];
    [dict setObject:member.name forKey:@"name"];
    [dict setObject:member.email forKey:@"email"];
    [dict setObject:member.owner.iden forKey:@"owner"];
    [dict setObject:member.belong.iden forKey:@"belong"];
    [dict setObject:[member.todos allKeys] forKey:@"todos"];
    return dict;
}
+(BOOL) fromDict:(Member*) member dict:(NSDictionary *) dict env:(NSDictionary*) groups
{
    member.iden = [dict objectForKey:@"iden"];
    member.name = [dict objectForKey:@"name"];
    member.email = [dict objectForKey:@"email"];
    member.owner = [groups objectForKey:[dict objectForKey:@"owner"]];
    member.belong = [groups objectForKey:[dict objectForKey:@"belong"]];
    NSSet * todoIdens = [NSSet setWithArray:[dict objectForKey:@"todos"]];
    NSMutableDictionary * todos = [NSMutableDictionary dictionary];
    [todos addEntriesFromDictionary:[member.owner.todos filter:^BOOL(id key, id value) {
        return [todoIdens containsObject:key];
    }]];
    [todos addEntriesFromDictionary:[member.belong.todos filter:^BOOL(id key, id value) {
        return [todoIdens containsObject:key];
    }]];
    member.todos = todos;
    return YES;
}
+(id) memberWithIden:(NSString *)iden
{
    Member* mem = [[self alloc] init];
    mem.iden = iden;
    return mem;
}

#pragma mark - process
-(ProcessInfo*) processForSomeTodos:(BoolDictionaryBlock) filter
{
    __block NSUInteger all = 0;
    __block float  done = 0.0f;
    [self.todos each:^(id key, id value) {
        Todo * todo = value;
        if(filter(key,value))
            done += (todo.process.doneCount/10),++all;
    }];
    return [ProcessInfo processWithAll:all done:done];
}
-(ProcessInfo*) processForLevel:(TodoLevel) level
{
    return [self processForSomeTodos:^BOOL(id key, id value) {
        return [(Todo*)value level] == level;
    }];
}
-(ProcessInfo*) emergencyProcess
{
    return [self processForLevel:Emergency];
}
-(ProcessInfo*) highlevelProcess
{
    return [self processForLevel:High];
}
-(ProcessInfo*) normallevelProcess
{
    return [self processForLevel:Normal];
}
-(ProcessInfo*) process
{
    return [self processForSomeTodos:^BOOL(id a,id b){return YES;}];
}
@end
