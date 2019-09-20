//
//  ZWCollectionViewCell.m
//  scorollAD
//
//  Created by 张伟 on 2019/8/26.
//  Copyright © 2019 jyall. All rights reserved.
//

#import "ZWCollectionViewCell.h"

@interface ZWCollectionViewCell ()



@end

@implementation ZWCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI{
    
    [self addSubview:self.titleLabel];
    self.titleLabel.frame = self.bounds;
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.numberOfLines = 1;
        _titleLabel.text = @"";
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
@end
