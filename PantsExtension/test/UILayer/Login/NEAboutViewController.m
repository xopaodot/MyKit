//
//  NEAboutViewController.m
//  NetworkExtension
//
//  Created by daxiong on 2019/12/9.
//  Copyright © 2019 moonmd.xie. All rights reserved.
//

#import "NEAboutViewController.h"
#import "WFMineTableViewCell.h"

@interface NEAboutViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation NEAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于";
    
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

- (IBAction)userProtocolBtnAction:(id)sender {
    [[WDPageManager sharedInstance] pushViewController:@"WDWKWebViewController" withParam:@{@"requestURL":@"https://pants.run/service"}];
}

- (IBAction)privacyPolicyBtnAction:(id)sender {
    [[WDPageManager sharedInstance] pushViewController:@"WDWKWebViewController" withParam:@{@"requestURL":@"https://pants.run/policy"}];
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
        cell.subTitleLabel.text = [NSString stringWithFormat:@"V %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];

        cell.arrowImageView.image = [UIImage imageNamed:@""];
    }else{
        cell.subTitleLabel.text = @"";
        cell.arrowImageView.image = [UIImage imageNamed:@"arrow_right_gray"];
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
        NSString *string = [NSString stringWithFormat:@"https://itunes.apple.com/ca/app/id1493152490?l=zh&ls=1&mt=8"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
    }
   
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
        [_dataArray addObject:@[
                                @{@"title":@"当前版本",@"icon":@"icon_version"},
                                @{@"title":@"给软件评分",@"icon":@"icon_smile"}
                                ]];
    }
    return _dataArray;
}
@end
