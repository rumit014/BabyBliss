//
//  FeedbackCellTableViewCell.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/27/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "FeedbackCellTableViewCell.h"

@implementation FeedbackCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.viewBack.layer.cornerRadius = 10.0;
    self.imgView.layer.cornerRadius = self.imgView.frame.size.height / 2;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
