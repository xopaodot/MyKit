//
//  NEUserInfoModel.h
//  NetworkExtension
//
//  Created by daxiong on 2019/11/12.
//  Copyright © 2019 moonmd.xie. All rights reserved.
//

#import "WYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NEUserInfoModel : WYBaseModel

@property (nonatomic, copy) NSString *vmess_id;
@property (nonatomic, copy) NSString *wechat;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *transfer_enable;
@property (nonatomic, copy) NSString *traffic_reset_day;
@property (nonatomic, copy) NSString *speed_limit_per_user;
@property (nonatomic, copy) NSString *speed_limit_per_con;
@property (nonatomic, copy) NSString *remember_token;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *reg_ip;
@property (nonatomic, copy) NSString *referral_uid;
@property (nonatomic, copy) NSString *qq;
@property (nonatomic, copy) NSString *protocol_param;
@property (nonatomic, copy) NSString *pay_way;
@property (nonatomic, copy) NSString *protocol;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *passwd;
@property (nonatomic, copy) NSString *obfs_param;
@property (nonatomic, copy) NSString *obfs;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSString *last_login;
@property (nonatomic, copy) NSString *is_admin;
@property (nonatomic, copy) NSString *recordId;
@property (nonatomic, copy) NSString *expire_time;
@property (nonatomic, copy) NSString *enable_time;
@property (nonatomic, copy) NSString *d;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *ban_time;




@property (nonatomic, strong) NSNumber *balance;
@property (nonatomic, strong) NSNumber *enable;
@property (nonatomic, strong) NSNumber *gender;
@property (nonatomic, strong) NSNumber *level;
@property (nonatomic, strong) NSNumber *port;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *t;
@property (nonatomic, strong) NSNumber *u;
@property (nonatomic, strong) NSNumber *usage;

@end

NS_ASSUME_NONNULL_END
