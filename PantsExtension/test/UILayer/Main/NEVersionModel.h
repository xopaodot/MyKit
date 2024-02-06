//
//  NEVersionModel.h
//  NetworkExtension
//
//  Created by daxiong on 2019/12/19.
//  Copyright © 2019 moonmd.xie. All rights reserved.
//

#import "WYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NEVersionModel : WYBaseModel

@property (nonatomic, copy) NSString *force_ios_version;
@property (nonatomic, copy) NSString *ios_version;
@property (nonatomic, copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
