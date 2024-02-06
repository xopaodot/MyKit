//
//  WYTask.m
//  WYTask
//
//  Created by YeFeixiang on 7/23/15.
//  Copyright (c) 2015 Guahao.com. All rights reserved.
//

#import "WYTask.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager+SharedInstance.h"

typedef NS_ENUM(int, WYResultCode) {
    WYResultCodeSuccess = 0000,
    WYResultCodeSystemException = -1,
    WYResultCodePermissionLimited = -2,
    WYResultCodeParamsException = -3,
    WYResultCodeVersionException = -4,
    WYResultCodeSignError = -5,
    WYResultCodeTokenInvalid = -6
};

static NSString *const kAppServerDomain = @"WYAppServerDomain";
static NSString *const kAppBusinessDomain = @"WYAppBusinessDomain";

static NSString *const kCode = @"code";
static NSString *const kFlag = @"flag";
static NSString *const kMessage = @"message";
static NSString *const kErrorInfo = @"errorInfo";

static const NSTimeInterval kErrorDelay = 0.3;

static NSMutableArray *backgroundArray;

@interface WYTask ()
@property (nonatomic) BOOL needForceDismissLoadingView;
@property (weak, nonatomic) NSMutableArray *taskArray;
@end

@implementation WYTask

#pragma mark - Life Cycle

- (instancetype)initWithURL:(NSString *)requestURL
{
    self = [super init];
    if (self) {
        _requestURL = requestURL;
        _needAutomaticLoadingView = YES;
        _needAutomaticErrorMessage = YES;
    }
    return self;
}

- (NSMutableArray *)taskArray
{
    if (!_taskArray) {
        if (!self.workingInBackground) {
//            _taskArray = [WYCommonInfo sharedInstance].httpTaskArray;
        } else {
            if (!backgroundArray) {
                backgroundArray = [[NSMutableArray alloc] init];
            }
            _taskArray = backgroundArray;
        }
    }
    return _taskArray;
}

- (void)startWithParams:(id)params success:(WYTaskSuccessBlock)success
{
    [self startWithParams:params success:success failure:nil];
}

- (void)startWithParams:(id)params
                success:(WYTaskSuccessBlock)success
                failure:(WYTaskFailureBlock)failure
{
    [self startWithParams:params requestType:WDRequestTypeGet success:success failure:failure];
}

- (void)startWithParams:(id)params
            requestType:(WDRequestType)requestType
                success:(WYTaskSuccessBlock)success
                failure:(WYTaskFailureBlock)failure
{
    [self addToTaskArray];
    [self showAutomaticLoadingView];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager sharedInstance];
    //https请求
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    policy.validatesDomainName = YES;
    sessionManager.securityPolicy = policy;
#ifdef DEBUG
    NSLog(@"%@", @" ");
    NSLog(@"POST URL: %@ withParams: %@", self.requestURL, params != nil ? params : @"No params");
    NSLog(@"%@", @" ");
#endif
    if (requestType == WDRequestTypePost) {
        self.task = [sessionManager POST:self.requestURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleSuccessTask:task
                       withResponse:responseObject
                            success:success
                            failure:failure];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleFailureTask:task withError:error failure:failure];
            
        }];
    }else if (requestType == WDRequestTypeGet){
        self.task = [sessionManager GET:self.requestURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleSuccessTask:task
                       withResponse:responseObject
                            success:success
                            failure:failure];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleFailureTask:task withError:error failure:failure];

        }];
    }else if (requestType == WDRequestTypePut){
        self.task = [sessionManager PUT:self.requestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleSuccessTask:task
            withResponse:responseObject
                 success:success
                 failure:failure];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleFailureTask:task withError:error failure:failure];
        }];
    }else if (requestType == WDRequestTypeDel){
        self.task = [sessionManager DELETE:self.requestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleSuccessTask:task
            withResponse:responseObject
                 success:success
                 failure:failure];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleFailureTask:task withError:error failure:failure];
        }];
    }
}

- (void)cancel
{
    if (self.task) {
        [self.task cancel];
    }
}

- (void)handleFailureTask:(NSURLSessionDataTask *)task
                withError:(NSError *)error
                  failure:(WYTaskFailureBlock)failure
{
#ifdef DEBUG
    NSLog(@"%@", @" ");
    NSLog(@"POST URL: %@ getError: %@", self.requestURL, error);
    NSLog(@"%@", @" ");
#endif
    [self removeFromTaskArray];
    [self hideAutomaticLoadingView];

    if ([error.domain isEqualToString:kAppServerDomain]) {
        if (error.code == WYResultCodeVersionException) {
        } else if (error.code == WYResultCodeTokenInvalid ||
                   error.code == WYResultCodePermissionLimited) {
            [[NSNotificationCenter defaultCenter]
                postNotificationName:WYHttpRequestPermissionLimitedNotification
                              object:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)),
                           dispatch_get_main_queue(), ^{
                               [[NSNotificationCenter defaultCenter]
                                   postNotificationName:WYPopToRootViewControllerNotification
                                                 object:nil];
                           });
        }
        return; // Server domain error not show real error to user.
    }

    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kErrorDelay * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^(void) {
        if (self.needAutomaticErrorMessage == YES) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    });

    if (failure) {
        failure(error);
    }
}

- (void)handleSuccessTask:(NSURLSessionDataTask *)task
             withResponse:(id)responseObject
                  success:(WYTaskSuccessBlock)success
                  failure:(WYTaskFailureBlock)failure
{
    [self removeFromTaskArray];
    [self hideAutomaticLoadingView];
#ifdef DEBUG
        NSLog(@"%@", @" ");
        NSLog(@"POST URL: %@ getResult: %@", self.requestURL, responseObject);
        NSLog(@"%@", @" ");
#endif
    NSNumber *code = responseObject[kCode];
    if ([code intValue] != 200) {
        [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
    }
        if (success) {
            success(responseObject);
        }
//    }
}

- (NSError *)errorWithDomain:(NSString *)domain code:(int)code message:(NSString *)message

{
    if (!domain || [domain isEqualToString:@""]) {
        return nil;
    }
    if (code == 200) {
        return nil;
    }

    NSDictionary *userInfo = @{};
    if (message && ![message isEqualToString:@""]) {
        userInfo = @{NSLocalizedDescriptionKey : message};
    }
    return [NSError errorWithDomain:domain code:code userInfo:userInfo];
}

- (void)showAutomaticLoadingView
{
    if (self.needAutomaticLoadingView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showWithStatus:@"加载中"];
        });
    }
}

- (void)hideAutomaticLoadingView
{
    if (self.needAutomaticLoadingView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
}

- (void)addToTaskArray
{
    if (self.taskArray) {
        [self.taskArray addObject:self];
    }
}

- (void)removeFromTaskArray
{
    if (self.taskArray) {
        [self.taskArray removeObject:self];
    }
}

@end
