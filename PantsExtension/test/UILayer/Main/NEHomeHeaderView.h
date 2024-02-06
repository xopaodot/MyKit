//
//  NEHomeHeaderView.h
//  NetworkExtension
//
//  Created by daxiong on 2019/12/4.
//  Copyright © 2019 moonmd.xie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NEHomeHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *passBtn;
@property (weak, nonatomic) IBOutlet UIImageView *adImageView;
@property (weak, nonatomic) IBOutlet UIView *adView;

@end

NS_ASSUME_NONNULL_END
