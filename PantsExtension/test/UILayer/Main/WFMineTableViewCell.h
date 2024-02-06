//
//  WFMineTableViewCell.h
//  JiMei
//
//  Created by daxiong on 2019/4/12.
//  Copyright © 2019 大熊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WFMineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@end

NS_ASSUME_NONNULL_END
