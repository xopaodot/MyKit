//
//  BaseViewController.h
//  doctor
//
//  Created by mardin partytime on 13-6-25.
//  Copyright (c) 2013年 mardin partytime. All rights reserved.
//

#import <UIKit/UIKit.h>

//leon.begin
typedef NS_ENUM(NSInteger, WYViewLifeCircleState){
    WYViewLifeCircleState_UnKnown = -1,
    WYViewLifeCircleState_DidLoad = 0,
    WYViewLifeCircleState_WillAppear = 1,
    WYViewLifeCircleState_DidAppear = 2,
    WYViewLifeCircleState_WillDisappear = 3,
    WYViewLifeCircleState_DidDisappear = 4,
};
//leon.end


typedef void(^BackBlock)(void);

@interface BaseViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) NSMutableArray *taskArray;
@property (assign, nonatomic, readonly) WYViewLifeCircleState lifeState;
@property (assign, nonatomic) BOOL isCloseGesture;//Jim 关闭Back手势

- (void)back;
- (void)backBlock:(BackBlock)block;//Jim Pop到指定的Controller
- (void)showLoadingView;
- (void)hideLoadingView;
- (void)showSuccessWithStatus:(NSString *)message;//静止1秒钟
- (void)toast:(NSString *)toast;
- (void)createRightButtonWithTitle:(NSString *)title;
- (void)createRightButtonWIthImage:(UIImage *)image;

@end
