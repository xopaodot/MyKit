//
//  NEMyViewController.m
//  NetworkExtension
//
//  Created by daxiong on 2019/11/8.
//  Copyright © 2019 moonmd.xie. All rights reserved.
//

#import "NEMyViewController.h"
#import "WFMineTableViewCell.h"
#import "NEUserInfoModel.h"
@interface NEMyViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;


@end

@implementation NEMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Pants VPN";
    [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([WDAppUtils checkLogin]) {
        [self getUserInfoTask];
    }
}

- (IBAction)toLoginBtn:(id)sender {
    if (![WDAppUtils checkLogin]) {
        [[WDPageManager sharedInstance] presentViewController:@"NERegisterViewController" withParam:nil inNavigationController:YES animated:YES];
        return;
    }
}

- (IBAction)userProtocolBtnAction:(id)sender {
    [[WDPageManager sharedInstance] pushViewController:@"WDWKWebViewController" withParam:@{@"requestURL":@"https://pants.run/service"}];
}

- (IBAction)privacyPolicyBtnAction:(id)sender {
    [[WDPageManager sharedInstance] pushViewController:@"WDWKWebViewController" withParam:@{@"requestURL":@"https://pants.run/policy"}];
}


- (void)getUserInfoTask
{
    WYTask *task = [[WYTask alloc] initWithURL:URL_AUTH];
    [task setNeedAutomaticLoadingView:NO];
    [task startWithParams:@{} success:^(id responseObject) {
        WYBaseModel *baseModel = [WYBaseModel modelObjectWithDict:responseObject];
        if ([baseModel.code intValue] != 200) {
            return;
        }
        NEUserInfoModel *model = [NEUserInfoModel modelObjectWithDict:baseModel.result];
        saveObjectToUserDefaults(model.passwd, kPassword);
        saveObjectToUserDefaults(model.port, kPort);
        saveObjectToUserDefaults(model.recordId, kUserId);
        saveObjectToUserDefaults(model.username, kMail);
    } failure:^(NSError *error) {
        
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
    cell.titleLabel.text = arr[indexPath.row][@"title"];
    cell.iconImageView.image = [UIImage imageNamed:arr[indexPath.row][@"icon"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![WDAppUtils checkLogin]) {
        [[WDPageManager sharedInstance] presentViewController:@"NERegisterViewController" withParam:nil inNavigationController:YES animated:YES];
        return;
    }
    if (indexPath.row == 0) {
        [[WDPageManager sharedInstance] pushViewController:@"WFSetViewController"];
    }else if (indexPath.row == 1){
        [[WDPageManager sharedInstance] pushViewController:@"NEAboutViewController"];
    }
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
        [_dataArray addObject:@[
                                @{@"title":@"设置",@"icon":@"shezhi"},
                                @{@"title":@"关于",@"icon":@"info-circle"}
                                ]];
    }
    return _dataArray;
}


@end
