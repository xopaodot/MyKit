//
//  WDWKWebViewController.h
//  IOS-Weidai
//
//  Created by ai on 16/9/3.
//  Copyright © 2016年 Loans365. All rights reserved.
//

#import "BaseViewController.h"


@interface WDWKWebViewController : BaseViewController


@property (nonatomic, copy)NSString *requestURL;
@property (nonatomic) BOOL isPost;
@property (nonatomic, strong) NSString *postParams;


@end
