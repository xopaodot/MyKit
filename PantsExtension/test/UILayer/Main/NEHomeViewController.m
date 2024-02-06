//
//  NEHomeViewController.m
//  NetworkExtension
//
//  Created by daxiong on 2019/11/8.
//  Copyright © 2019 moonmd.xie. All rights reserved.
//

#import "NEHomeViewController.h"
#import "NEUserInfoModel.h"
#import "NENodeListModel.h"
#import "NENodeListCell.h"
#import "VPNManager.h"
#import "NEHomeHeaderView.h"
#import <NetworkExtension/NetworkExtension.h>
#import "WHPingTester.h"
#import "NEBannerModel.h"
#import <UIImageView+WebCache.h>
#import <UIView+BlocksKit.h>

@interface NEHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,WHPingDelegate>
@property (weak, nonatomic) IBOutlet UIButton *connectBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UIView *clearNavView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *connectTop;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgImageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *clearNavHeight;
@property (weak, nonatomic) IBOutlet UIView *connectView;
@property (weak, nonatomic) IBOutlet UIButton *navPingBtn;
@property (weak, nonatomic) IBOutlet UILabel *connectLabel;
@property (weak, nonatomic) IBOutlet UIView *tableBgView;

@property (strong, nonatomic) NEHomeHeaderView *headView;
@property (nonatomic, strong) WHPingTester* pingTester;
@property (strong, nonatomic) NEBannerModel *bannerModel;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *centerView;
@property (strong, nonatomic) NSArray<NENodeListModel *> *dataArray;
@property (nonatomic, assign) BOOL isShowFunctionalUnit;
@property (nonatomic, assign) BOOL needPing;
@property (nonatomic, assign) int pingIndex;






@end

@implementation NEHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.connectBtn.layer.cornerRadius = 60.;
//    self.connectBtn.layer.masksToBounds = YES;
    self.bgImageView.layer.cornerRadius = 22.f;
    self.bgImageView.layer.masksToBounds = YES;
    self.connectView.layer.cornerRadius = 60.f;
    self.connectView.layer.masksToBounds = YES;
    self.connectView.layer.shadowRadius = 10.;
    self.connectView.layer.shadowOpacity = 0.8;
    self.connectView.layer.shadowColor = WD_a0a0a0_Color.CGColor;
    self.connectView.layer.shadowOffset = CGSizeMake(0,0);
    self.connectView.layer.masksToBounds = NO;
    
    self.tableBgView.layer.cornerRadius = 8.f;
    self.tableBgView.layer.masksToBounds = YES;
    self.tableBgView.layer.shadowRadius = 10.;
    self.tableBgView.layer.shadowOpacity = 0.8;
    self.tableBgView.layer.shadowColor = WD_a0a0a0_Color.CGColor;
    self.tableBgView.layer.shadowOffset = CGSizeMake(0,0);
    self.tableBgView.layer.masksToBounds = NO;

    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NENodeListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NENodeListCell class])];
    
    self.tableView.scrollEnabled = NO;
    self.isShowFunctionalUnit = YES;
    self.navHeight.constant = kNavBarAndStatusBarHeight;
    self.clearNavHeight.constant = kNavBarAndStatusBarHeight;
    [self.scrollView addSubview:self.topView];
    [self.scrollView setContentInset:UIEdgeInsetsMake(280+kNavBarHeight, 0, 0, 0)];
    if ([WDAppUtils checkLogin]) {
        [self getUserInfoTask];
    }
    [self getConfigListTask];
    [self getBannerTask];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onVPNStatusChanged)
                                                 name:@"kProxyServiceVPNStatusNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccess)
                                                 name:@"kLoginSuccessNotification"
                                               object:nil];
    [self createRightButtonWithTitle:@"测速"];
   
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateBtnStatus];
    
    if ([WDAppUtils checkLogin]) {
        self.headView.passBtn.hidden = YES;
        NSString *mailString = getObjectFromUserDefaults(kMail);
        NSArray *arr = [mailString componentsSeparatedByString:@"@"];
        if (arr.count>0) {
            self.headView.infoLabel.text = [NSString stringWithFormat:@"%@,欢迎使用胖子加速",arr[0]];
        }else{
            self.headView.infoLabel.text = @"欢迎使用胖子加速";
        }
    }else{
        self.headView.passBtn.hidden = NO;
        self.headView.infoLabel.text = @"您还没有可用账号";
    }
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.isShowFunctionalUnit) {
        [self.scrollView setContentOffset:CGPointMake(0,-(280+kNavBarAndStatusBarHeight)) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(0,0) animated:YES];
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
 
{
 
    return YES;
 
}



- (IBAction)pingBtnAction:(id)sender {
    if (self.dataArray.count > 0) {
        self.pingIndex = 0;
        [self pingNetworkWithIndex:self.pingIndex];
    }
    [self.tableView reloadData];
}


- (IBAction)meCenterBtnAction:(id)sender {
    [[WDPageManager sharedInstance] pushViewController:@"NEMyViewController"];
}


- (IBAction)connectBtnAction:(id)sender {
    if (![WDAppUtils checkLogin]) {
        [[WDPageManager sharedInstance] presentViewController:@"NERegisterViewController" withParam:nil inNavigationController:YES animated:YES];
        return;
    }
    [SVProgressHUD show];
    if([VPNManager sharedInstance].VPNStatus == VPNStatus_off){
        [[VPNManager sharedInstance] connect];
    }else{
        [[VPNManager sharedInstance] disconnect];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           [SVProgressHUD dismiss];
    });
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
        saveObjectToUserDefaults(model.username, kMail);
    } failure:^(NSError *error) {
        
    }];
}

