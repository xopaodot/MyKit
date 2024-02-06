//
//  NEHomeHeaderView.m
//  NetworkExtension
//
//  Created by daxiong on 2019/12/4.
//  Copyright © 2019 moonmd.xie. All rights reserved.
//

#import "NEHomeHeaderView.h"
@interface NEHomeHeaderView()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *theTop;


@end

@implementation NEHomeHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.theTop.constant = kNavBarAndStatusBarHeight + 8;
    self.adView.layer.cornerRadius = 8.;
    self.adView.layer.masksToBounds = YES;
    
    self.passBtn.layer.cornerRadius = 14.;
    self.passBtn.layer.masksToBounds = YES;
}

- (IBAction)passBtnAction:(id)sender {
    if (![WDAppUtils checkLogin]) {
        [[WDPageManager sharedInstance] presentViewController:@"NERegisterViewController" withParam:nil inNavigationController:YES animated:YES];
    }
}

- (IBAction)userProtocolBtnAction:(id)sender {
    [[WDPageManager sharedInstance] pushViewController:@"WDWKWebViewController" withParam:@{@"requestURL":@"https://pants.run/service"}];
}

- (IBAction)privacyPolicyBtnAction:(id)sender {
    [[WDPageManager sharedInstance] pushViewController:@"WDWKWebViewController" withParam:@{@"requestURL":@"https://pants.run/policy"}];
}

@end
