//
//  EnterPriceCapViewController.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/11/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRequestViewController.h"

@interface EnterPriceCapViewController : UIViewController
@property (weak,nonatomic) id<DataEnteredDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveAction;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldPriceCap;
- (IBAction)btnSaveAction:(id)sender;

@end
