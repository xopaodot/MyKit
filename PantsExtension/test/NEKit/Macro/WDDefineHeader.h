//
//  WDDefineHeader.h
//  IOS-Weidai
//
//  Created by yaoqi on 16/5/13.
//  Copyright © 2016年 微贷（杭州）金融信息服务有限公司. All rights reserved.
//

#ifndef WDDefineHeader_h
#define WDDefineHeader_h

/**
 *  自定义log
 */
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif
/**
 *  防止循环引用
 */
#define kWeakSelf       __weak __typeof(self)weakSelf = self
#define kStrongSelf     __strong __typeof(weakSelf)strongSelf = weakSelf

/**
 *  强制使用内连函数
 */
#define force_inline __inline__ __attribute__((always_inline))

/**
 *  快捷归档
 */
#define WDKeyedArchiverRootObject(object, filepatch) [NSKeyedArchiver archiveRootObject:object toFile:filepatch];

/**
 *  快捷解档
 */
#define WDKeyedUnarchiverObjectWithFile(filepatch) [NSKeyedUnarchiver unarchiveObjectWithFile:filepatch];

/**
 *  角度
 */
#define kDegreesToRadians(degrees) ((M_PI * degrees) / 180)

/**
 *  导航栏文字大小
 */

#define APP_ALIX_SCHEME @"AliPayDaxiongPlanet"

#define kRecommendGoodsId  -1
#define kOtherStyleId  999


#endif /* WDDefineHeader_h */
