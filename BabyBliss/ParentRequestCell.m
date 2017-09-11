//
//  ParentRequestCell.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/12/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "ParentRequestCell.h"

@implementation ParentRequestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.cornerRadius = 20.0;
    self.imgView.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius = self.imgView.frame.size.height / 2;
    self.btnDEny.layer.cornerRadius = 10.0;
    self.btnAccept.layer.cornerRadius = 10.0;
    self.btnAccept.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.btnDEny.layer.borderColor = [UIColor darkGrayColor].CGColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
