//
//  AppDelegate.h
//  XTodo
//
//  Created by teym on 13-6-23.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController * navigation;

@end

#define TheAppDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define TheNavigation  (TheAppDelegate.navigation)