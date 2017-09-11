//
//  ExperienceViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/11/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "ExperienceViewController.h"

@interface ExperienceViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end

@implementation ExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self additionalUISetup];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.txtFieldExpereince becomeFirstResponder];UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title-icon"]];
    [imgView clipsToBounds];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.frame = CGRectMake(0, 0, 70, 40);
    self.navigationItem.titleView = imgView;

}


-(void)additionalUISetup{
    self.txtFieldExpereince.layer.cornerRadius = 10.0;
    self.txtFieldExpereince.layer.borderWidth = 1.0;
    self.txtFieldExpereince.layer.borderColor = [UIColor blackColor].CGColor;
    self.txtFieldExpereince.leftViewMode = UITextFieldViewModeAlways;
    self.txtFieldExpereince.rightViewMode = UITextFieldViewModeAlways;
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    lbl.textColor = [UIColor darkGrayColor];
    [lbl setFont:[UIFont boldSystemFontOfSize:14.0]];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.text = @"years";
    self.txtFieldExpereince.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
    self.txtFieldExpereince.rightView = lbl;
    self.btnSave.layer.cornerRadius = 10.0;

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

- (IBAction)btnExperienceAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(detailsEntered:forType:)]){
        [self.delegate detailsEntered:self.txtFieldExpereince.text forType:DetailTypeExpereince];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
