//
//  FeedbackCellTableViewCell.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/27/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIView *viewBack;

@end
