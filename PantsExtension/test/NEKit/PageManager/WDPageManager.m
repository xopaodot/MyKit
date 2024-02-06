//
//  WDPageManager.m
//  WDPageManager
//
//  Created by dongmx on 15/4/21.
//  Copyright (c) 2015年 dongmx. All rights reserved.
//

#import "WDPageManager.h"
#import <objc/runtime.h>
#import "WDNavigationController.h"

@interface WDPageManager()

- (void)updateViewController:(UIViewController *)viewController withParam:(NSDictionary *)param;
- (UIViewController *)createViewControllerFromName:(NSString *)name param:(NSDictionary *)param;

@end

@implementation WDPageManager

#pragma mark - Life Cycle

- (void)dealloc
{
    
}

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


#pragma mark - Public
#pragma mark Push To Navigation Controller

- (void)pushViewController:(NSString *)viewControllerName
{
    [self pushViewController:viewControllerName withParam:nil];
}


- (void)pushViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param
{
    [self pushViewController:viewControllerName withParam:param animated:YES];
}

- (void)pushViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param animated:(BOOL)animated
{
    UIViewController *viewController = [self createViewControllerFromName:viewControllerName param:param];
    if (!viewController) {
        return;
    }
    
    if (self.currentViewController.navigationController) {
        viewController.hidesBottomBarWhenPushed = YES;
        [self.currentViewController.navigationController pushViewController:viewController animated:animated];
    }
}

#pragma mark Pop View Controller

- (UIViewController*)popViewControllerWithParam:(NSDictionary*)param
{
    NSArray *viewControllers = self.currentViewController.navigationController.viewControllers;
    if([viewControllers count] < 2){
        return nil;
    }

    UIViewController *viewController = [viewControllers objectAtIndex:[viewControllers count] - 2];
    if(!viewController){
        return nil;
    }

    [self updateViewController:viewController withParam:param];
    return [self.currentViewController.navigationController popViewControllerAnimated:YES];
}

- (NSArray*)popToViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param
{
    if(viewControllerName == nil){
        return nil;
    }

    Class viewControllerClass = NSClassFromString(viewControllerName);
    if(viewControllerClass == nil){
        return nil;
    }

    __block UIViewController *viewController = nil;
    NSArray *viewControllers = self.currentViewController.navigationController.viewControllers;
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        if([obj isKindOfClass:viewControllerClass]){
            viewController = obj;
            *stop = YES;
        }
    }];

    NSArray * resultAry = nil;
    if(viewController){
        [self updateViewController:viewController withParam:param];
        resultAry = [self.currentViewController.navigationController popToViewController:viewController
                                                                                animated:YES];
    }
    return resultAry;
}

- (NSArray *)popToRootViewController:(NSDictionary *)param{
    return [self popToRootViewController:param animated:YES];
}


- (NSArray *)popToRootViewController:(NSDictionary *)param animated:(BOOL)animated{
    __block UIViewController *viewController = nil;
    NSArray *viewControllers = self.currentViewController.navigationController.viewControllers;
    viewController = [viewControllers firstObject];

    NSArray * resultAry = nil;
    if(viewController){
        [self updateViewController:viewController withParam:param];
        resultAry = [self.currentViewController.navigationController popToViewController:viewController animated:animated];
    }
    return resultAry;
}


- (UIViewController*)getCurrentShowViewController{
    UIViewController* currentVC = [self.currentViewController.navigationController.viewControllers lastObject];
    NSLog(@"currentVC->%@",NSStringFromClass([currentVC class]));
    return currentVC;
}

- (void)popThenPushViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param animated:(BOOL)animated {
    UINavigationController *nav = self.currentViewController.navigationController;
    if (!nav) {
        return;
    }
    NSArray *popedViewCtrls = nil;
    if (nav.viewControllers.count > 0) {
        popedViewCtrls = @[nav.viewControllers.lastObject];
    }
    [self popCtrlsThenPushWithName:popedViewCtrls pushedViewCtrlName:viewControllerName param:param animated:animated];
    return;
}

- (void)popToRootThenPushViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param animated:(BOOL)animated {
    UINavigationController *nav = self.currentViewController.navigationController;
    if (!nav) {
        return;
    }
    NSMutableArray *popedViewCtrls = nil;
    if (nav.viewControllers.count > 1) {
        popedViewCtrls = [nav.viewControllers mutableCopy];
        [popedViewCtrls removeObjectAtIndex:0];
    }
    [self popCtrlsThenPushWithName:[popedViewCtrls copy] pushedViewCtrlName:viewControllerName param:param animated:animated];
    return;
}

- (void)popToViewControllerThenPushViewController:(NSString *)popToViewControllerName
                             pushedViewController:(NSString *)pushedViewControllerName
                                        withParam:(NSDictionary *)param
                                         animated:(BOOL)animated {
    
    UINavigationController *navController = self.currentViewController.navigationController;
    if (!navController) {
        return ;
    }
    
    NSArray *popedArray = [navController.viewControllers filterArrayForRightOfClassName:popToViewControllerName];
    
    [self popCtrlsThenPushWithName:[popedArray copy] pushedViewCtrlName:pushedViewControllerName param:param animated:animated];
}

