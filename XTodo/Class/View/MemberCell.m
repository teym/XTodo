//
//  MemberCell.m
//  XTodo
//
//  Created by teym on 13-6-30.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "MemberCell.h"

@implementation MemberCell
- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textAlignment = NSTextAlignmentNatural;
        self.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;    }
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
    CGRect rect = [self.contentView bounds];
    CGFloat size = MIN(rect.size.height*0.6,rect.size.width);
    CGFloat hight = rect.size.height*0.3;
    self.imageView.frame = CGRectMake((rect.size.width - size)/2, 0, size, size);
    self.textLabel.frame = CGRectMake(0, rect.size.height-hight, rect.size.width, hight);
}

@end
