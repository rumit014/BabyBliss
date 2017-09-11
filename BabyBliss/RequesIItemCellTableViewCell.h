//
//  RequesIItemCellTableViewCell.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/4/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequesIItemCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblParamName;
@property (weak, nonatomic) IBOutlet UILabel *lblParamValue;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@end
