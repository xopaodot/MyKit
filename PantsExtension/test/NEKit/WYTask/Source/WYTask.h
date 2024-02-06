//
//  WYTask.h
//  WYTask
//
//  Created by YeFeixiang on 7/23/15.
//  Copyright (c) 2015 Guahao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, WDRequestType) {
    WDRequestTypePost = 0,
    WDRequestTypeGet = 1,
    WDRequestTypePut = 2,
    WDRequestTypeDel = 3
};

static NSString *const WYHttpRequestPermissionLimitedNotification =
    @"WYHttpRequestPermissionLimitedNotification";

static NSString *const WYPopToRootViewControllerNotification = @"WYPopToRootViewControllerNotification";

typedef void (^WYTaskSuccessBlock)(id responseObject);
typedef void (^WYTaskFailureBlock)(NSError *error);

@interface WYTask : NSObject
@property (strong, nonatomic) NSString *requestURL;
@property (weak, nonatomic) NSURLSessionDataTask *task;
@property (nonatomic) BOOL needAutomaticLoadingView;
@property (nonatomic) BOOL needAutomaticErrorMessage;
@property (nonatomic) BOOL workingInBackground;

- (instancetype)initWithURL:(NSString *)requestURL;

- (void)startWithParams:(id)params success:(WYTaskSuccessBlock)success;

- (void)startWithParams:(id)params
                success:(WYTaskSuccessBlock)success
                failure:(WYTaskFailureBlock)failure;


- (void)startWithParams:(id)params
            requestType:(WDRequestType)requestType
                success:(WYTaskSuccessBlock)success
                failure:(WYTaskFailureBlock)failure;

- (void)cancel;

- (void)showAutomaticLoadingView;
- (void)hideAutomaticLoadingView;

- (void)addToTaskArray;
- (void)removeFromTaskArray;

- (void)handleSuccessTask:(NSURLSessionDataTask *)task
             withResponse:(id)responseObject
                  success:(WYTaskSuccessBlock)success
                  failure:(WYTaskFailureBlock)failure;
- (void)handleFailureTask:(NSURLSessionDataTask *)task
                withError:(NSError *)error
                  failure:(WYTaskFailureBlock)failure;

@end
