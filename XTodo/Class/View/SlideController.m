//
//  SlideController.m
//  XTodo
//
//  Created by teym on 13-6-30.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "SlideController.h"
#import "GroupListController.h"
#import "MemberController.h"
#import "TodoListController.h"

@implementation SlideController
+(SlideController*) configSlideWithMenu:(UIViewController*) menu content:(UIViewController*)content
{
    SlideController * slide = [[self alloc] initWithMenuViewController:menu andContentViewController:content];
    slide.slideDirection = NVSlideMenuControllerSlideFromRightToLeft;
    slide.contentViewWidthWhenMenuIsOpen = 260;
    slide.autoAdjustMenuWidth = NO;
    slide.panGestureEnabled = NO;
    return slide;
}
+(SlideController*) slideControllForMemberGroups:(Member *)member
{
    MemberController * members = [[MemberController alloc] initWithStyle:UITableViewStylePlain];
    GroupListController * groups = [[GroupListController alloc] initWithNibName:@"GroupListController" bundle:nil];
    [members showAllMembers];
    return [self configSlideWithMenu:members content:groups];
}
+(SlideController*) slideControllForMemberTodos:(Member *)member group:(Group *)group
{
    MemberController * members = [[MemberController alloc] initWithStyle:UITableViewStylePlain];
    TodoListController * todos = [[TodoListController alloc] initWithNibName:@"TodoListController" bundle:nil];
    [members showMembersOfGroup:group];
    [todos showGroup:group forMember:member];
    return [self configSlideWithMenu:members content:todos];
}
@end
