//
//  GroupCell.h
//  XTodo
//
//  Created by teym on 13-6-30.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupCell : UITableViewCell
@property (strong,nonatomic) UIProgressView * process;
-(id) initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
