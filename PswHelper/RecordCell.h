//
//  RecordCell.h
//  PswHelper
//
//  Created by Merlin on 2017/6/12.
//  Copyright © 2017年 lq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Record.h"

@interface RecordCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *pswLabel;
@property (nonatomic, strong) UILabel *remarkLabel;



@property (nonatomic, strong) Record *record;

@end
