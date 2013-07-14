//
//  Runtime.m
//  TodoX
//
//  Created by teym on 13-5-23.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "Runtime.h"
#import "StdPch.h"

@interface Runtime ()
@property (retain) NSMutableDictionary * env;
@end
static const NSString * LastUsrKey = @"last_usr";
static const NSString * CurGroupKey = @"cur_group";
static const NSString * GroupsKey = @"groups";
@implementation Runtime
+(Runtime*)sharedInstance
{
    static Runtime *_sharedRun = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRun = [[Runtime alloc] init];
    });
    return _sharedRun;
}
-(NSString *) documentPath
{
    static NSString * path = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                 objectAtIndex:0] copy];
    });
    return path;
}
-(NetStatus) netStatus
{
    AFNetworkReachabilityStatus status = [[TodoXNetClient sharedClient] networkReachabilityStatus];
    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWWAN:
            return NetViaWWAN;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return NetViaWiFi;
        case AFNetworkReachabilityStatusNotReachable:
            return NetNoReachable;
        default:
            break;
    }
    return NetUnknown;
}
-(BOOL) online
{
    NetStatus status = [self netStatus];
    return status == NetViaWiFi || status == NetViaWWAN;
}
-(NSString *) envPath
{
    return [[self documentPath] stringByAppendingPathComponent:@"evn"];
}
-(void) saveEnv
{
    [self.env writeToFile:[self envPath] atomically:YES];
}
-(void) initEnv:(FinalAction) final
{
    self.env = [NSMutableDictionary dictionaryWithContentsOfFile:[self envPath]];
    if(!self.env)
        _isFirstRun = YES;
    self.env = [NSMutableDictionary dictionary];
    [self saveEnv];
    //test
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        final(nil);
    });
    //final(nil);
}
-(NSString *) getMySavePath
{
    return [[self documentPath] stringByAppendingPathComponent:self.myself.email];
}
-(NSString *) getMyDataPath
{
    return [[self getMySavePath] stringByAppendingPathComponent:@"data"];
}
-(void) initUsrData
{
    //load data
    //update data
    //marge data
    //sync data
    [[NSFileManager defaultManager] createDirectoryAtPath:[self getMySavePath] withIntermediateDirectories:YES attributes:nil error:nil];
    _isUsrFirst = ![[NSFileManager defaultManager] fileExistsAtPath:[self getMyDataPath]];
    if(!self.isUsrFirst)
    {
        [self loadMyData];
    }
    if(!self.isDefaultUsr)
    {
        NSError *err = [self updateMyData];
        assert(err);
    }
}
-(NSError *) updateMyData
{
    return nil;
}
-(NSError *) syncMyData
{
    return nil;
}
-(void) loadMyData
{
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:[self getMyDataPath]];
    NSDictionary * groupsDict = [dict objectForKey:GroupsKey];
    self.groups =[NSMutableDictionary dictionaryWithDictionary:[groupsDict map:^id(id key, id obj) {
        return [Group groupWithIden:key];
    }]];
    [groupsDict each:^(id key, id value) {
        [Group fromDict:[self.groups objectForKey:key] dict:value env:self.groups];
    }];
    self.group = [self.groups objectForKey:[dict objectForKey:CurGroupKey]];
}
-(void) saveUsrData:(NSString *)path
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObject:self.group.iden forKey:CurGroupKey];
    NSDictionary * groupsDict = [self.groups map:^id(id key, id obj) {
        return [Group toDict:obj];
    }];
    [dict setObject:groupsDict forKey:GroupsKey];
    [dict writeToFile:path atomically:YES];
}
-(void) getGroup:(NSString *) groupIden user:(NSString*) userIden final:(FinalAction) final
{
    [Interface group:groupIden user:userIden
             success:^(id JSON) {
        //pase data
                 final(nil);
    }
             failure:^(NSError *error, id JSON) {
                 final(error);
    }];
}
-(id) getAutoLoginUser
{
    NSString * theLast = [self.env objectForKey:LastUsrKey];
    if(!theLast)
        return nil;
    return [self.env objectForKey:theLast];
}
-(void) login:(NSString *)email token:(NSString*)token final:(FinalAction) final
{
    [Interface login:email token:token
             success:^(id JSON) {
                 [self.env setObject:email forKey:LastUsrKey];
                 [self.env setObject:token forKey:email];
                 [self saveEnv];
                 NSString * userIden = [JSON objectForKey:@"iden"];
                 self.myself = [Member memberWithIden:userIden];
             }
             failure:^(NSError *error, id JSON) {
                 final(error);
             }];
}
-(NSError *) waitInitEnv
{
    return [self asyncWait:^(FinalAction act) {
        [self initEnv:act];
    }];
}
-(NSError *) waitForLastUsrDataInit
{
    id user = [self getAutoLoginUser];
    if(user)
    {
        NSString * email = [user valueForKey:@"email"];
        NSString * token = [user valueForKey:@"token"];
        NSError * err = [self asyncWait:^(FinalAction act) {
            [self login:email token:token final:act];
        }];
        if(err) return err;
    }
    else
    {
        self.myself = [Member defaultMember];
        _needGuidance = YES;
        _isDefaultUsr = YES;
        
        //test
        Group * group = [self addGroup:@"firstGroup"];
        self.group = group;
        Todo * todo = [group member:MySelf createTodoForMember:MySelf];
        todo.title = @"first todo";
        todo.todoDescription = @"do nothing";
        todo.level = Normal;
        [todo upToProcess:5];
        //
        for (int i = 0; i<5; ++i) {
            [self addGroup:[NSString stringWithFormat:@"%d test group",i]];
        }
        //test
    }
    [self initUsrData];
    return nil;
}
-(NSError *) waitForChangeToUsr:(NSString *)email token:(NSString *)token
{
    return [self asyncWait:^(FinalAction act) {
        [self login:email token:token final:act];
    }];
}
-(Group*) addGroup:(NSString *)name
{
    NSString * iden = [NSString stringWithFormat:@"%@.%@.%f",self.myself.iden,name,[[NSDate date] timeIntervalSince1970]];
    Group * group = [Group groupWithIden:iden];
    group.name = name;
    if(!self.groups)
        self.groups = [NSMutableDictionary dictionary];
    assert([self.groups isKindOfClass:[NSMutableDictionary class]]);
    [(NSMutableDictionary*)self.groups setObject:group forKey:iden];
    return group;
}
@end
