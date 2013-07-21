//
//  API.m
//  XTodo
//
//  Created by teym on 13-7-22.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "API.h"

@implementation API
+(Member*) registerUser:(NSString *)email password:(NSString *)pass name:(NSString *)name error:(NSError *__autoreleasing *)error
{
   
    return nil;
}
+(Member*) login:(NSString *)email password:(NSString *)pass error:(NSError *__autoreleasing *)error
{
    return nil;
}
+(void) groupInfo:(NSString *)groupId final:(void (^)(Group *, NSError *))final
{
    
}
+(void) addGroup:(Group *)group final:(void (^)(NSError *))final
{
    
}
+(void) addTodo:(Todo *)todo final:(void (^)(NSError *))final
{
    
}
+(void) updateTodo:(Todo *)todo final:(void (^)(NSError *))final
{
    
}
@end
