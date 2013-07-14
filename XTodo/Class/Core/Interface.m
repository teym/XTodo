//
//  Interface.m
//  TodoX
//
//  Created by teym on 13-5-23.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "Interface.h"

static NSString * const TodoXNetClientBaseURLString = @"http://127.0.0.1:8080/";
@implementation TodoXNetClient
+ (TodoXNetClient *)sharedClient {
    static TodoXNetClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TodoXNetClient alloc] initWithBaseURL:[NSURL URLWithString:TodoXNetClientBaseURLString]];
    });
    return _sharedClient;
}
- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    return self;
}
@end

@implementation Interface
+(void) apiRequestUrl:(NSString*)url success:(void (^)(id))success failure:(void (^)(NSError *, id))failure
{
    [[TodoXNetClient sharedClient] getPath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error,nil);
    }];
}
+(void) login:(NSString *)email token:(NSString *)token success:(void (^)(id))success failure:(void (^)(NSError *, id))failure
{
    NSString * url = [NSString stringWithFormat:@""];
    [self apiRequestUrl:url success:success failure:failure];
}
+(void) regist:(NSString *)email token:(NSString *)token name:(NSString *)name success:(void (^)(id))success failure:(void (^)(NSError *, id))failure
{
    NSString * url = [NSString stringWithFormat:@""];
    [self apiRequestUrl:url success:success failure:failure];
}
+(void) group:(NSString *) groupIden user:(NSString *) userIden success:(void (^)(id JSON))success failure:(void (^)(NSError *error, id JSON))failure
{
    NSString * url = [NSString stringWithFormat:@""];
    [self apiRequestUrl:url success:success failure:failure];
}
+(void) imageWithUrl:(NSString *)url success:(void (^)(id))success failure:(void (^)(NSError *, id))failure
{
    //get cache
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [AFImageRequestOperation
     imageRequestOperationWithRequest:request
                                         imageProcessingBlock:nil
                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                success(image);
                                                      }
                            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                failure(nil,error);
                                }];
}
@end
