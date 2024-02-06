//
//  NENodeListCell.m
//  NetworkExtension
//
//  Created by daxiong on 2019/11/13.
//  Copyright © 2019 moonmd.xie. All rights reserved.
//

#import "NENodeListCell.h"
#import "NENodeListModel.h"

@interface NENodeListCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *nameImageView;

@end

@implementation NENodeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.nameImageView.layer.cornerRadius = 3.;
    self.nameImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configModel:(NENodeListModel *)model
{
    self.nameLabel.text = model.name;
    self.speedLabel.text = model.speed?:@"";
    self.nameImageView.image = [UIImage imageNamed:model.country_code];
    
}




@end
