//
//  EnterNameViewController.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/4/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRequestViewController.h"

@interface EnterNameViewController : UIViewController

@property (weak,nonatomic) id<DataEnteredDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *xttFieldLastName;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end
