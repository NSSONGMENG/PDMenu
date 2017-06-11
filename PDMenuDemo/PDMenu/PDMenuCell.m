//
//  PDMenuCell.m
//  Demo
//
//  Created by songmeng on 17/6/11.
//  Copyright © 2017年 songmeng. All rights reserved.
//

#import "PDMenuCell.h"

@interface PDMenuCell ()

@property (nonatomic, strong) UILabel   * titleLab;
@property (nonatomic, strong) UIView    * btomLine;

@end

@implementation PDMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubviews];
    }
    
    return self;
}

- (void)createSubviews
{
    _titleLab = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLab];
    
    _btomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
    _btomLine.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_btomLine];
}

#pragma mark -
#pragma mark - setter

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLab.text = title;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    _titleLab.font = font;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _titleLab.frame = self.bounds;
    _btomLine.frame = CGRectMake(0, frame.size.height - 1, frame.size.width, 1);
}


@end
