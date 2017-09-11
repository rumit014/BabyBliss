//
//  EnterLocationViewController.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/11/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRequestViewController.h"


@interface EnterLocationViewController : UIViewController

@property (weak,nonatomic) id<DataEnteredDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldLocation;
- (IBAction)btnSaveAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewMap;

@end
