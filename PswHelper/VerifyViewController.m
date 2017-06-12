//
//  VerifyViewController.m
//  PswHelper
//
//  Created by Merlin on 2017/6/12.
//  Copyright © 2017年 lq. All rights reserved.
//

#import "VerifyViewController.h"
#import "MainViewController.h"
#import "TipLabel.h"
#import "masonry.h"

@interface VerifyViewController ()

@property (nonatomic, strong) UITextField *pswtextField;
@property (nonatomic, strong) UIButton    *verifyButton;
@property (nonatomic, strong) NSString    *psw;

@end

@implementation VerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.pswtextField];
    [self.view addSubview:self.verifyButton];
    [self layout];
    
    self.psw = [[NSUserDefaults standardUserDefaults]objectForKey:PswKey];
    if (self.psw) {
        [self.verifyButton setTitle:@"verify psw" forState:UIControlStateNormal];
    }else
    {
        [self.verifyButton setTitle:@"set psw" forState:UIControlStateNormal];
    }
}
- (void)verify
{
    if (!self.pswtextField.text) {
        return;
    }
    if (self.psw) {
        if ([self.pswtextField.text isEqualToString:self.psw])
        {
            [self verifySccessed];
        }else
        {
            [TipLabel showErrorMsg:@"psw error" superView:self.view];
        }
    }else
    {
        [[NSUserDefaults standardUserDefaults]setObject:self.pswtextField.text forKey:PswKey];
        [TipLabel showErrorMsg:@"psw seted success" superView:self.view];
        self.psw = [[NSUserDefaults standardUserDefaults]objectForKey:PswKey];
        self.pswtextField.text = nil;
        [self.verifyButton setTitle:@"verify psw" forState:UIControlStateNormal];
    }
}
- (UIButton *)verifyButton
{
    if (!_verifyButton) {
        _verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verifyButton setTitle:@"verify" forState:UIControlStateNormal];
        [_verifyButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_verifyButton addTarget:self action:@selector(verify) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verifyButton;
}
- (UITextField *)pswtextField
{
    if (!_pswtextField) {
        _pswtextField = [[UITextField alloc]init];
        _pswtextField.secureTextEntry = YES;
        _pswtextField.layer.borderColor = [UIColor grayColor].CGColor;
        _pswtextField.layer.borderWidth = 0.5f;
        [_pswtextField becomeFirstResponder];
        _pswtextField.clearButtonMode = UITextFieldViewModeAlways;
        _pswtextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
        _pswtextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _pswtextField;
}
- (void)layout
{
    [_verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_pswtextField.mas_bottom).mas_equalTo(20);
    }];

    [_pswtextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(150);
        make.centerX.equalTo(self.view);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(40);
    }];
}
- (void)verifySccessed
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    MainViewController *mainvc = [[MainViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainvc];
    window.rootViewController = nav;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end
