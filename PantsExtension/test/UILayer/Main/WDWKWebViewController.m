//
//  WDWKWebViewController.m
//  IOS-Weidai
//
//  Created by ai on 16/9/3.
//  Copyright © 2016年 Loans365. All rights reserved.
//

#import "WDWKWebViewController.h"
#import <WebKit/WebKit.h>
#import <SDWebImage/SDImageCache.h>

@interface WDWKWebViewController ()<WKNavigationDelegate,WKScriptMessageHandler, WKUIDelegate, UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)WKWebView *wkWebView;

//返回按钮
@property (nonatomic, strong) UIBarButtonItem *backItem;
//关闭按钮
@property (nonatomic, strong) UIBarButtonItem *closeItem;

@property (nonatomic, strong)CALayer *progresslayer;

/**
 *  记录每个页面是否分享以及分享的内容
 */
@property (nonatomic, strong)NSMutableDictionary *shareMutableDict;

//是否可以滑动返回
@property (nonatomic, assign)BOOL isCanSideBack;

/**
 *  摇动次数
 */
@property (nonatomic, assign) NSInteger mationNumber;

@property (strong, nonatomic) NSString *toTaobaoStr;

@property (assign, nonatomic) BOOL needReload;


@end

@implementation WDWKWebViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置允许摇一摇功能
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    // 并让自己成为第一响应者
    [self becomeFirstResponder];
    self.mationNumber = 0;
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    UIView *barBack = self.navigationController.navigationBar.subviews[0];
    barBack.backgroundColor = [UIColor clearColor];
    [barBack setAlpha:1];

    WKUserContentController* userContentController = WKUserContentController.new;
    WKWebViewConfiguration* webViewConfig = WKWebViewConfiguration.new;
    webViewConfig.userContentController = userContentController;
    
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-kBottomSafeHeight) configuration:webViewConfig];
    wkWebView.scrollView.delegate = self;
    wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    wkWebView.backgroundColor = WD_fafafa_Color;
    wkWebView.navigationDelegate = self;
    wkWebView.UIDelegate = self;
//    wkWebView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:wkWebView];
    [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    self.wkWebView = wkWebView;
    
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 2);
    layer.backgroundColor = WD_Main_Yellow_Color.CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
    
    self.shareMutableDict = [NSMutableDictionary dictionary];
    
    [self loadWebView];
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.needReload == YES) {
        [self.wkWebView reload];
        self.needReload = NO;
    }
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if (obj.tag == 10) {
            [obj removeFromSuperview];
        }
    }];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.progresslayer removeFromSuperlayer];
    self.isCanSideBack = YES;
    //开启ios右滑返回
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.wkWebView canGoBack]) {
        self.isCanSideBack = NO;
    }else{
        self.isCanSideBack = YES;
    }
    //关闭ios右滑返回
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate=self;
    }
}

