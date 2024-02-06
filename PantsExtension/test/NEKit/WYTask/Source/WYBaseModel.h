//
//  WYBaseModel.h
//  WYPatient
//
//  Created by Fly on 14-6-18.
//  Copyright (c) 2014年 FLy. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "NSObject+ModelAdditions.h"

@interface WYBaseModel : NSObject

/**
 *  提示信息
 */
@property (nonatomic, copy) NSString *message;

/**
 *  成功0
 */
@property (nonatomic, strong) NSNumber *code;

/**
 *  数组返回
 */
@property (nonatomic, strong) NSArray *dl;

/**
 *  字典返回
 */
@property (nonatomic, strong) NSDictionary *result;

/**
 *  字符串返回
 */
@property (nonatomic, strong) NSString *data;

+ (instancetype)modelObjectWithDict:(NSDictionary *)dict;

//使用dict的key进行解析数据并赋值，id转化为recordId
- (void)parseWithDictKeys:(NSDictionary *)dict;

/**
 *  用class 解析数组原始的数据类型
 *
 *  @param cls      解析的Class，解析后的数组存储的都是该类型的Class
 *
 *  @param NSArray* 需要解析的数据源
 *
 *  @return 解析后的结果数组
 */

- (NSArray *)parseSubItemList:(NSArray *)oriItemList withClass:(Class)cls;

@end
