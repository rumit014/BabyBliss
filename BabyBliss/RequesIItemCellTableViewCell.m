//
//  RequesIItemCellTableViewCell.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/4/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "RequesIItemCellTableViewCell.h"

@implementation RequesIItemCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.viewContainer.layer.cornerRadius = 10.0;
    self.viewContainer.layer.borderColor = [UIColor blackColor].CGColor;
    self.viewContainer.layer.borderWidth = 1.5;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