- (void)dealloc{
    @try{
        [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress" context:nil];
    } @catch(id anException) {
        //do nothing, obviously it wasn't attached because an exception was thrown
    }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    self.mationNumber += 1;
    NSString *javaScriptString = [NSString stringWithFormat:@"callBackmotionEvent(%zd)",self.mationNumber];
    [self.wkWebView evaluateJavaScript:javaScriptString completionHandler:^(id _Nullable response, NSError * _Nullable error) {
    }];
}

#pragma mark - action event
-(void)back{
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
//        if (IOS9_OR_LATER) {
//            [self.wkWebView reload];
//        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}



-(void)closeNative{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private method
-(void)loadWebView{    
    //** 设置请求头信息 */
    NSString *mutaleRequest = [self.requestURL mutableCopy];
    if ([self.requestURL containsString:@"riceboom.cn"] && [WDAppUtils checkLogin]) {
        if ([self.requestURL containsString:@"?"]) {
            self.requestURL = [mutaleRequest stringByAppendingFormat:@"&accessToken=%@&version=%@&userAgent=2",getObjectFromUserDefaults(kAccessToken),[self clientVersion]];
        }else{
            self.requestURL = [mutaleRequest stringByAppendingFormat:@"?accessToken=%@&version=%@&userAgent=2",getObjectFromUserDefaults(kAccessToken),[self clientVersion]];
        }
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.requestURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];

//    [request setValue:@"application/json" forHTTPHeaderField:@"accept"];
//    [request setValue:@"1" forHTTPHeaderField:@"device"];
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    [request setValue:version forHTTPHeaderField:@"device_version"];
//    [request setValue:@"AppStore" forHTTPHeaderField:@"channel_code"];
//    if (![WDAppUtils isBlankString:getObjectFromUserDefaults(kAccessToken)]) {
//        [request setValue:getObjectFromUserDefaults(kAccessToken) forHTTPHeaderField:kAccessToken];
//    }
//    [request setValue:@"application/json" forHTTPHeaderField:@"mac"];
////    [request addValue:[self readCurrentCookie] forHTTPHeaderField:@"Cookie"];
//    if (self.isPost == YES) {
//        [request setHTTPMethod: @"POST"];
//        [request setHTTPBody: [self.postParams dataUsingEncoding: NSUTF8StringEncoding]];
//    }
//    for (NSDictionary *dic in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
//        NSLog(@"cookie**-%@",dic);
//    }
    [self.wkWebView loadRequest:request];
}

- (NSString*)readCurrentCookie{
    NSHTTPCookieStorage*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSMutableString *cookieString = [[NSMutableString alloc] init];
    for (NSHTTPCookie*cookie in [cookieJar cookies]) {
        [cookieString appendFormat:@"%@=%@;",cookie.name,cookie.value];
    }
    //删除最后一个“；”
    [cookieString deleteCharactersInRange:NSMakeRange(cookieString.length - 1, 1)];
    return cookieString;
    
}

- (NSString *)clientVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        WDWeakSelf;
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 2);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.progresslayer.frame = CGRectMake(0, 0, 0, 2);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (NSString*) _evaluateJavascript:(NSString*)javascriptCommand
{
    return javascriptCommand;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view{
    [scrollView.pinchGestureRecognizer setEnabled:NO];
}



#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.isCanSideBack;
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
//    if ([message.name isEqualToString:@"getSetpCount"]) {
//        WS(weakSelf)
//        WDHealthKitManage *manage = [WDHealthKitManage shareInstance];
//        [manage authorizeHealthKit:^(BOOL success, NSError *error) {
//            if (success) {
//                [manage getStepCount:^(double value,BOOL authorizationStatus, NSError *error) {
//                    NSString *valueString = [NSString stringWithFormat:@"%.0f",value];
//                    NSString *javaScriptString = [NSString stringWithFormat:@"callBackSetpCount(%@,%@)",valueString,authorizationStatus? @"true" : @"false"];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [weakSelf.wkWebView evaluateJavaScript:javaScriptString completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//                        }];
//                    });
//                }];
//            }
//            else {
//            }
//        }];
//    }
}

#pragma mark - WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
}

#pragma mark - WKNavigationDelegate
/**
 *  页面开始加载时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
    NSString *path= [webView.URL absoluteString];
    NSString * newPath = [path lowercaseString];
    if ([newPath hasPrefix:@"sms:"] || [newPath hasPrefix:@"tel:"]) {
        UIApplication * app = [UIApplication sharedApplication];
        if ([app canOpenURL:[NSURL URLWithString:newPath]]) {
            [app openURL:[NSURL URLWithString:newPath]];
        }
        return;
    }
}

/**
 *  当内容开始返回时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}
/**
 *  页面加载完成之后调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    for (NSDictionary *dic in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        NSLog(@"cookie-----%@",dic);
    }
    if ([self.requestURL rangeOfString:@"statistic/tradeData"].location == NSNotFound) {
        self.navigationItem.title = webView.title;
    }else{
        self.navigationItem.title = @"";
    }
    if ([self.wkWebView canGoBack]) {
        self.isCanSideBack = NO;
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftBarButtonItems = @[self.backItem,self.closeItem];
    }else{
        self.isCanSideBack = YES;
        self.navigationItem.leftBarButtonItems = nil;
        self.navigationItem.leftBarButtonItem = self.backItem;
    }
}

/**
 *  加载失败时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 *  @param error      错误
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s-----%@", __FUNCTION__,error);
}
/**
 *  接收到服务器跳转请求之后调用
 *
 *  @param webView      实现该代理的webviewx
 *  @param navigation   当前navigation
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}
/**
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//    // 如果响应的地址是我们服务器地址跳转，则允许跳转
    NSLog(@"%@",navigationResponse.response.URL);
//    NSLog(@"%@",navigationResponse.response.URL.host.lowercaseString);
//
//    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
//    // 获取cookie,并设置到本地
//    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
//    for (NSHTTPCookie *cookie in cookies) {
//        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
//    }
    decisionHandler(WKNavigationResponsePolicyAllow);
//    return;
    //    }
    // 不允许跳转
    //    decisionHandler(WKNavigationResponsePolicyCancel);
}
/**
 *  在发送请求之前，决定是否跳转
 *
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if(webView != self.wkWebView) {
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    NSURL  *url = navigationAction.request.URL;
    
    NSString *requestString = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    
    if ([navigationAction.request.URL.absoluteString containsString:@"alipay://"] || [navigationAction.request.URL.absoluteString containsString:@"weixin://"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        
        if ([[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL]) {
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                }];
                
            }else{
                [[UIApplication sharedApplication] openURL:webView.URL];
            }
            
        }
        return;
    }
    NSArray *arr = [requestString componentsSeparatedByString:@"?"];
    if (arr.count > 1 && [arr[0] containsString:@"detail"]) {
        NSString *itemIdStr = [self getItemIdWithUrl:requestString];
        if ([WDAppUtils isBlankString:itemIdStr]) {
            decisionHandler(WKNavigationActionPolicyAllow);
        }else{
            decisionHandler(WKNavigationActionPolicyCancel);
            [[WDPageManager sharedInstance] pushViewController:@"WFGoodsDetailViewController" withParam:@{@"itemUrl":requestString,@"itemId":[self getItemIdWithUrl:requestString]}];
        }
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    return;
}

- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (NSString *)getItemIdWithUrl:(NSString *)url
{
    NSString *itemId = [NSString new];
    NSArray *arr = [url componentsSeparatedByString:@"?"];
    if (arr.count < 2) {
        return nil;
    }
    NSString *paramsStr = [arr objectAtIndex:1];
    NSArray *arr1 = [paramsStr componentsSeparatedByString:@"&"];
    for (NSString *str in arr1) {
        NSArray *arr2 = [str componentsSeparatedByString:@"="];
        if (arr2.count>1&&[[arr2 firstObject] isEqualToString:@"item_id"]) {
            itemId = arr2[1];
        }
    }
    if ([WDAppUtils isBlankString:itemId]) {
        for (NSString *str in arr1) {
            NSArray *arr2 = [str componentsSeparatedByString:@"="];
            if (arr2.count>1&&[[arr2 firstObject] isEqualToString:@"id"]) {
                itemId = arr2[1];
            }
        }
    }
    return itemId;
}


- (NSString *)encodeToPercentEscapeString:(NSString *)dataStr{
    NSString *outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                             NULL, /* allocator */
                                                                             (__bridge CFStringRef)dataStr,
                                                                             NULL, /* charactersToLeaveUnescaped */
                                                                             (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                             kCFStringEncodingUTF8);
    return outputStr;
}

#pragma mark - setters && getters
-(UIBarButtonItem *)backItem{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    return _backItem;
}

- (UIBarButtonItem *)closeItem{
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeNative)];
        [_closeItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17], NSFontAttributeName, WD_333333_Color, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    }
    return _closeItem;
}

@end