- (void)popCtrlsThenPushWithName:(NSArray *)popedViewControllers
              pushedViewCtrlName:(NSString *)pushedViewCtrlName
                           param:(NSDictionary *)param
                        animated:(BOOL)animated
{
    NSArray *pushedViewCtrls = nil;
    UIViewController *viewController = [self createViewControllerFromName:pushedViewCtrlName param:param];
    if (viewController) {
        viewController.hidesBottomBarWhenPushed = YES;
        pushedViewCtrls = @[viewController];
    }
    [self popCtrlsThenPushCtrls:popedViewControllers pushedViewController:pushedViewCtrls animated:animated];
}

/*Discussion:
     The viewController's name in pushedViewCtrlNames array and the param in params array is one-to-one corresponed according the index. That means if the viewController's param is nil, it should be set [NSNull null] in the params array; if all the viewController's param is nil, the params array can be set to nil;
 */
- (void)popCtrlsThenPushWithNames:(NSArray *)popedViewControllers
              pushedViewCtrlNames:(NSArray *)pushedViewCtrlNames
                           params:(NSArray *)params
                         animated:(BOOL)animated
{
    NSArray *viewCtrls = [self createViewCtrlsWithNames:pushedViewCtrlNames params:params];
    [self popCtrlsThenPushCtrls:popedViewControllers pushedViewController:viewCtrls animated:animated];
}

- (void)popCtrlsThenPushCtrls:(NSArray *)popedViewControllers
         pushedViewController:(NSArray *)pushedViewControllers
                     animated:(BOOL)animated
{
    UINavigationController *navController = self.currentViewController.navigationController;
    if (!navController) {
        return;
    }
    
    NSMutableArray *newViewCtrls = [[NSMutableArray alloc] initWithArray:navController.viewControllers];
    [newViewCtrls removeObjectsInArray:popedViewControllers];
    [newViewCtrls addObjectsFromArray:pushedViewControllers];
    [navController setViewControllers:newViewCtrls animated:animated];
}

- (NSArray *)createViewCtrlsWithNames:(NSArray *)viewControllerNames params:(NSArray *)params {
    NSMutableArray *viewCtrls = [[NSMutableArray alloc] init];
    [viewControllerNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *viewCtrlName = obj;
            NSDictionary *param = nil;
            if (idx < params.count && [params[idx] isKindOfClass:[NSDictionary class]]) {
                param = params[idx];
            }
            UIViewController *viewController = [self createViewControllerFromName:viewCtrlName param:param];
            if (viewController) {
                viewController.hidesBottomBarWhenPushed = YES;
                [viewCtrls addObject:viewController];
            }
        }
    }];
    if (viewCtrls.count == 0) {
        return nil;
    }
    else {
        return [viewCtrls copy];
    }
}

#pragma mark Present View Controller

- (void)presentViewController:(NSString *)viewControllerName
{
    [self presentViewController:viewControllerName withParam:nil];
}

- (void)presentViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param
{
    [self presentViewController:viewControllerName withParam:param inNavigationController:NO];
}

- (void)presentViewController:(NSString *)viewControllerName
                    withParam:(NSDictionary *)param
       inNavigationController:(BOOL)isInNavigationController
{
    [self presentViewController:viewControllerName
                      withParam:param
         inNavigationController:isInNavigationController
                       animated:YES];
}

- (void)presentViewController:(NSString *)viewControllerName
                    withParam:(NSDictionary *)param
       inNavigationController:(BOOL)isInNavigationController
                     animated:(BOOL)animated
{
    UIViewController *viewController = [self createViewControllerFromName:viewControllerName param:param];
    if (!viewController) {
        return;
    }
    if (isInNavigationController && self.currentViewController) {
        WDNavigationController *navigationController = [[WDNavigationController alloc] initWithRootViewController:viewController];
        navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.currentViewController presentViewController:navigationController animated:animated completion:nil];
    } else {
        viewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.currentViewController presentViewController:viewController animated:animated completion:nil];
    }
}

- (void)fadeInViewController:(NSString *)viewControllerName withParam:(NSDictionary *)param
{
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_8_3) {
        [self pushViewController:viewControllerName withParam:param animated:YES];
        return;
    }

    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [self.currentViewController.navigationController.view.layer addAnimation:transition forKey:nil];
    self.currentViewController.navigationController.navigationBarHidden = NO;
    
    [self pushViewController:viewControllerName withParam:param animated:NO];
}

- (UIViewController *)fadeOutViewControllerWithParam:(NSDictionary *)param
{
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_8_3) {
        return [self popViewControllerWithParam:param];
    }
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [self.currentViewController.navigationController.view.layer addAnimation:transition forKey:nil];
    self.currentViewController.navigationController.navigationBarHidden = NO;
    
    NSArray *viewControllers = self.currentViewController.navigationController.viewControllers;
    if([viewControllers count] < 2){
        return nil;
    }
    UIViewController *viewController = [viewControllers objectAtIndex:[viewControllers count] - 2];
    if(!viewController){
        return nil;
    }
    [self updateViewController:viewController withParam:param];
    return [self.currentViewController.navigationController popViewControllerAnimated:NO];
}

