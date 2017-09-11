//
//  EnterScheduleViewController.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/11/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRequestViewController.h"
@interface EnterScheduleViewController : UIViewController
@property (weak,nonatomic) id<DataEnteredDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerFrom;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerTo;

@property (weak, nonatomic) IBOutlet UIView *datePickerBackView
;
@property (weak, nonatomic) IBOutlet UIView *datePickerBackView2;
- (IBAction)btnSaveAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *innerbackView;
@property (weak, nonatomic) IBOutlet UIView *innerbackView2;

@end
