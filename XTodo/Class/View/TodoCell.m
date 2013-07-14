//
//  TodoCell.m
//  TodoX
//
//  Created by teym on 13-6-18.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "TodoCell.h"

@implementation TodoCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
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
    self.textLabel.frame = CGRectInset(rect, 5.0, 5.0);
}
@end
