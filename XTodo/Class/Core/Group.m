//
//  Group.m
//  TodoX
//
//  Created by teym on 13-5-23.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "Group.h"
#import "StdPch.h"

@implementation Group
+(Group*) defaultGroupFor:(Member *)member
{
    Group * group = [[self alloc] init];
    if(group)
    {
        group.iden = @"default";
        group.name = @"default";
        group.owner = member;
        group.members = [NSDictionary dictionaryWithObject:member forKey:member.email];
    }
    return group;
}
+(NSDictionary *) toDict:(Group *)group
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:group.iden forKey:@"iden"];
    [dict setObject:group.name forKey:@"name"];
    [dict setObject:group.owner.iden forKey:@"owner"];
    NSDictionary * mems = [group.members map:^id(id key, id obj) {
        return [Member toDict:obj];
    }];
    [dict setObject:mems forKey:@"members"];
    NSDictionary * todos = [group.todos map:^id(id key, id obj) {
        return [Todo toDict:obj];
    }];
    [dict setObject:todos forKey:@"todos"];
    return dict;
}
+(BOOL) fromDict:(Group *)group dict:(NSDictionary *)dict env:(NSDictionary *) env
{
    group.iden = [dict objectForKey:@"iden"];
    group.name = [dict objectForKey:@"name"];
    NSDictionary * mems = [dict objectForKey:@"members"];
    NSDictionary * todos = [dict objectForKey:@"todos"];
    
    group.members =[mems map:^id(id key, id obj) {
        return [Member memberWithIden:key];
    }];
    group.todos = [todos map:^id(id key, id obj) {
        return [Todo todoWithIden:key];
    }];
    [mems each:^(id key, id value) {
        [Member fromDict:[group.members objectForKey:key] dict:value env:env];
    }];
    [todos each:^(id key, id value) {
        [Todo fromDict:[group.todos objectForKey:key] dict:value env:env];
    }];
    group.owner = [group.members objectForKey:[dict objectForKey:@"owner"]];
    return YES;
}
+(id) groupWithIden:(NSString *)iden
{
    Group * group = [[Group alloc] init];
    group.iden = iden;
    return group;
}
#pragma mark -- 
-(ProcessInfo*)process
{
    return nil;
}
-(ProcessInfo*)processForMember:(Member *)mem
{
    return nil;
}

-(Todo*) member:(Member *)from createTodoForMember:(Member *)mem
{
    NSString * iden = [NSString stringWithFormat:@"%@.%@.%f",self.iden,mem.iden,[[NSDate date] timeIntervalSince1970]];
    Todo * todo = [Todo todoWithIden:iden];
    todo.group = self;
    todo.creater = from;
    todo.owner = mem;
    if(!self.todos)
        self.todos = [NSMutableDictionary dictionary];
    if(!mem.todos)
        mem.todos = [NSMutableDictionary dictionary];
    [(NSMutableDictionary*)self.todos setObject:todo forKey:iden];
    [(NSMutableDictionary*)mem.todos setObject:todo forKey:iden];
    return todo;
}
-(void) removeTodo:(Todo *)todo forMember:(Member *)mem
{
    [todo.children each:^(id obj) {
        Todo* item = obj;
        [item.group removeTodo:item forMember:item.owner];
    }];
    [(NSMutableArray*)todo.parent.children removeObject:todo];
    [(NSMutableDictionary*)self.todos removeObjectForKey:todo.iden];
    [(NSMutableDictionary*)mem.todos removeObjectForKey:todo.iden];
}
@end
