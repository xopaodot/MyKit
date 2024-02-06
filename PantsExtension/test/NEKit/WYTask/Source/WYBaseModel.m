//
//  WYBaseModel.m
//  WYPatient
//
//  Created by Fly on 14-6-18.
//  Copyright (c) 2014年 FLy. All rights reserved.
//

#import "WYBaseModel.h"

@implementation WYBaseModel

+ (instancetype)modelObjectWithDict:(NSDictionary *)dict
{
    WYBaseModel *model = [[self alloc] init];
    [model parseWithDictKeys:dict];
    return model;
}

//使用dict的key进行解析数据并赋值

- (void)parseWithDictKeys:(NSDictionary *)dict
{
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSArray *keys = [dict allKeys];
    [keys enumerateObjectsUsingBlock:^(NSString *theKey, NSUInteger idx, BOOL *stop) {
        id value = [dict objectForKey:theKey];
        if (value && ![value isKindOfClass:[NSNull class]]) {
            if ([theKey isEqualToString:@"id"]) {
                [self setValue:value forKey:@"recordId"];
            }else if ([theKey isEqualToString:@"data"]) {
                if ([value isKindOfClass:[NSArray class]]) {
                    [self setValue:value forKey:@"dl"];
                }else if([value isKindOfClass:[NSDictionary class]]){
                    [self setValue:value forKey:@"result"];
                }else{
                    [self setValue:value forKey:@"data"];
                }
            }else {
                [self setValue:value forKey:theKey];
            }
        }
    }];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
#ifdef DEBUG
    NSLog(@"setValue:%@, forUndefinedKey:%@", value, key);
#endif
}

//用class解析数组
- (NSArray *)parseSubItemList:(NSArray *)oriItemList withClass:(Class)cls
{
    if (![oriItemList isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray *itemList = [NSMutableArray array];
    [oriItemList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id itemId = [[cls alloc] init];
        if (itemId && [itemId isKindOfClass:[WYBaseModel class]]) {
            WYBaseModel *itemModel = (WYBaseModel *)itemId;
            [itemModel parseWithDictKeys:obj];
            //            [itemModel autoParseWithDict:obj];
            [itemList addObject:itemModel];
        }
    }];
    return itemList;
}


@end
