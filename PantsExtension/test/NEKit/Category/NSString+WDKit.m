//
//  NSString+WDHelper.m
//  IOS-WeidaiCreditLoan
//
//  Created by yaoqi on 16/4/10.
//  Copyright © 2016年 微贷（杭州）金融信息服务有限公司. All rights reserved.
//

#import "NSString+WDKit.h"
#include <CommonCrypto/CommonDigest.h>
#import "WDAppUtils.h"

@implementation NSString (WDKit)

- (NSDictionary *)jsonObject {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    return result;
}

- (NSString *)stringWithFormatMoney:(KDataStyle)style {

    NSNumber *money = @([self doubleValue]);
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    if (style == KDataDefaulStyle) {
        [numberFormatter setPositiveFormat:@"###,##0.00;"];
    } else if (style == KDataCommonStyle) {
        [numberFormatter setPositiveFormat:@"¥###,##0.00;"];
    } else if (style == kDataNotCommaStyle) {
        return [self
            stringByReplacingOccurrencesOfString:@","
                                      withString:@""];
    } else if (style == KDataNotDecimalStyle) {
        [numberFormatter setPositiveFormat:@"###,###"];
    }
    NSLog(@"%@",[numberFormatter stringFromNumber:money]);
    return [numberFormatter stringFromNumber:money];
}

+ (NSString *)stringWithFormatMoney:(double)value andStyle:(KDataStyle)style {

    NSNumber *money = @(value);
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    if (style == KDataDefaulStyle) {
        [numberFormatter setPositiveFormat:@"###,##0.00;"];
    } else {
        [numberFormatter setPositiveFormat:@"¥###,##0.00;"];
    }
    return [numberFormatter stringFromNumber:money];
}

- (BOOL)isValidateRegularExpressionWithType:(kVREType)type {
    static NSDictionary *verDict;
    if (!verDict) {
        verDict = @{ @(kVRETypeUsername): @"^.{1,20}$",
                     @(kVRETypeIDCard): @"^.{18}$",
                     @(kVRETypeBankCard): @"(\\d|\\s){16,22}",
                     @(kVRETypePhoneNumber): @"\\d{11}",
                     @(kVRETypeApr): @"^(\\d{1,2}(\\.\\d{1,2})?|100|100.0|100.00)$",
                     @(kVRETypeTender): @"^([0-9]{3,10})$",
                     @(kVRETypePassword): @"^([a-zA-Z]+|\\d+){8,16}$",
                     @(kVRETypeAddressName): @"^.{1,20}$",
                     @(kVRETypePostalcode): @"\\d{6}",
                     @(kVRETypeAddress): @"^.{0,128}$",
                     @(kVRETypeVerifyCode): @"^[A-Za-z0-9]{4}$" };
    }

    if (!verDict[@(type)]) {
        NSLog(@"正则表达式不存在");
        return NO;
    }

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", verDict[@(type)]];
    return [predicate evaluateWithObject:self];
}

- (NSString *)WD_md5 {
    NSData *inputData = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char outputData[CC_MD5_DIGEST_LENGTH];
    CC_MD5([inputData bytes], (unsigned int) [inputData length], outputData);
    NSMutableString *hashStr = [NSMutableString string];
    int i = 0;
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
        [hashStr appendFormat:@"%02x", outputData[i]];
    return hashStr;
}

+ (NSString *)WD_appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)WD_appPlatformVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"DTPlatformVersion"];
}

+ (NSString *)WD_sha1:(NSString *)input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (int) data.length, digest);

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }

    return output;
}

+ (NSString *)WD_randomStrings:(NSInteger)count {
    const NSString *kchartables = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    unichar chars1[count];
    for (NSInteger i = 0; i < count; i++) {
        NSInteger x = arc4random() % 62;
        unichar letter = [kchartables characterAtIndex:x];
        chars1[i] = letter;
    }
    NSString *randomChars = [NSString stringWithCharacters:chars1 length:count];
    return randomChars;
}

+ (NSString *)WD_utcTmestempString {
    long long date = (long long) [[NSDate date] timeIntervalSince1970];
    NSString *utc_tmestemp = [NSString stringWithFormat:@"%lld", date];
    return utc_tmestemp;
}

+ (NSMutableAttributedString *)wd_dynamicString:(NSString *)string foreSize:(CGFloat)size foreColor:(UIColor *)color {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName: [UIFont systemFontOfSize:size]}];
    return attributedStr;
}

+ (NSString *)stringDeleteString:(NSString *)str {
    NSMutableString *str1 = [NSMutableString stringWithString:[str stringByReplacingOccurrencesOfString:@" " withString:@""]];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if (c == ',') { //此处可以是任何字符
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    NSString *newstr = [NSString stringWithString:str1];
    return newstr;
}

+ (NSString *)replaceMobileWithMobileString:(NSString *)mobileString {
    return [mobileString stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}

+ (NSString *)replaceNameWithNameString:(NSString *)name {
    if ([name length] > 2) {
        return [name stringByReplacingCharactersInRange:NSMakeRange(1, 2) withString:@"**"];
    }else if ([name length] == 2){
        return [name stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];
    }else{
        return name;
    }
}


+ (NSString *)wd_stringWithFormatNumber:(NSString *)str {
    NSCharacterSet *nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    int value = [[str stringByTrimmingCharactersInSet:nonDigits] intValue];
    return [NSString stringWithFormat:@"%d", value];
}

//动态计算高度
+ (CGSize)workOutSizeWithStr:(NSString *)str andFont:(NSInteger)fontSize value:(NSValue *)value{
    if (!str) {
        str = @"";
    }
    CGSize size = CGSizeMake(0, 0);
    if (str) {
        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil];
        size=[str boundingRectWithSize:[value CGSizeValue] options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    }
    
    return size;
}

+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if ([WDAppUtils isBlankString:jsonString]) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+(NSString *)jsonStringWithDictionary:(NSDictionary *)dict{
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}


@end
