//
//  TodoListController.h
//  TodoX
//
//  Created by teym on 13-6-10.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Group,Member;
@interface TodoListController : UITableViewController
-(void) showGroup:(Group *)group forMember:(Member *) member;
@end
