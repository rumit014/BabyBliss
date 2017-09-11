//
//  BabySittersListCellTableViewCell.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/4/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "BabySittersListCellTableViewCell.h"

@implementation BabySittersListCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.viewContainer.layer.cornerRadius = 20.0;
    self.imgView.layer.cornerRadius = self.imgView.frame.size.width / 2;
    self.imgView.clipsToBounds = YES;
    self.btnSendrequest.layer.cornerRadius = 5.0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
