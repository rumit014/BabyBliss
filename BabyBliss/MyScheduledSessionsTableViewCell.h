//
//  MyScheduledSessionsTableViewCell.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/28/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyScheduledSessionsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblSchedule;
@property (weak, nonatomic) IBOutlet UIButton *btnComplete;
@property (weak, nonatomic) IBOutlet UIButton *btnDrop;

@end
