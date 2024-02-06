//
//  WYJSONRequestSerializer.m
//  PalmHospital
//
//  Created by leon on 14-3-12.
//  Copyright (c) 2014年 lvxian. All rights reserved.
//

#import "WYJSONRequestSerializer.h"
#define AUTH_TOKEN @"Authorization"
#define AUTH_AGENT @"userAgent"
#define AUTH_VERSION @"ver"
#define AUTH_OS_VERSION @"os-version"
#define AUTH_ACCEPT @"Accept"
#define AUTH_SIGN @"sign"
#define AUTH_TYPE @"version-type"
#define AUTH_APPID @"appid"
#define AUTH_UUID @"os-token-id"
#define AUTH_MERCHANTID @"merchantId"

@interface WYJSONRequestSerializer ()
@property (strong, nonatomic) NSString *clientVersion;
@end

@implementation WYJSONRequestSerializer

//覆盖此方法，以便于添加请求头信息以及一些定制化
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(NSDictionary *)parameters
                                     error:(NSError *__autoreleasing *)error
{
    [self setTimeoutInterval:60.0];
    // set http header
//    [self setValue:@"2" forHTTPHeaderField:AUTH_AGENT];
//    [self setValue:self.clientVersion forHTTPHeaderField:AUTH_VERSION];
//    [self setValue:[self osVersion] forHTTPHeaderField:AUTH_OS_VERSION];
    [self setValue:@"application/json" forHTTPHeaderField:AUTH_ACCEPT];
    if (![WDAppUtils isBlankString:getObjectFromUserDefaults(kAccessToken)]) {
        [self setValue:getObjectFromUserDefaults(kAccessToken) forHTTPHeaderField:AUTH_TOKEN];
    }else{
        [self setValue:@"" forHTTPHeaderField:kAccessToken];
    }
    return [super requestWithMethod:method URLString:URLString parameters:parameters error:error];
}


- (NSString *)clientVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (NSString *)osVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
@end
