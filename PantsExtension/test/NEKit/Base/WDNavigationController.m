//
//  WDNavigationController.m
//  IOS-Weidai
//
//  Created by yaoqi on 16/5/13.
//  Copyright © 2016年 微贷（杭州）金融信息服务有限公司. All rights reserved.
//

#import "WDNavigationController.h"
#import "WDColorHeader.h"

static CGFloat const WDNavigationTextSize = 15.f;
static CGFloat const WDNavigationCenterTextSize = 18.f;

@interface WDNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation WDNavigationController

+ (void)initialize {
    // 1.设置导航栏主题
    [self setupNavBarTheme];

    // 2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme {

   
    UIBarButtonItem *item = [UIBarButtonItem appearance];

    // 设置默认文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = WD_333333_Color;
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:WDNavigationTextSize];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];

    // 设置不能点击时文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
}

/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme {
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    [navBar setTintColor:WD_333333_Color];
    [navBar setBarTintColor:[UIColor whiteColor]];
    [navBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];

    // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = WD_333333_Color;
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:WDNavigationCenterTextSize];
    [navBar setTitleTextAttributes:textAttrs];
    
    //去掉黑线
    [navBar setShadowImage:[UIImage new]];

//    [navBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [navBar setShadowImage:[UIImage imageNamed:@"line_gray"]];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    __weak WDNavigationController *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}
//


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (self.viewControllers.count > 0) {
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"buy_backicon_lan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:YES];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    return YES;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (
        [viewController isMemberOfClass:NSClassFromString(@"NEHomeViewController")]
        )
    {
        [navigationController setNavigationBarHidden:YES animated:animated];
    } else if ( [navigationController isNavigationBarHidden] ) {
        [navigationController setNavigationBarHidden:NO animated:animated];
    }

}


@end