#pragma mark - Private

- (void)updateViewController:(UIViewController *)viewController withParam:(NSDictionary *)param
{
    NSArray *keys = [param allKeys];
    if ([keys count] == 0) {
        return;
    }
    for (NSString *key in keys) {
        SEL selector = NSSelectorFromString(key);
        if (selector == 0) {
            continue;
        }
        
        if ([viewController respondsToSelector:selector]) {
            id value = [param objectForKey:key];
            [viewController setValue:value forKey:key];
        }
    }
}

- (UIViewController *)createViewControllerFromName:(NSString *)name param:(NSDictionary *)param
{
    if (param && ![param isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    UIViewController *viewController = nil;
    Class class = NSClassFromString(name);
    if (!class || ![class isSubclassOfClass:[UIViewController class]]) {
        //不存在，展示错误页面
        if (_errorViewControllerClassName) {
            viewController = [self createViewControllerFromName:_errorViewControllerClassName param:param];
        }
        if (!viewController) {
            viewController = [self createViewControllerFromName:NSStringFromClass([WDPageErrorViewController class]) param:param];
        }
        return viewController;
    }
    NSString *nibName = [self nibFileName:class];
    if (nibName) {
        viewController = [[class alloc] initWithNibName:nibName bundle:nil];
    } else {
        viewController = [[class alloc] init];
    }
    
    if (param) {
        [self updateViewController:viewController withParam:param];
    }
    
    return viewController;
}

- (NSString*)nibFileName:(Class)theClass {
    BOOL nibFileExist = ([[NSBundle mainBundle] pathForResource:NSStringFromClass(theClass) ofType:@"nib"] != nil);
    //如果没有对应的nib，但是父类不是UIViewController，则继续查找替用父类的nib
    if (nibFileExist == NO
        &&[NSStringFromClass([theClass superclass]) isEqualToString:NSStringFromClass([UIViewController class])] == NO) {
        return [self nibFileName:[theClass superclass]];
    }
    return nibFileExist?NSStringFromClass(theClass):nil;
}

@end


@implementation UINavigationController (popToBeforeClass)

- (void)popToBeforeClass:(Class)theClass animated:(BOOL)animated
{
    BOOL isFromApply = NO;
    NSArray *viewControllers = self.viewControllers;
    UIViewController *vc = nil;
    for (NSInteger i=viewControllers.count-1;i>=0;i--) {
        vc = viewControllers[i];
        if ([vc isKindOfClass:theClass]) {
            isFromApply = YES;
            break;
        }
    }
    if (isFromApply) {
        NSUInteger i = [viewControllers indexOfObject:vc];
        if (i>0) {
            vc = viewControllers[i-1];
        }
        [self popToViewController:vc animated:YES];
    } else {
        [self popViewControllerAnimated:YES];
    }
}

@end


@implementation UIViewController (WYPageManager)

+ (void)load {
    NSString *className = NSStringFromClass(self.class);
    NSLog(@"classname %@", className);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzledWithOriginalMethod:@selector(viewWillAppear:) swizzledMethod:@selector(WYPM_viewWillAppear:)];
        [self swizzledWithOriginalMethod:@selector(viewDidAppear:) swizzledMethod:@selector(WYPM_viewDidAppear:)];
    });
}

+ (void)swizzledWithOriginalMethod:(SEL)originalSelector swizzledMethod:(SEL)swizzledSelector {
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (BOOL)isViewController
{
    if ([self respondsToSelector:@selector(navigationController)]&&self.navigationController) {
        return YES;
    }
    return NO;
}

- (void)WYPM_viewWillAppear:(BOOL)animated
{
    if ([self isViewController]) {
        [WDPageManager sharedInstance].currentViewController = self;
    }
    //        [self WYPM_viewWillAppear:animated];
}

- (void)WYPM_viewDidAppear:(BOOL)animated
{
    if ([self isViewController]) {
        [WDPageManager sharedInstance].currentViewController = self;
        [WDPageManager sharedInstance].currentLoadedViewController = self;
    }
    //        [self WYPM_viewDidAppear:animated];
}

@end

@implementation NSArray (WYPageManager)

- (NSArray *)filterViewControllersWithClassName:(NSString*)className {
    NSArray *vcs = [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isMemberOfClass:NSClassFromString(className)];
    }]];
    return vcs;
}

- (NSArray *)filterArrayForRightOfClassName:(NSString *)className {
    if (self == nil || self.count == 0) {
        return nil;
    }
    NSArray *filterArray = [self filterViewControllersWithClassName:className];
    if (filterArray.count == 0) {
        return nil;
    }
    else {
        id obj = [filterArray lastObject];
        NSUInteger index = [self indexOfObject:obj];
        if (index == NSNotFound || index >= self.count) {
            return nil;
        }
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self];
        [array removeObjectsInRange:NSMakeRange(0, index + 1)];
        return [array copy];
    }
}

@end