- (void)getBannerTask
{
    WYTask *task = [[WYTask alloc] initWithURL:URL_queryHomeBanner];
    [task setNeedAutomaticLoadingView:NO];
    [task startWithParams:@{} success:^(id responseObject) {
        WYBaseModel *baseModel = [WYBaseModel modelObjectWithDict:responseObject];
        if ([baseModel.code intValue] != 200) {
            return;
        }
        NSArray *arr = [baseModel parseSubItemList:baseModel.dl withClass:[NEBannerModel class]];
        if (arr.count > 0) {
            self.bannerModel = arr[0];
            [self.headView.adImageView sd_setImageWithURL:[NSURL URLWithString:self.bannerModel.image]];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)getConfigListTask
{
    WYTask *task = [[WYTask alloc] initWithURL:URL_AUTH_NODE];
    [task startWithParams:@{} success:^(id responseObject) {
        WYBaseModel *baseModel = [WYBaseModel modelObjectWithDict:responseObject];
        if ([baseModel.code intValue] != 200) {
            return;
        }
        self.dataArray = [baseModel parseSubItemList:baseModel.dl withClass:[NENodeListModel class]];
        if (self.dataArray.count > 0) {
            NENodeListModel *model = self.dataArray[0];
            saveObjectToUserDefaults(model.ip, kSeverAddress);
            NSString *str = [WDAppUtils replaceMethodWithMethodString:model.method];
            saveObjectToUserDefaults(str, kMethod);
            self.pingIndex = 0;
            [self pingNetworkWithIndex:self.pingIndex];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


- (void)updateNode
{
//    [[VPNManager sharedInstance] loadAndCreatePrividerManager:^(NETunnelProviderManager *manager) {
//        if (!manager) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self updateNode];
//            });
//        }
//    }];
    if([VPNManager sharedInstance].VPNStatus != VPNStatus_off){
        [[VPNManager sharedInstance] disconnect];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[VPNManager sharedInstance] connect];
        });
    }
}

- (void)pingNetworkWithIndex:(int)index
{
    if (index >= self.dataArray.count) {
        return;
    }
    NENodeListModel *nodeModel = self.dataArray[index];
    self.pingTester = [[WHPingTester alloc] initWithHostName:nodeModel.ip];
    self.pingTester.delegate = self;
    [self.pingTester startPing];
    
}

#pragma mark - WHPingDelegate

- (void)singPing:(SimplePing *)ping didPingSucccessWithTime:(float)time withError:(NSError*) error;
{
    NSString *speedStr = nil;
    if(!error)
    {
        speedStr = [NSString stringWithFormat:@"%.f ms",time];
        NSLog(@"%@******%.f ms",ping.hostName,time);
    }else{
        speedStr = @"超时";
        NSLog(@"%@******超时",ping.hostName);
    }
    [self.pingTester stopPing];
    if (self.pingIndex >= self.dataArray.count) {
        return;
    }
    if ([self.dataArray[self.pingIndex].ip isEqualToString:ping.hostName]) {
        self.dataArray[self.pingIndex].speed = speedStr;
        self.pingIndex++;
        [self pingNetworkWithIndex:self.pingIndex];
        [self.tableView reloadData];
    }
}

#pragma mark ------ UIScrollViewDelegate ------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.tableView]) {
        return;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"*********** %f",offsetY);
//    if (offsetY == -20) {
//        return;
//    }
    if (offsetY >= 0) {
        self.clearNavView.hidden = NO;
    }else{
        self.clearNavView.hidden = YES;
    }
    self.navView.alpha = (-offsetY/(280+kNavBarAndStatusBarHeight));
    self.navPingBtn.alpha = (-offsetY/(280+kNavBarAndStatusBarHeight));
    self.connectTop.constant = 41-(offsetY/2.);
    self.tableViewHeight.constant = (kScreenHeight-160-kBottomSafeHeight)-((280+kNavBarAndStatusBarHeight))/2. + (offsetY/2.);
    self.tableViewTop.constant = 88+((280+kNavBarAndStatusBarHeight))/2.+(offsetY/2.);
    self.bgImageViewHeight.constant = kScreenHeight+22+offsetY;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat offsetY = scrollView.contentOffset.y;
    kWeakSelf;
    if (self.isShowFunctionalUnit) {
        // 现在是隐藏
        if (offsetY > AUTOLAYOUTSIZE(-250-kNavBarAndStatusBarHeight)) {
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            self.isShowFunctionalUnit = NO;
            self.bgImageView.layer.cornerRadius = 0.;
            [self.tableView reloadData];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.scrollView setContentOffset:CGPointMake(0,0) animated:YES];
                weakSelf.tableView.scrollEnabled = YES;
            });
        }else{
            self.scrollView.contentInset = UIEdgeInsetsMake((280+kNavBarAndStatusBarHeight), 0, 0, 0);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.scrollView setContentOffset:CGPointMake(0,-(280+kNavBarAndStatusBarHeight)) animated:YES];
            });
        }
        
    } else {
        // 现在是显示
        if (offsetY < AUTOLAYOUTSIZE(-50)) {
            self.isShowFunctionalUnit = YES;
            self.bgImageView.layer.cornerRadius = 22.f;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.scrollView setContentOffset:CGPointMake(0,-(280+kNavBarAndStatusBarHeight)) animated:YES];
                weakSelf.tableView.scrollEnabled = NO;
                [self.tableView reloadData];
            });
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.scrollView setContentOffset:CGPointMake(0,0) animated:YES];
            });
        }
    }
}



