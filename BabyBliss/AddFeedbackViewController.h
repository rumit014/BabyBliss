//
//  AddFeedbackViewController.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/28/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BabysitterProfile.h"
#import "ParentProfile.h"
#import "Request.h"
#import "Feedback.h"
#import "FeedbackManager.h"

@interface AddFeedbackViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewHeaderback;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblBio;
@property (weak, nonatomic) IBOutlet UITextView *txtViewReview;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldRating;
@property (strong,nonatomic) Request *request;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
- (IBAction)btnSubmit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@end
