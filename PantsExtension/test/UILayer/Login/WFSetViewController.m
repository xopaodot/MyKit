//
//  WFSetViewController.m
//  JiMei
//
//  Created by daxiong on 2019/4/23.
//  Copyright © 2019 大熊. All rights reserved.
//

#import "WFSetViewController.h"
#import <BlocksKit/BlocksKit+UIKit.h>
#import "WFMineTableViewCell.h"

@interface WFSetViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *deadLineView;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation WFSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"账户设置";
    
    self.navigationController.navigationBar.translucent = YES;
    UIView *barBack = self.navigationController.navigationBar.subviews[0];
    barBack.backgroundColor = [UIColor clearColor];
    [barBack setAlpha:0];
    
    self.tableView.layer.cornerRadius = 22.f;
    self.tableView.layer.masksToBounds = YES;
    self.tableView.layer.shadowRadius = 10.;
    self.tableView.layer.shadowOpacity = 0.8;
    self.tableView.layer.shadowColor = WD_a0a0a0_Color.CGColor;
    self.tableView.layer.shadowOffset = CGSizeMake(0,0);
    self.tableView.layer.masksToBounds = NO;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WFMineTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([WFMineTableViewCell class])];
    
    self.deadLineView.layer.cornerRadius = 22.f;
    self.deadLineView.layer.masksToBounds = YES;
    self.deadLineView.layer.shadowRadius = 10.;
    self.deadLineView.layer.shadowOpacity = 0.8;
    self.deadLineView.layer.shadowColor = WD_a0a0a0_Color.CGColor;
    self.deadLineView.layer.shadowOffset = CGSizeMake(0,0);
    self.deadLineView.layer.masksToBounds = NO;
    
    self.logoutBtn.layer.cornerRadius = 25.f;
    self.logoutBtn.layer.masksToBounds = YES;
    self.logoutBtn.layer.shadowRadius = 10.;
    self.logoutBtn.layer.shadowOpacity = 0.8;
    self.logoutBtn.layer.shadowColor = WD_a0a0a0_Color.CGColor;
    self.logoutBtn.layer.shadowOffset = CGSizeMake(0,0);
    self.logoutBtn.layer.masksToBounds = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (IBAction)logoutBtnAction:(id)sender {
    [UIAlertView bk_showAlertViewWithTitle:@"退出登录" message:@"确认要退出登录吗？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self logoutTask];
        }
    }];
}

-(void)logoutTask
{
    if ([WDAppUtils isBlankString:getObjectFromUserDefaults(kAccessToken)]) {
        [WDAppUtils logout];
        [[WDPageManager sharedInstance] popToRootViewController:nil];
        return;
    }
    WYTask *task = [[WYTask alloc] initWithURL:URL_Logout];
    [task startWithParams:@{} requestType:WDRequestTypeDel success:^(id responseObject) {
        [WDAppUtils logout];
        [[WDPageManager sharedInstance] popToRootViewController:nil];
    }failure:^(NSError *error) {
        [WDAppUtils logout];
        [[WDPageManager sharedInstance] popToRootViewController:nil];
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = [self.dataArray objectAtIndex:section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [self.dataArray objectAtIndex:indexPath.section];
    WFMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WFMineTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = arr[indexPath.row][@"title"];
    cell.iconImageView.image = [UIImage imageNamed:arr[indexPath.row][@"icon"]];
    if (indexPath.row == 0) {
        cell.arrowImageView.image = [UIImage imageNamed:@""];
        cell.subTitleLabel.text = getObjectFromUserDefaults(kMail);
    }else{
        cell.arrowImageView.image = [UIImage imageNamed:@"arrow_right_gray"];
        cell.subTitleLabel.text = @"";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        [[WDPageManager sharedInstance] pushViewController:@"NEResetPasswordViewController"];
    }
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
        [_dataArray addObject:@[
                                @{@"title":@"电子邮箱",@"icon":@"mail"},
                                @{@"title":@"修改密码",@"icon":@"lock"}
                                ]];
    }
    return _dataArray;
}



@end
