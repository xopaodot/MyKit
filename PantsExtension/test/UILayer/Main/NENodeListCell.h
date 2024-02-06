//
//  NENodeListCell.h
//  NetworkExtension
//
//  Created by daxiong on 2019/11/13.
//  Copyright © 2019 moonmd.xie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NENodeListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;

@property(assign, nonatomic) BOOL isPing;

- (void)configModel:(id)model;

@end

NS_ASSUME_NONNULL_END
