//
//  TipLabel.m
//  PswHelper
//
//  Created by Merlin on 2017/6/12.
//  Copyright © 2017年 lq. All rights reserved.
//

#import "TipLabel.h"
#import "masonry.h"

TipLabel *errorLabel;

@implementation TipLabel

+ (void)showErrorMsg:(NSString *)msg superView:(UIView *)view
{
    if (errorLabel) {
        return;
    }
    CGRect rect = [msg boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    errorLabel = [[TipLabel alloc] init];
    [view addSubview:errorLabel];
    
    [errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.width.mas_equalTo(rect.size.width + 25);
        make.height.mas_equalTo(rect.size.height +20);
    }];
    errorLabel.text = msg;
    errorLabel.numberOfLines = 0 ;
    errorLabel.backgroundColor = [UIColor blackColor];
    errorLabel.textColor = [UIColor whiteColor];
    errorLabel.layer.cornerRadius = 5 ;
    errorLabel.clipsToBounds = YES;
    errorLabel.textAlignment = NSTextAlignmentCenter;
    errorLabel.font = [UIFont systemFontOfSize:15];
    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
    
}

+ (void)dismiss
{
    [UIView animateWithDuration:1 animations:^{
        errorLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [errorLabel removeFromSuperview];
        errorLabel = nil;
    }];
}

@end
