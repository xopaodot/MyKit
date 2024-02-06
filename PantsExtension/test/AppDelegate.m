//
//  AppDelegate.m
//  test
//
//  Created by moonmd.xie on 2018/3/28.
//  Copyright © 2018年 moonmd.xie. All rights reserved.
//

#import "AppDelegate.h"
#import "NEHomeViewController.h"
#import <BlocksKit+UIKit.h>
#import "WDNavigationController.h"
#import "NEVersionModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self showMainViewController];

        
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)showMainViewController
{
    NEHomeViewController *homeVc = [[NEHomeViewController alloc] initWithNibName:@"NEHomeViewController" bundle:nil];
    WDNavigationController *navigationController = [[WDNavigationController alloc] initWithRootViewController:homeVc];
    self.window.rootViewController = navigationController;
}

- (void)lookUpAPP {
    
    WYTask *task = [[WYTask alloc] initWithURL:URL_AUTH_SYSTEM];
    [task setNeedAutomaticLoadingView:NO];
    [task setNeedAutomaticErrorMessage:NO];
    NSString * curAppVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    [task startWithParams:@{} success:^(id responseObject) {
        WYBaseModel *baseModel = [WYBaseModel modelObjectWithDict:responseObject];
        if ([baseModel.code intValue] != 200) {
            return;
        }
        
        NEVersionModel *model = [NEVersionModel modelObjectWithDict:baseModel.result];
        
        if ([curAppVersion integerValue] <= [model.force_ios_version integerValue]) {
            //** 强制更新 */
            [UIAlertView bk_showAlertViewWithTitle:@"更新提示" message:model.content cancelButtonTitle:nil otherButtonTitles:@[@"去更新"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                NSURL* url = [NSURL URLWithString:[@"https://itunes.apple.com/ca/app/id1493152490" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                if([[UIApplication sharedApplication] canOpenURL:url]){
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
        }else if([curAppVersion integerValue] <= [model.ios_version integerValue]){
            [UIAlertView bk_showAlertViewWithTitle:@"更新提示" message:model.content cancelButtonTitle:@"去更新" otherButtonTitles:@[@"再用用看"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex == 0) {
                    NSURL* url = [NSURL URLWithString:[@"" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    if([[UIApplication sharedApplication] canOpenURL:url]){
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }
            }];
        }
    }];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccessNotification" object:nil];
    [self lookUpAPP];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
