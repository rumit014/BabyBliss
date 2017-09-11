//
//  EnterScheduleViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/11/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "EnterScheduleViewController.h"

@interface EnterScheduleViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end

@implementation EnterScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self additionalUISetup];
    // Do any additional setup after loading the view.
}

-(void)viewWDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title-icon"]];
    [imgView clipsToBounds];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.frame = CGRectMake(0, 0, 70, 40);
    self.navigationItem.titleView = imgView;

}

-(void)additionalUISetup{
    self.datePickerBackView.layer.cornerRadius = 10.0;
    self.datePickerBackView2.layer.cornerRadius = 10.0;
    self.btnSave.layer.cornerRadius = 10.0;
    self.innerbackView.layer.cornerRadius = 5.0;
    self.innerbackView.layer.masksToBounds = YES;
    self.innerbackView.layer.borderWidth = 2.0;
    self.innerbackView.layer.borderColor = [UIColor grayColor].CGColor;
    self.innerbackView2.layer.cornerRadius = 5.0;
    self.innerbackView2.layer.masksToBounds = YES;
    self.innerbackView2.layer.borderWidth = 2.0;
    self.innerbackView2.layer.borderColor = [UIColor grayColor].CGColor;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSString *)convertStringToDate: (NSDate *)date formate:(NSString *)formate {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormat setDateFormat:formate];
    return [dateFormat stringFromDate:date];
}

- (IBAction)btnSaveAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(detailsEntered:forType:)]){
        NSString *dateFrom = [self convertStringToDate:_datePickerFrom.date formate:@"EEEE, MMMM dd, yyyy, HH:mm"];
        NSString *dateTo = [self convertStringToDate:_datePickerTo.date formate:@"EEEE, MMMM dd, yyyy, HH:mm"];
        [self.delegate detailsEntered:[NSString stringWithFormat:@"From %@ to %@",dateFrom,dateTo] forType:DetailTypeSchedule];
    }
    [self.navigationController popViewControllerAnimated:YES];

}
@end
