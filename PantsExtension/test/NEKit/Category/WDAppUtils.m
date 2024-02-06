//
//  WDAppUtils.m
//  IOS-WeidaiCreditLoan
//
//  Created by ai on 16/4/8.
//  Copyright © 2016年 微贷（杭州）金融信息服务有限公司. All rights reserved.
//

#import "WDAppUtils.h"
//#import "WDEncrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import "UIColor+WDKit.h"
#import "WDStoreData.h"

@implementation WDAppUtils

+ (NSString *)getRandomChars:(NSInteger)count {
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

+ (NSString *)getUtcTmestemp {
    long long date = (long long) [[NSDate date] timeIntervalSince1970] / 1000;
    NSString *utc_tmestemp = [NSString stringWithFormat:@"%lld", date];
    return utc_tmestemp;
}

+ (BOOL)isLegaliPhoneNum:(NSString *)text {
    //** 根据项目需求14[5-7]开头改为14[0-9] */
    NSString *phoneRegex = @"^(0|86|17951)?1[0-9]{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL isMatch = [pred evaluateWithObject:text];
    return isMatch;
}

+(BOOL)isPureNum:(NSString *)string{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]];
    if(string.length > 0){
        return YES;
    }
    return NO;
}

+ (BOOL)judgeStr:(NSString *)str1 with:(NSString *)str2 {
    NSInteger i = [str1 integerValue];
    double string1 = [str2 doubleValue];
    NSInteger string2 = [str2 integerValue];
    if (string1 / i - string2 / i > 0) {
        return NO;
    }
    return YES;
}

+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

+ (NSString *)UnityMoneyString:(NSString *)moneyValue {
    return [NSString stringWithFormat:@"¥%.2f", [moneyValue doubleValue]];
}

+ (NSString *)replaceMobileWithMobileString:(NSString *)mobileString {
    return [mobileString stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}

+ (NSString *)replaceMethodWithMethodString:(NSString *)method
{
    if ([WDAppUtils isBlankString:method]) {
        return @"";
    }
    method = [method stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return [method uppercaseString];
}


+(void)deleteWebCache{
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
    NSError *errors;
    [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    //清除UIWebView的缓存
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
}

+ (BOOL)checkLogin
{
    if ([[self class] isBlankString:getObjectFromUserDefaults(kAccessToken)]) {
        return NO;
    }else{
        return YES;
    }
}
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"^([a-zA-Z0-9._-])+@([a-zA-Z0-9_-])+((\\.[a-zA-Z0-9_-]+)+)$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (void)logout
{
    saveObjectToUserDefaults(@"", kAccessToken);
}

+ (CAGradientLayer *)setGradualChangingColorWithFrame:(CGRect)frame
{
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"0000ca"].CGColor,(__bridge id)[UIColor colorWithHexString:@"ff3ac8"].CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    return gradientLayer;
}

+ (CAGradientLayer *)setOrangeGradualChangingColorWithFrame:(CGRect)frame
{
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"ff9600"].CGColor,(__bridge id)[UIColor colorWithHexString:@"f52846"].CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    return gradientLayer;
}

+ (CAGradientLayer *)setGoldGradualChangingColorWithFrame:(CGRect)frame
{
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"EDC779"].CGColor,(__bridge id)[UIColor colorWithHexString:@"DEB154"].CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    return gradientLayer;
}

+ (CAGradientLayer *)setPurpleGradualChangingColorWithFrame:(CGRect)frame
{
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#783AF3"].CGColor,(__bridge id)[UIColor colorWithHexString:@"#AA53E0"].CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    return gradientLayer;
}

+ (CAGradientLayer *)setGradualChangingColorWithFrame:(CGRect)frame fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor{
    
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor,(__bridge id)toColor.CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    return gradientLayer;
}

