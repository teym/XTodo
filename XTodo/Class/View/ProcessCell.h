//
//  ProcessCell.h
//  XTodo
//
//  Created by teym on 13-7-7.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ProcessCell : UITableViewCell
-(id) initWithReuseIdentifier:(NSString *)reuseIdentifier;
@property (assign,nonatomic) float process;
@property (assign,nonatomic) UIColor * processColor;
@end