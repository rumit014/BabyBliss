//
//  MyScheduledSessionsTableViewCell.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/28/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "MyScheduledSessionsTableViewCell.h"

@implementation MyScheduledSessionsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.cornerRadius = 20.0;
    self.btnComplete.layer.cornerRadius = 10.0;
    self.btnDrop.layer.cornerRadius = 10.0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
