//
//  WDStoreData.h
//  IOS-WeidaiCreditLoan
//
//  Created by yaoqi on 16/4/11.
//  Copyright © 2016年 微贷（杭州）金融信息服务有限公司. All rights reserved.
//

#ifndef WDStoreData_h
#define WDStoreData_h



static NSString *const kAccessToken = @"access_token";

static NSString *const kSeverAddress = @"kSeverAddress";
static NSString *const kPort = @"kPort";
static NSString *const kPassword = @"kPassword";
static NSString *const kMethod = @"kMethod";
static NSString *const kUserId = @"userId";
static NSString *const kMail = @"mail";








static NSString *const kSplashImageUrl = @"kSplashImageUrl";

static __inline__ __attribute__((always_inline)) void saveObjectToUserDefaults(id value, NSString *key) {
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

static __inline__ __attribute__((always_inline)) NSString *getObjectFromUserDefaults(NSString *key) {
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (!obj) {
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

static __inline__ __attribute__((always_inline)) void removeObjectFromUserDefaults(NSString *key) {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#endif /* WDStoreData_h */
