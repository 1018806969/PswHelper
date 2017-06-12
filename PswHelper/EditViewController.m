//
//  EditViewController.m
//  PswHelper
//
//  Created by Merlin on 2017/6/12.
//  Copyright © 2017年 lq. All rights reserved.
//

#import "EditViewController.h"
#import "CDManager.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pswTextField;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextField;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _remarkTextField.layer.borderWidth = 0.5f;
    _remarkTextField.layer.borderColor = [UIColor grayColor].CGColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    if (self.record) {
        _titleTextField.text = self.record.title;
        _usernameTextField.text = self.record.username;
        _pswTextField.text = self.record.psw;
        _remarkTextField.text = self.record.remark;
    }
}
- (void)done
{
    self.record ? [self edit] : [self add];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)edit
{
    self.record.title = _titleTextField.text;
    self.record.username = _usernameTextField.text;
    self.record.psw = _pswTextField.text;
    self.record.remark = _remarkTextField.text;
    [[CDManager shareCDManager] update];
}
- (void)add
{
    CDManager *manager = [CDManager shareCDManager];
    [manager insertRecordTitle:_titleTextField.text username:_usernameTextField.text psw:_pswTextField.text remark:_remarkTextField.text];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
