//
//  WDAppUtils.h
//  IOS-WeidaiCreditLoan
//
//  Created by ai on 16/4/8.
//  Copyright © 2016年 微贷（杭州）金融信息服务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WDAppUtils : NSObject

/**
 *  随机生成数
 */
+ (NSString *)getRandomChars:(NSInteger)count;

/**
 *  生成时间戳
 */
+ (NSString *)getUtcTmestemp;

/**
 获取缓存大小
 */
+(CGFloat) getCacheSize;

/**
 清空缓存
 */
+(void)clearCache;

/**
 *  判断手机号
 */
+ (BOOL)isLegaliPhoneNum:(NSString *)text;
/**
 *  判断是否是纯数字
 */
+(BOOL)isPureNum:(NSString *)string;
/**
 *  判断str2是不是str1的整数倍
 */
+ (BOOL)judgeStr:(NSString *)str1 with:(NSString *)str2;
/**
 *  字符串判NULL
 */
+ (BOOL)isBlankString:(NSString *)string;
/*
 * 返回统一金额样式
 */
+ (NSString *)UnityMoneyString:(NSString *)moneyValue;
/**
 *  手机号隐藏中间四位
 */
+ (NSString *)replaceMobileWithMobileString:(NSString *)mobileString;

+ (NSString *)replaceMethodWithMethodString:(NSString *)method;


+ (BOOL)checkLogin;

+ (BOOL)isValidateEmail:(NSString *)email;

+ (void)logout;

+ (NSMutableString *)setGoodsDetailHtmlWithImageArr:(NSArray *)imageArr;

//设置渐变色
+ (CAGradientLayer *)setGradualChangingColorWithFrame:(CGRect)frame;

+ (CAGradientLayer *)setOrangeGradualChangingColorWithFrame:(CGRect)frame;

+ (CAGradientLayer *)setPurpleGradualChangingColorWithFrame:(CGRect)frame;

+ (CAGradientLayer *)setGoldGradualChangingColorWithFrame:(CGRect)frame;

//设置渐变色
+ (CAGradientLayer *)setGradualChangingColorWithFrame:(CGRect)frame fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;


@end