+ (NSMutableString *)setGoodsDetailHtmlWithImageArr:(NSArray *)imageArr
{
    return @"<html><head><style>img{max-width: 100%;height:auto;}* {margin:0;padding:0;}body{margin-bottom:134px;}</style></head><body><p>< img align=\'absmiddle\' src=\'//img.alicdn.com/imgextra/i4/2184618391/O1CN012Br7qy1LzIuqX5p_!!2184618391.jpg\' style=\'max-width:750.0px;\' size=\'750x200\' /></p > <p style=\'text-align:center;\'><span style=\'font-size:36.0px;\'><span style=\'font-family:simhei;\'><strong>一款多用途的海盐沐浴盐</strong></span></span></p > <p style=\'text-align:center;\'><span style=\'color:#ff0000;\'><span style=\'font-size:36.0px;\'><span style=\'font-family:simhei;\'><strong><span style=\'background-color:#ffff00;\'>洗脸/洗澡/泡脚/洗鼻等等</span></strong></span></span></span></p > <p style=\'text-align:center;\'><span style=\'font-size:36.0px;\'><span style=\'font-family:simhei;\'><strong>每袋5斤，量大实惠，赠送精致量勺</strong></span></span></p > <p style=\'text-align:center;\'><span style=\'font-size:36.0px;\'><span style=\'font-family:simhei;\'><strong>产品包装袋有具体使用说明</strong></span></span></p > <p style=\'text-align:center;\'>< img align=\'absmiddle\' src=\'//img.alicdn.com/imgextra/i2/2184618391/TB2LsCvqJknBKNjSZKPXXX6OFXa_!!2184618391.jpg\' style=\'max-width:750.0px;\' size=\'750x751\'>< img align=\'absmiddle\' src=\'//img.alicdn.com/imgextra/i1/2184618391/TB2Y9ZTbwZC2uNjSZFnXXaxZpXa_!!2184618391.jpg\' style=\'max-width:750.0px;\' size=\'750x632\'>< img align=\'absmiddle\' src=\'//img.alicdn.com/imgextra/i4/2184618391/TB2v2TRgdcnBKNjSZR0XXcFqFXa_!!2184618391.jpg\' style=\'max-width:750.0px;\' size=\'750x499\'>< img align=\'absmiddle\' src=\'//img.alicdn.com/imgextra/i3/2184618391/TB2zK3TgborBKNjSZFjXXc_SpXa_!!2184618391.jpg\' style=\'max-width:750.0px;\' size=\'750x551\'>< img align=\'absmiddle\' src=\'//img.alicdn.com/imgextra/i1/2184618391/TB2JUTKqRjTBKNjSZFDXXbVgVXa_!!2184618391.jpg\' style=\'max-width:750.0px;\' size=\'750x945\'>< img align=\'absmiddle\' src=\'//img.alicdn.com/imgextra/i3/2184618391/TB2OLDusL9TBuNjy1zbXXXpepXa_!!2184618391.jpg\' style=\'max-width:750.0px;\' size=\'750x661\'>< img align=\'absmiddle\' src=\'//img.alicdn.com/imgextra/i1/2184618391/TB2Nf_GsL5TBuNjSspmXXaDRVXa_!!2184618391.jpg\' style=\'max-width:750.0px;\' size=\'750x571\'>< img align=\'absmiddle\' src=\'//img.alicdn.com/imgextra/i3/2184618391/TB2rategrZnBKNjSZFrXXaRLFXa_!!2184618391.jpg\' style=\'max-width:750.0px;\' size=\'750x554\'>< img align=\'absmiddle\' src=\'//img.alicdn.com/imgextra/i4/2184618391/TB2._IysTlYBeNjSszcXXbwhFXa_!!2184618391.jpg\' style=\'max-width:750.0px;\' size=\'750x547\'>< img align=\'absmiddle\' src=\'//img.alicdn.com/imgextra/i2/2184618391/O1CN013uH37s2Br7wlGji3g_!!2184618391.jpg\' style=\'max-width:750.0px;\' size=\'750x938\'>< img align=\'absmiddle\' src=\'//img.alicdn.com/imgextra/i1/2184618391/O1CN01Z9wqHV2Br7wmsHbDb_!!2184618391.jpg\' style=\'max-width:750.0px;\' size=\'750x838\'>< img align=\'absmiddle\' src=\'//img.alicdn.com/imgextra/i1/2184618391/TB2vprDqHZnBKNjSZFKXXcGOVXa_!!2184618391.jpg\' style=\'max-width:750.0px;\' size=\'750x1200\'>< img align=\'absmiddle\' src=\'//img.alicdn.com/imgextra/i4/2184618391/TB21.omoVXXXXaQXFXXXXXXXXXX_!!2184618391.jpg\' style=\'max-width:750.0px;\' size=\'750x280\'>< img align=\'absmiddle\' src=\'//img.alicdn.com/imgextra/i2/2184618391/TB23EvygdknBKNjSZKPXXX6OFXa_!!2184618391.jpg\' style=\'max-width:750.0px;\' size=\'750x1442\' /></p ><script type='text/javascript'>var imgs = document.getElementsByTagName('img');for(var i = 0; i < imgs.length; i++){var img = imgs[i];img.onload = function(){if(this.naturalWidth < 300||this.naturalHeight < 100){this.style.opacity = 0;}}}</script></body></html>";
    NSString *topStr = @"<html><head><style>img{max-width: 100%;height:auto;}* {margin:0;padding:0;}body{margin-bottom:134px;}</style></head><body>";
    NSString *bottomStr = @"<script type='text/javascript'>var imgs = document.getElementsByTagName('img');for(var i = 0; i < imgs.length; i++){var img = imgs[i];img.onload = function(){if(this.naturalWidth < 300||this.naturalHeight < 100){this.style.opacity = 0;}}}</script></body></html>";
    NSMutableString *bodyStr = [NSMutableString new];
    NSMutableString *htmlStr = [[NSMutableString alloc] initWithString:topStr];
    [htmlStr appendString:bodyStr];
    [htmlStr appendString:bottomStr];
    return htmlStr;
}

@end
