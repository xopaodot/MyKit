//
//  WDTabBarController.m
//  IOS-Weidai
//
//  Created by yaoqi on 16/5/13.
//  Copyright © 2016年 微贷（杭州）金融信息服务有限公司. All rights reserved.
//

#import "WDNavigationController.h"
#import "WDTabBarController.h"
#import "NEHomeViewController.h"
#import "NEMyViewController.h"

@interface WDTabBarController()<UITabBarDelegate>

@end

@implementation WDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加自定义TabBar
    [self initTabBar];

    //添加所有的子控件
    [self initAllViewController];
}

//添加自定义TabBar
- (void)initTabBar {
    // 取出appearance对象
    
    self.tabBar.tintColor = WD_Main_Color;
    
    CGRect frame = CGRectMake(0.0, 0, kScreenWidth,kTabBarHeight);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1.)];
//    line.backgroundColor = WD_d4d4d4_Color;
//    [view addSubview:line];
    
    [view setBackgroundColor:WD_White_Color];
    [self.tabBar insertSubview:view atIndex:0];
    self.tabBar.opaque = YES;
    //隐藏分割线
//    [self.tabBar setClipsToBounds:YES];
    
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    [self dropShadowWithOffset:CGSizeMake(0, -1)
                        radius:1
                         color:WD_e0e0e0_Color
                       opacity:0.3];
}


- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.tabBar.clipsToBounds = NO;
}



/**
 *  创建所有子控件
 */
- (void)initAllViewController {
    //首页
    NEHomeViewController *homeVc = [[NEHomeViewController alloc] initWithNibName:@"NEHomeViewController" bundle:nil];
    [self initChickViewController:homeVc title:@"首页" imageName:@"tab_home_normal" selectImageName:@"tab_home"];

    //我的
    NEMyViewController *myVc = [[NEMyViewController alloc] initWithNibName:@"NEMyViewController" bundle:nil];
    [self initChickViewController:myVc title:@"我的" imageName:@"tab_me_normal" selectImageName:@"tab_me"];
}

/**
 *  创建一个子控件
 *
 *  @param childVc         子控件名称
 *  @param title           标题
 *  @param imageName       默认图片
 *  @param selectImageName 选中时的图片
 */
- (void)initChickViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName {
    //设置子控制器的属性
       // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = WD_Main_Color;
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19.f];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateSelected];
    childVc.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //将子控制器添加到导航控制器中
    WDNavigationController *navigationController = [[WDNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:navigationController];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *impactLight = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [impactLight impactOccurred];
    } else {
        // Fallback on earlier versions
    }
}


@end
