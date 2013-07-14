//
//  Runtime.h
//  TodoX
//
//  Created by teym on 13-5-23.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Member,Group;
typedef enum {NetUnknown = -1,NetNoReachable = 0,NetViaWWAN = 1,NetViaWiFi = 2} NetStatus;
typedef enum {RuntimeNetError,RuntimePasswdError} RuntimeErrorCodeType;
@interface Runtime : NSObject
@property (strong) Member *         myself;
@property (strong) NSString *       selfToken;
@property (assign) BOOL             isDefaultUsr;
@property (strong) NSDictionary*    groups;
@property (weak)   Group    *       group;
@property (readonly) BOOL           isFirstRun;
@property (readonly) BOOL           isUsrFirst;
@property (readonly) BOOL           needGuidance;

+(Runtime*) sharedInstance;
-(NSString *)documentPath;
-(NSError*) waitInitEnv;
-(NSError*) waitForLastUsrDataInit;
-(NSError*) waitForChangeToUsr:(NSString*) email token:(NSString*) token;
-(NetStatus) netStatus;
-(BOOL)online;
-(Group*) addGroup:(NSString *)name;
@end

#define TheRuntime  ([Runtime sharedInstance])
#define MySelf      (TheRuntime.myself)