//
//  WDPageManager.h
//  WDPageManager
//
//  Created by dongmx on 15/4/21.
//  Copyright (c) 2015年 dongmx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WDPageErrorViewController.h"


@interface WDPageManager : NSObject

// Current view controller showing on the screen
@property (weak, nonatomic) UIViewController *currentViewController;
@property (weak, nonatomic) UIViewController *currentLoadedViewController;

@property (strong, nonatomic) NSString *baseViewControllerClassName;
@property (strong, nonatomic) NSString *errorViewControllerClassName;

+ (instancetype)sharedInstance;

- (void)pushViewController:(NSString *)viewControllerName;
- (void)pushViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param;


- (void)pushViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param animated:(BOOL)animated;


- (UIViewController*)popViewControllerWithParam:(NSDictionary*)param;
- (NSArray*)popToViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param;


- (NSArray *)popToRootViewController:(NSDictionary *)param;
- (NSArray *)popToRootViewController:(NSDictionary *)param animated:(BOOL)animated;
- (UIViewController*)getCurrentShowViewController;

- (void)popThenPushViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param animated:(BOOL)animated;

- (void)popToRootThenPushViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param animated:(BOOL)animated;

/*Discussion:
 1,The navigation pop to the nearest viewController whose className isEqual to popToViewControllerName. That means if there's two viewControllers in the navigation. it will pop to the one whose index is bigger in the navigation's viewControllers.
 2,if there's no viewController that it's class isEqual to popToViewControllerName. the method won't pop any viewController but will push newViewController.
 */
- (void)popToViewControllerThenPushViewController:(NSString *)popToViewControllerName
                                  pushedViewController:(NSString *)pushedViewControllerName
                                             withParam:(NSDictionary *)param
                                              animated:(BOOL)animated;


- (UIViewController *)createViewControllerFromName:(NSString *)name param:(NSDictionary *)param;
- (NSString*)nibFileName:(Class)theClass;

- (void)presentViewController:(NSString *)viewControllerName;
- (void)presentViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param;
- (void)presentViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param inNavigationController:(BOOL)isInNavigationController;
- (void)presentViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param inNavigationController:(BOOL)isInNavigationController animated:(BOOL)animated;

- (void)fadeInViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param;
- (UIViewController *)fadeOutViewControllerWithParam:(NSDictionary *)param;
@end

@interface UINavigationController (popToBeforeClass)
- (void)popToBeforeClass:(Class)theClass animated:(BOOL)animated;
@end

@interface UIViewController (WYPageManager)

@end

@interface NSArray (WYPageManager)

- (NSArray *)filterViewControllersWithClassName:(NSString*)className;
- (NSArray *)filterArrayForRightOfClassName:(NSString *)className;

@end
