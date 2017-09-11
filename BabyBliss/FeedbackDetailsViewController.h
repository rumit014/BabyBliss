//
//  FeedbackDetailsViewController.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/28/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feedback.h"
#import "ParentProfile.h"
#import "BabysitterProfile.h"

@interface FeedbackDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (strong,nonatomic) Feedback *feedback;
@property (strong,nonatomic) ParentProfile *parent;
@property (strong,nonatomic) BabysitterProfile *babysitter;
@end
