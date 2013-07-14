//
//  MemberController.h
//  XTodo
//
//  Created by teym on 13-6-30.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Group,Member;
@interface MemberController : UITableViewController
-(void) showMembersOfGroup:(Group*) group;
-(void) showAllMembers;
@end
