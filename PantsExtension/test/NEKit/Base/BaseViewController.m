//
//  BaseViewController.m
//  doctor
//
//  Created by mardin partytime on 13-6-25.
//  Copyright (c) 2013年 mardin partytime. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (strong, nonatomic) BackBlock block;

@end

@implementation BaseViewController

#pragma mark - Life Cycle

- (void)dealloc
{
    //wujuan.begin
    if ([self.taskArray count] > 0) {
//        for (WYTask *task in self.taskArray) {
//            [task cancel];
//        }
    }
    //wujuan.end
    NSLog(@"%@: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    [self hideLoadingView];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //leon.begin
    _lifeState = WYViewLifeCircleState_DidLoad;
    //leon.end

    // iOS7 Transition: Fix the issue that navigation bar overlapped on normal view.
        self.edgesForExtendedLayout = UIRectEdgeNone;
//    MLOG(@"%d",[self.navigationController.childViewControllers count]);
    if ([self.navigationController.childViewControllers count] > 1) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 40, 40);
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backBarButtonItem;
    }
    self.navigationController.navigationBar.translucent = NO;
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 0.5)];
//    lineView.backgroundColor = WD_ebebeb_Color;
//    [self.navigationController.navigationBar addSubview:lineView];
}

//leon.begin
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _lifeState = WYViewLifeCircleState_WillAppear;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}
//leon.end

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    [WYPageManager sharedInstance].currentViewController = self;
//    [WYPageManager sharedInstance].needNibFile = YES;
    
#if !(TARGET_IPHONE_SIMULATOR)
//    [[BaiduMobStat defaultStat] pageviewStartWithName:self.title];
#endif

    //leon.begin
    //open ios 7 pop back gesture
    _lifeState = WYViewLifeCircleState_DidAppear;
    //leon.end

}

//leon.begin
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _lifeState = WYViewLifeCircleState_WillDisappear;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }

}

//leon.end

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
#if !(TARGET_IPHONE_SIMULATOR)
//    [[BaiduMobStat defaultStat] pageviewEndWithName:self.title];
#endif

    //leon.begin
    _lifeState = WYViewLifeCircleState_DidDisappear;
    //leon.end

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Custom Accessors

- (NSMutableArray *)taskArray
{
    if (!_taskArray) {
        _taskArray = [[NSMutableArray alloc] init];
    }
    return _taskArray;
}

#pragma mark - Public

- (void)back
{
    if ([self.taskArray count] > 0) {
        for (int i = 0; i < [self.taskArray count]; i++) {
//            WYTask *task = self.taskArray[i];
//            [task cancel];
        }
    }

    if (self && self.block) {
        self.block();
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)backBlock:(BackBlock)block
{
    if (block) {
        self.block = block;
    }
}

- (void)showLoadingView
{
    [SVProgressHUD showWithStatus:@"加载中"];
}

- (void)hideLoadingView
{
    [SVProgressHUD dismiss];
}

- (void)showSuccessWithStatus:(NSString *)message
{
    [SVProgressHUD showSuccessWithStatus:message];
}

- (void)createRightButtonWithTitle:(NSString *)title
{
    if(title == nil){
        self.navigationItem.rightBarButtonItem = nil;
        return;
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(rightBtnClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)createRightButtonWIthImage:(UIImage *)image
{
    if(image == nil){
        self.navigationItem.rightBarButtonItem = nil;
        return;
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(rightBtnClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)rightBtnClick:(id)sender
{

}

- (void)toast:(NSString *)toast
{
//    [self.view makeToast:toast duration:2. position:CSToastPositionCenter];
    [SVProgressHUD showInfoWithStatus:toast];

}


//leon.begin
#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if(self.lifeState <= WYViewLifeCircleState_WillAppear){
        return NO;
    }

    if (self.isCloseGesture) {
        return NO;
    }
    
    BOOL bRet = NO;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if([self.navigationController.viewControllers count] > 1){
            bRet = YES;
        }
        else{
            bRet = NO;
        }
    }
    return bRet;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}
//leon.end

@end
