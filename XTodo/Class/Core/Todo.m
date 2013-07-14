//
//  Todo.m
//  TodoX
//
//  Created by teym on 13-5-23.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "Todo.h"
#import "StdPch.h"

@interface Todo ()
@property (assign) NSUInteger processInt;
@end

@implementation Todo
+(Todo*) defaultTodoFor:(Member *)member group:(Group *)group
{
    Todo * todo = [[self alloc] init];
    if(todo)
    {
        todo.iden = @"default";
        todo.title = @"default";
        todo.todoDescription = @"default";
        todo.creater = member;
        todo.owner = member;
        todo.level = Normal;
        todo.group = group;
        todo.processInt = 0;
    }
    return todo;
}
+(NSDictionary *) toDict:(Todo *)todo
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:todo.iden forKey:@"iden"];
    [dict setObject:todo.title forKey:@"title"];
    [dict setObject:todo.todoDescription forKey:@"todoDescription"];
    [dict setObject:todo.creater.iden forKey:@"creater"];
    [dict setObject:todo.owner.iden forKey:@"owner"];
    [dict setObject:[NSNumber numberWithInt:todo.level] forKey:@"level"];
    if(todo.parent)
        [dict setObject:todo.parent.iden forKey:@"parent"];
    if(todo.children && todo.children.count > 0)
    {
        NSArray * childs = [todo.children map:^id(id obj) {
            return [obj iden];
        }];
        [dict setObject:childs forKey:@"children"];
    }
    [dict setObject:todo.group.iden forKey:@"group"];
    [dict setObject:[NSNumber numberWithInteger:todo.processInt] forKey:@"process"];
    return dict;
}
+(BOOL) fromDict:(Todo*) todo dict:(NSDictionary *) dict env:(NSDictionary*) groups
{
    todo.iden = [dict objectForKey:@"iden"];
    todo.title = [dict objectForKey:@"title"];
    todo.todoDescription = [dict objectForKey:@"todoDescription"];
    todo.group = [groups objectForKey:[dict objectForKey:@"group"]];
    todo.creater = [[todo.group members] objectForKey:[dict objectForKey:@"creater"]];
    todo.owner = [[todo.group members] objectForKey:[dict objectForKey:@"owner"]];
    todo.level = [[dict objectForKey:@"level"] intValue];
    todo.parent = [[todo.group todos] objectForKey:[dict objectForKey:@"parent"]];
    NSArray * childs = [dict objectForKey:@"children"];
    todo.children = [NSMutableArray arrayWithCapacity:[childs count]];
    for (id key in childs) {
        [(NSMutableArray*)todo.children addObject:[todo.group.todos objectForKey:key]];
    }
    todo.processInt = [[dict objectForKey:@"process"] integerValue];
    return YES;
}
+(id) todoWithIden:(NSString *)iden
{
    Todo* todo = [[self alloc] init];
    todo.iden = iden;
    return todo;
}
#pragma mark --
-(ProcessInfo*) process
{
    return [ProcessInfo processWithAll:10 done:self.processInt];
}
-(void) upToProcess:(NSInteger)process
{
    self.processInt = MIN(process,10);
    if(self.processInt == 10)
    {
        [self.children each:^(id obj) {
            [(Todo*)obj upToProcess:10];
        }];
    }
}
-(Todo*) split
{
    Todo * todo = [self.group member:MySelf createTodoForMember:MySelf];
    todo.parent = self;
    if(!self.children)
        self.children = [NSMutableArray array];
    assert([self.children isKindOfClass:[NSMutableArray class]]);
    [(NSMutableArray*)self.children addObject:todo];
    return todo;
}
@end
