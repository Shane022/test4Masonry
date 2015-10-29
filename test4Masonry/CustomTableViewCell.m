//
//  CustomTableViewCell.m
//  test4Masonry
//
//  Created by new on 15-10-29.
//  Copyright (c) 2015年 new. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "Masonry.h"

@implementation CustomTableViewCell

@synthesize titleLabel;
@synthesize subtitleLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
        
        [self setupConstraint];
    }
    return self;
}

- (void)setupView {
    
    
    // 标题
    CGFloat preferredWidth = [UIScreen mainScreen].bounds.size.width - 75;
    UILabel *title = [[UILabel alloc] init];
    title.numberOfLines = 0;
    title.preferredMaxLayoutWidth = preferredWidth;
    title.textColor = [UIColor grayColor];
    [self.contentView addSubview:title];
    titleLabel = title;
    // 内容
    UILabel *subtitle = [[UILabel alloc] init];
    subtitle.numberOfLines = 3;
    subtitle.preferredMaxLayoutWidth = preferredWidth;
    [self.contentView addSubview:subtitle];
    subtitleLabel = subtitle;
}

- (void)setupConstraint {
    //title的顶部距离父视图20.0f, title的右边距离父视图15.0f
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(20.0f).with.priority(751);
        make.right.equalTo(self.contentView).with.offset(-15.0f);
    }];
    //subtitle的顶部与title的底部相距15.0f, subtitle的左边等于title的左边, subtitle的右边等于title的右边, subtitle的底部距离父视图15.0f
    [subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).with.offset(15.0f);
        make.right.equalTo(titleLabel);
        make.bottom.equalTo(self.contentView).with.offset(-15.0f).with.priority(749);
        make.left.equalTo(titleLabel);
    }];
}

@end
