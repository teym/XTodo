//
//  NetService.m
//  XTodo
//
//  Created by teym on 13-7-21.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "NetService.h"
#import "util.h"
#import <AFNetworking/AFNetworking.h>

@implementation NetService
+(NSURL *) baseUrl{
    static NSString * baseUrlStr = @"http://127.0.0.1/todo";
    return [NSURL URLWithString:baseUrlStr];
}
+(AFHTTPClient*) baseHttpClient{
    static AFHTTPClient * client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[AFHTTPClient alloc] initWithBaseURL:[self baseUrl]];
        [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    });
    return client;
}
+(void) startRequestWithPath:(NSString*)path success:(void(^)(id)) success failue:(void(^)(NSError*)) failue
{
    NSURL * url = [NSURL URLWithString:path relativeToURL:[self baseUrl]];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f];
    AFJSONRequestOperation * operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        [self handle:url responds:response data:JSON success:success failue:failue];
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        [self handle:url responds:response error:error faillue:failue];
                                                    }];
    [[self baseHttpClient] enqueueHTTPRequestOperation:operation];
}
+(void) handle:(NSURL*) url responds:(NSHTTPURLResponse*)respond data:(id)json success:(void(^)(id)) success failue:(void(^)(NSError*)) failue
{
    LogOut(@"reqeust:%@ respond:%@",url,json);
    BLOCK_SAFE_RUN(success,json);
}
+(void) handle:(NSURL*)url responds:(NSHTTPURLResponse*)respond error:(NSError*) error faillue:(void(^)(NSError*)) failue
{
    LogOut(@"request:%@ fail:%@",url,error);
    BLOCK_SAFE_RUN(failue,error);
}
@end
