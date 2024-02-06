//
//  AFHTTPSessionManager+SharedInstance.h
//  WYTask
//
//  Created by YeFeixiang on 7/24/15.
//  Copyright (c) 2015 Guahao.com. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFHTTPSessionManager (SharedInstance)
+ (instancetype)sharedInstance;
@end
