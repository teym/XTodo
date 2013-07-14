//
//  Interface.h
//  TodoX
//
//  Created by teym on 13-5-23.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "AFNetworking.h"

@class AFJSONRequestOperation,Group,Member,Todo;
@interface Interface : NSObject
+(void) login:(NSString *) email token:(NSString *) token success:(void (^)(id JSON))success failure:(void (^)(NSError *error, id JSON))failure;
+(void) regist:(NSString *) email token:(NSString *) token name:(NSString *) name success:(void (^)(id JSON))success failure:(void (^)(NSError *error, id JSON))failure;
+(void) group:(NSString *) groupIden user:(NSString *) userIden success:(void (^)(id JSON))success failure:(void (^)(NSError *error, id JSON))failure;

+(void) imageWithUrl:(NSString*) url success:(void (^)(id JSON))success failure:(void (^)(NSError *error, id JSON))failure;
@end

@interface TodoXNetClient : AFHTTPClient
+(TodoXNetClient *) sharedClient;
@end