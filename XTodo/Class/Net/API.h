//
//  API.h
//  XTodo
//
//  Created by teym on 13-7-22.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Member,Group,Todo;
@interface API : NSObject
+(Member*) registerUser:(NSString*)email password:(NSString*)pass name:(NSString*)name error:(NSError**) error;//sync
+(Member*) login:(NSString*)email password:(NSString*)pass error:(NSError**) error;//sync

+(void) groupInfo:(NSString*) groupId final:(void(^)(Group*,NSError*)) final;
+(void) addGroup:(Group*) group final:(void(^)(NSError*)) final;
+(void) addTodo:(Todo*) todo final:(void(^)(NSError*)) final;
+(void) updateTodo:(Todo*) todo final:(void(^)(NSError*)) final;
@end
