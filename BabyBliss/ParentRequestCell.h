//
//  ParentRequestCell.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/12/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentRequestCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblSchedule;
@property (weak, nonatomic) IBOutlet UILabel *lblParentName;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnDEny;
@property (weak, nonatomic) IBOutlet UIButton *btnAccept;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
