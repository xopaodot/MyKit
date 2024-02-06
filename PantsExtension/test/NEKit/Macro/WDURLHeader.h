//
//  WDURLHeader.h
//  CreditMarket
//
//  Created by dongmx on 2017/10/18.
//  Copyright © 2017年 Loans365. All rights reserved.
//

#ifndef WDURLHeader_h
#define WDURLHeader_h



#define kGeTui_AppId        @"7R2RlyVSyD8dFOphb3R5y4"
#define kGeTui_AppSecret    @"hI41dqytKd5hc8BYqhPU78"
#define kGeTui_AppKey       @"uuPhM9Vx5t5lTxsqza2NA5"

static NSString * const kNotificationLoadPlanetShop = @"kNotificationLoadPlanetShop";


#define kPageNo                             @"pageNo"
#define kPageSize                           @"pageSize"
#define kPageSizeValue                      @10

static NSString * const sCode               = @"0000";

#pragma mark - 系统配置项

static NSString * const URL_querySystemParam        = @"rebate/api/querySystemParam";       //系统配置项


#pragma mark - 登录注册模块

static NSString * const URL_AUTH                    = @"api/auth/me";

static NSString * const URL_AUTH_NODE               = @"api/auth/node";

static NSString * const URL_register                = @"api/auth/register";

static NSString * const URL_Login                   = @"api/auth/login";

static NSString * const URL_Logout                  = @"api/auth/logout";

static NSString * const URL_AUTH_SYSTEM             = @"api/auth/system";

static NSString * const URL_RESET_PASSWORD          = @"api/auth/user/";  //api/auth/user/:id/password

static NSString * const URL_AUTH_Code               = @"api/auth/code?username=";


#pragma mark - 用户

static NSString * const URL_GetInviteCode           = @"api/auth/login";




#pragma mark - 首页

static NSString * const URL_queryHomeBanner         = @"api/auth/banner";            //首页banner



#pragma mark - 签到

static NSString * const URL_Sign                    = @"rebate/api/sign";

static NSString * const URL_queryContinueSignTimes  = @"rebate/api/queryContinueSignTimes";

static NSString * const URL_querySignRecord         = @"rebate/api/querySignRecord";




#endif /* WDURLHeader_h */
