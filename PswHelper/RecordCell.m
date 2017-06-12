//
//  RecordCell.m
//  PswHelper
//
//  Created by Merlin on 2017/6/12.
//  Copyright © 2017年 lq. All rights reserved.
//

#import "RecordCell.h"
#import "Masonry.h"

@implementation RecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setRecord:(Record *)record
{
    _record = record;
    self.titleLabel.text = [NSString stringWithFormat:@"title: %@",record.title];
    self.usernameLabel.text = [NSString stringWithFormat:@"username: %@",record.username];;
    self.pswLabel.text = [NSString stringWithFormat:@"psw: %@",record.psw];;
    self.remarkLabel.text = [NSString stringWithFormat:@"remark: \n%@",record.remark];;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self addSubview:_titleLabel];
        
        _titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(5);
            make.height.mas_equalTo(20);
        }];
    }
    return _titleLabel;
}
- (UILabel *)usernameLabel
{
    if (!_usernameLabel) {
        _usernameLabel = [[UILabel alloc]init];
        [self addSubview:_usernameLabel];
        
        _usernameLabel.font = [UIFont fontWithName:@"Arial" size:15];
        _usernameLabel.textAlignment = NSTextAlignmentLeft;
        [_usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).mas_equalTo(5);
            make.left.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
        
    }
    return _usernameLabel;
}
- (UILabel *)pswLabel
{
    if (!_pswLabel) {
        _pswLabel = [[UILabel alloc]init];
        [self addSubview:_pswLabel];
        
        _pswLabel.font = [UIFont fontWithName:@"Arial" size:15];
        _pswLabel.textAlignment = NSTextAlignmentRight;
        [_pswLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_usernameLabel);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(_usernameLabel);
        }];
    }
    return _pswLabel;
}
- (UILabel *)remarkLabel
{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc]init];
        [self addSubview:_remarkLabel];
        
        _remarkLabel.font = [UIFont fontWithName:@"Arial" size:15];
        _remarkLabel.textAlignment = NSTextAlignmentLeft;
        _remarkLabel.numberOfLines = 0;
        [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.equalTo(_usernameLabel.mas_bottom).mas_equalTo(5);
        }];
    }
    return _remarkLabel;
}

@end
