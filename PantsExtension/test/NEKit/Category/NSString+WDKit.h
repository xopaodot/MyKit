//
//  NSString+WDHelper.h
//  IOS-WeidaiCreditLoan
//
//  Created by yaoqi on 16/4/10.
//  Copyright © 2016年 微贷（杭州）金融信息服务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
typedef enum {
    KDataDefaulStyle,   //默认带逗号（,）
    KDataCommonStyle,   //¥
    kDataNotCommaStyle, //不带逗号
    KDataNotDecimalStyle,  //不带小数的千分符
} KDataStyle;

typedef NS_ENUM(NSUInteger, kVREType) {
    kVRETypeUsername = 0, // 用户名
    kVRETypeIDCard,       // 身份证号码
    kVRETypeBankCard,     // 银行卡号码
    kVRETypePhoneNumber,  // 电话号码
    kVRETypeApr,          // 年化收益
    kVRETypeTender,       // 投资金额
    kVRETypePassword,     // 密码
    kVRETypeAddressName,  // 姓名
    kVRETypePostalcode,   // 邮箱
    kVRETypeAddress,      // 地址
    kVRETypeVerifyCode    // 验证码
};

@interface NSString (WDKit)

- (NSDictionary *)jsonObject;
/**
 *  转换千分符格式
 *
 *  @param str 必须为数字
 *
 *  @return 千分符格式字符
 */
- (NSString *)stringWithFormatMoney:(KDataStyle)style;
+ (NSString *)stringWithFormatMoney:(double)value andStyle:(KDataStyle)style;

/**
 *  校验用户名，身份证号码，银行卡号码，电话号码，年化收益，投资金额，密码，姓名，邮箱，地址，验证码
 *
 *  @param type 校验类型
 *
 *  @return 校验类型结果
 */
- (BOOL)isValidateRegularExpressionWithType:(kVREType)type;

/**
 *  md5加密
 */
- (NSString *)WD_md5;

/**
 *  获取app版本信息
 */
+ (NSString *)WD_appVersion;

/**
 *  获取app平台版本信息
 */
+ (NSString *)WD_appPlatformVersion;

/**
 *  sha1加密
 */
+ (NSString *)WD_sha1:(NSString *)input;

/**
 *  随机多少位字符
 */
+ (NSString *)WD_randomStrings:(NSInteger)count;

/**
 *  获取时间戳
 */
+ (NSString *)WD_utcTmestempString;

/**
 *  富文本
 */
+ (NSMutableAttributedString *)wd_dynamicString:(NSString *)string foreSize:(CGFloat)size foreColor:(UIColor *)color;
/**
 *  删除nsstring中特定的字符
 */
+ (NSString *)stringDeleteString:(NSString *)str;
/**
 *  手机号隐藏中间四位
 */
+ (NSString *)replaceMobileWithMobileString:(NSString *)mobileString;

+ (NSString *)replaceNameWithNameString:(NSString *)name;

/**
 *  取出字符串的数字
 */
+ (NSString *)wd_stringWithFormatNumber:(NSString *)str;

+ (CGSize)workOutSizeWithStr:(NSString *)str andFont:(NSInteger)fontSize value:(NSValue *)value;

/*
*  JSON字符串转化为字典
*/
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/**
 *  字典转json串
 */
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dict;

@end
