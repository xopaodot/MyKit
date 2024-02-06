//
//  NENodeListModel.h
//  NetworkExtension
//
//  Created by daxiong on 2019/11/13.
//  Copyright © 2019 moonmd.xie. All rights reserved.
//

#import "WYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NENodeListModel : WYBaseModel


@property (nonatomic, copy) NSString *v2_type;
@property (nonatomic, copy) NSString *v2_net;
@property (nonatomic, copy) NSString *v2_method;
@property (nonatomic, copy) NSString *v2_insider_port;
@property (nonatomic, copy) NSString *txt;
@property (nonatomic, copy) NSString *ssr_scheme;
@property (nonatomic, copy) NSString *ss_scheme;
@property (nonatomic, copy) NSString *server;
@property (nonatomic, copy) NSString *protocol;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *country_code;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, strong) NSString *speed;


@property (nonatomic, strong) NSNumber *recordId;
@property (nonatomic, strong) NSNumber *bandwidth;
@property (nonatomic, strong) NSNumber *sort;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSNumber *v2_port;
@property (nonatomic, strong) NSNumber *v2_outsider_port;
@property (nonatomic, strong) NSNumber *v2_tls;


@end

NS_ASSUME_NONNULL_END
