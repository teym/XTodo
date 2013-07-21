//
//  ProcessCell.m
//  XTodo
//
//  Created by teym on 13-7-7.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "ProcessCell.h"
#import "StdPch.h"

@interface ProcessCell ()
@property (nonatomic,weak) UIView * processView;
@end

@implementation ProcessCell

-(id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.process = 0.0f;
        UIView * processView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:processView];
        self.processView = processView;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = self.contentView.bounds;
    rect.size.width *= self.process;
    self.processView.frame = rect;
}
-(void) setProcess:(float)process
{
    _process = process;
    CGRect rect = self.contentView.bounds;
    rect.size.width *= _process;
    LogOut(@"cell setprocess:%f (%f,%f)",process,rect.size.width,rect.size.height);
    [UIView beginAnimations:@"cell_process" context:NULL];
    //[UIView setAnimationDuration:0.5];
    self.processView.frame = rect;
    [UIView commitAnimations];
}
-(void) setProcessColor:(UIColor *)processColor
{
    self.processView.backgroundColor = processColor;
}
@end
