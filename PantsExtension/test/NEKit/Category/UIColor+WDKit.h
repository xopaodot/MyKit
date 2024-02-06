//
//  UIColor+CMColorExt.h
//  advisor
//
//  Created by lhb on 15/5/12.
//  Copyright (c) 2015年 chemao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WDKit)

/**
 *  返回一个RGBA格式的UIColor对象
 */
#define RGBA(r, g, b, a) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]

/**
 *  返回一个RGB格式的UIColor对象
 */
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)

/**
 *  从HEX字符串得到一个UIColor对象
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 *  从HEX数值得到一个UIColor对象
 */
+ (UIColor *)colorWithHex:(unsigned int)hex;

/**
 *  从HEX数值和Alpha数值得到一个UIColor对象
 */
+ (UIColor *)colorWithHex:(unsigned int)hex
                    alpha:(float)alpha;

/**
 *  创建一个随机UIColor对象
 */
+ (UIColor *)randomColor;

/**
 *  从已知UIColor对象和Alpha对象得到一个UIColor对象
 */
+ (UIColor *)colorWithColor:(UIColor *)color
                      alpha:(float)alpha;

//UIColor 转UIImage
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