#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count <= 0) {
        return 0;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NENodeListModel *nodeModel = [self.dataArray objectAtIndex:indexPath.row];
    NENodeListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NENodeListCell class]) forIndexPath:indexPath];
    if ([nodeModel.ip isEqualToString:getObjectFromUserDefaults(kSeverAddress)]) {
        cell.selectImageView.image = [UIImage imageNamed:@"gou_select"];
    }else{
        cell.selectImageView.image = [UIImage imageNamed:@"gou"];
    }
    [cell configModel:nodeModel];
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.dataArray.count <= 0) {
        return [UIView new];
    }
    if (self.isShowFunctionalUnit) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-60, 40)];
        view.backgroundColor = [UIColor clearColor];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-60, 30)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.shadowRadius = 3.;
        bgView.layer.shadowOpacity = 0.3;
        bgView.layer.shadowColor = WD_a0a0a0_Color.CGColor;
        bgView.layer.shadowOffset = CGSizeMake(0,-3);
        [view addSubview:bgView];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, kScreenWidth-16-60, 40)];
        lab.text = @"上拉查看更多";
        lab.textColor = WD_a0a0a0_Color;
        lab.backgroundColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
        lab.textAlignment = NSTextAlignmentCenter;
        [view addSubview:lab];
        return view;
    }else{
        return [UIView new];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.dataArray.count <= 0) {
        return 0.;
    }
    if (self.isShowFunctionalUnit) {
        return 40.;
    }else{
        return 0.01;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *cellArray = [tableView visibleCells];
    for (int i = 0; i < [cellArray count]; i++) {
        NENodeListCell *cell = (NENodeListCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i  inSection:0]];
        if (indexPath.row == i) {
            cell.selectImageView.image = [UIImage imageNamed:@"gou_select"];
        }else {
            cell.selectImageView.image = [UIImage imageNamed:@"gou"];
        }
    }
    NENodeListModel *nodeModel = [self.dataArray objectAtIndex:indexPath.row];
    saveObjectToUserDefaults(nodeModel.ip, kSeverAddress);
    NSString *str = [WDAppUtils replaceMethodWithMethodString:nodeModel.method];
    saveObjectToUserDefaults(str, kMethod);
    [self updateNode];
}

