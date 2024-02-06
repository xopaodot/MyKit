//
//  AFHTTPSessionManager+SharedInstance.m
//  WYTask
//
//  Created by YeFeixiang on 7/24/15.
//  Copyright (c) 2015 Guahao.com. All rights reserved.
//

#import "AFHTTPSessionManager+SharedInstance.h"
#import "WYJSONRequestSerializer.h"

@implementation AFHTTPSessionManager (SharedInstance)
+ (instancetype)sharedInstance
{
    static AFHTTPSessionManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *host = @"https://api.ppis.best/";
        sharedManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:host]];
        sharedManager.requestSerializer = [[WYJSONRequestSerializer alloc] init];
        sharedManager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    });
    return sharedManager;
}
@end
