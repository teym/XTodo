//
//  NSObject+PropertyDict.h
//  TodoX
//
//  Created by teym on 13-5-23.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <Foundation/Foundation.h>

enum ObjState {Uninited,Updateing,Inited};
@interface NSObject (PropertyDict)
+ (NSDictionary *)classPropsFor:(Class)klass;
-(NSDictionary*) propertys;
@end
