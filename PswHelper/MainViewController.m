//
//  MainViewController.m
//  PswHelper
//
//  Created by Merlin on 2017/6/12.
//  Copyright © 2017年 lq. All rights reserved.
//

#import "MainViewController.h"
#import "EditViewController.h"
#import "VerifyViewController.h"
#import "RecordCell.h"
#import "CDManager.h"
#import "Record.h"
#import "masonry.h"

static NSString *const reuseId = @"recordcell";

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray     *records;
@property (nonatomic, strong) UIButton    *resetpswButton;

@end

@implementation MainViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.records = [[CDManager shareCDManager] readRecord];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.resetpswButton];
    [self layout];
    
    self.title = @"psw manager";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"add" style:UIBarButtonItemStylePlain target:self action:@selector(addRecord)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"sign out" style:UIBarButtonItemStylePlain target:self action:@selector(signOut)];

}
- (void)signOut
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    VerifyViewController *verifyvc = [[VerifyViewController alloc]init];
    window.rootViewController = verifyvc;
}
- (void)resetPsw
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:PswKey];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    VerifyViewController *verifyvc = [[VerifyViewController alloc]init];
    window.rootViewController = verifyvc;
}
- (void)addRecord
{
    EditViewController *editvc = [[EditViewController alloc]init];
    editvc.title = @"add";
    [self.navigationController pushViewController:editvc animated:YES];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Record *record = self.records[indexPath.row];
    [[CDManager shareCDManager]deleteRecord:record];
    self.records = [[CDManager shareCDManager]readRecord];
    [tableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Record *record = self.records[indexPath.row];
    EditViewController *editvc = [[EditViewController alloc]init];
    editvc.record = record;
    editvc.title = @"edit";
    [self.navigationController pushViewController:editvc animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.records.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Record *record = self.records[indexPath.row];
    RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    cell.record = record;
    return  cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Record *record = self.records[indexPath.row];
    CGFloat remarkH = [self heightOfRemark:record.remark];
    CGFloat cellH = 75 + remarkH;
    return cellH;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.estimatedRowHeight = 40.0f;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [_tableView registerClass:[RecordCell class] forCellReuseIdentifier:reuseId];
    }
    return _tableView;
}
- (UIButton *)resetpswButton
{
    if (!_resetpswButton) {
        _resetpswButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetpswButton setTitle:@"reset psw" forState:UIControlStateNormal];
        [_resetpswButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _resetpswButton.backgroundColor = [UIColor orangeColor];
        [_resetpswButton addTarget:self action:@selector(resetPsw) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetpswButton;
}
- (void)layout
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
    }];
    [_resetpswButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom).mas_equalTo(0);
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];

}
- (CGFloat)heightOfRemark:(NSString *)remark
{
    CGRect rect = [remark boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:15]} context:nil];
    return rect.size.height + 10;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
