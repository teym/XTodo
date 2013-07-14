//
//  SlideController.h
//  XTodo
//
//  Created by teym on 13-6-30.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <NVSlideMenuController.h>
@class Member,Group;
@interface SlideController : NVSlideMenuController
+(SlideController*) slideControllForMemberGroups:(Member*)member;
+(SlideController*) slideControllForMemberTodos:(Member *)member group:(Group*) group;
@end