#pragma mark - 收到监听通知处理
- (void)onVPNStatusChanged{
    [self updateBtnStatus];
}

- (void)loginSuccess
{
    [self getUserInfoTask];
    [self getBannerTask];
    [self getConfigListTask];
}

#pragma mark - get/set
- (void)updateBtnStatus{
    switch ([VPNManager sharedInstance].VPNStatus) {
        case VPNStatus_connecting:
//            self.connectLabel.text = @"连接";
            break;
        case VPNStatus_disconnecting:
//            self.connectLabel.text = @"连接";
//            [self.connectBtn setTitle:@"断开" forState:UIControlStateNormal];
            break;
            
        case VPNStatus_on:
            self.connectLabel.text = @"断开";
            self.connectLabel.textColor = [UIColor whiteColor];
            self.connectView.backgroundColor = WD_bg_red_Color;
            break;
            
        case VPNStatus_off:
            self.connectLabel.text = @"连接";
            self.connectLabel.textColor = WD_333333_Color;
            self.connectView.backgroundColor = [UIColor whiteColor];
            break;
            
        default:
            break;
    }
    self.connectBtn.enabled = [VPNManager sharedInstance].VPNStatus == VPNStatus_on||[VPNManager sharedInstance].VPNStatus == VPNStatus_off;
}


- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray new];
    }
    return _dataArray;
}

- (UIView *)topView
{
    if(!_topView)
    {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, -280-kNavBarAndStatusBarHeight, kScreenWidth, 280+kNavBarAndStatusBarHeight)];
        _topView.backgroundColor = WD_f6f6f6_Color;
        self.headView.frame = CGRectMake(0, 0, kScreenWidth, 280+kNavBarAndStatusBarHeight);
        [_topView addSubview:self.headView];
    }
    return _topView;
}

- (NEHomeHeaderView *)headView
{
    if (!_headView) {
        _headView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NEHomeHeaderView class]) owner:self options:nil] firstObject];
        [_headView.adView bk_whenTapped:^{
            if (self.bannerModel && ![WDAppUtils isBlankString:self.bannerModel.url]) {
                [[WDPageManager sharedInstance] pushViewController:@"WDWKWebViewController" withParam:@{@"requestURL":self.bannerModel.url}];
            }
        }];
    }
    return _headView;
}


@end
