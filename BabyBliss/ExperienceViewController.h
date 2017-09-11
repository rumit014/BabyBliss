//
//  ExperienceViewController.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/11/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRequestViewController.h"

@interface ExperienceViewController : UIViewController
@property (weak,nonatomic) id<DataEnteredDelegate> delegate;
- (IBAction)btnExperienceAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldExpereince;

@end
