//
//  WDFrameHeader.h
//  IOS-Weidai
//
//  Created by yaoqi on 16/5/13.
//  Copyright © 2016年 微贷（杭州）金融信息服务有限公司. All rights reserved.
//

#ifndef WDFrameHeader_h
#define WDFrameHeader_h

#pragma mark - ***** frame设置

#define WDWeakSelf       __weak __typeof(self)weakSelf = self
#define WDStrongSelf     __strong __typeof(weakSelf)strongSelf = weakSelf

/*! 当前设备的屏幕宽度 */
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

/**
 *  自适应大小
 */
#define AUTOLAYOUTSIZE(size) (kScreenWidth / 375.0 * size)

/*! 当前设备的屏幕高度 */
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define getRectNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height


#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX kScreenWidth >=375.0f && kScreenHeight >=812.0f&& kIs_iphone

/*状态栏高度*/
#define kStatusBarHeight (CGFloat)(kIs_iPhoneX?(44.0):(20.0))
/*导航栏高度*/
#define kNavBarHeight (44)
/*状态栏和导航栏总高度*/
#define kNavBarAndStatusBarHeight (CGFloat)(kIs_iPhoneX?(88.0):(64.0))
/*TabBar高度*/
#define kTabBarHeight (CGFloat)(kIs_iPhoneX?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define kTopBarSafeHeight (CGFloat)(kIs_iPhoneX?(44.0):(0))
/*底部安全区域远离高度*/
#define kBottomSafeHeight (CGFloat)(kIs_iPhoneX?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define kTopBarDifHeight (CGFloat)(kIs_iPhoneX?(24.0):(0))
/*导航条和Tabbar总高度*/
#define kNavAndTabHeight (kNavBarAndStatusBarHeight + kTabBarHeight)


/*! 黄金比例的宽 */
#define WD_WIDTH_0_618 kScreenWidth * 0.618

/*! Status bar height. */
#define WD_StatusBarHeight 20.f

/*! Navigation bar height. */
#define WD_NavigationBarHeight 44.f

/*! Tabbar height. */
#define WD_getTabbarHeight 49.f

/*! Status bar & navigation bar height. */
#define WD_StatusBarAndNavigationBarHeight (20.f + 44.f)

/*! iPhone4 or iPhone4s */
#define WD_iPhone4_4s (kScreenWidth == 320.f && kScreenHeight == 480.f)

/*! iPhone5 or iPhone5s */
#define WD_iPhone5_5s (kScreenWidth == 320.f && kScreenHeight == 568.f)

/*! iPhone6 or iPhone6s */
#define WD_iPhone6_6s (kScreenWidth == 375.f && kScreenHeight == 667.f)

/*! iPhone6Plus or iPhone6sPlus */
#define WD_iPhone6_6sPlus (kScreenWidth == 414.f && kScreenHeight == 736.f)

#define WD_iPhoneX (kScreenHeight == 812.f)

#define WD_BottomSecurityHeight (WD_iPhoneX?34.f:0.f)

#define kSafeAreaTopHeight (kScreenHeight == 812.0 ? 88 : 64)

/*!  10.0 or 10.0+  */
#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

/*!  9.0 or 9.0+  */
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

/*!  8.0 or 8.0+  */
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

/*!  7.0 or 7.0+  */
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

/*! cell的间距：10 */
#define WDStatusCellMargin 10

#endif /* WDFrameHeader_h */
