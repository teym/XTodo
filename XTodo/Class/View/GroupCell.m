//
//  GroupCell.m
//  XTodo
//
//  Created by teym on 13-6-30.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "GroupCell.h"

@implementation GroupCell
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.process = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [self.contentView addSubview:self.process];
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
    CGFloat hight = rect.size.height*0.6;
    self.textLabel.frame = CGRectMake(0, 0, rect.size.width, hight);
    self.process.frame = CGRectMake(0, hight, rect.size.width, rect.size.height - hight);
}

@end
