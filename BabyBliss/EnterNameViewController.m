//
//  EnterNameViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/4/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "EnterNameViewController.h"

@interface EnterNameViewController ()
- (IBAction)btnSaveClicked:(id)sender;

@end

@implementation EnterNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self additionalUISetup];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title-icon"]];
    [imgView clipsToBounds];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.frame = CGRectMake(0, 0, 70, 40);
    self.navigationItem.titleView = imgView;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.txtFieldFirstName becomeFirstResponder];UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title-icon"]];
    [imgView clipsToBounds];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.frame = CGRectMake(0, 0, 70, 40);
    self.navigationItem.titleView = imgView;

}

-(void)additionalUISetup{
    self.txtFieldFirstName.layer.cornerRadius = 10.0;
    self.txtFieldFirstName.layer.borderWidth = 1.0;
    self.txtFieldFirstName.layer.borderColor = [UIColor blackColor].CGColor;
    self.txtFieldFirstName.leftViewMode = UITextFieldViewModeAlways;
    self.txtFieldFirstName.rightViewMode = UITextFieldViewModeAlways;
    self.txtFieldFirstName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
    self.txtFieldFirstName.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
    self.xttFieldLastName.layer.cornerRadius = 10.0;
    self.xttFieldLastName.layer.borderWidth = 1.0;
    self.xttFieldLastName.layer.borderColor = [UIColor blackColor].CGColor;
    self.xttFieldLastName.leftViewMode = UITextFieldViewModeAlways;
    self.xttFieldLastName.rightViewMode = UITextFieldViewModeAlways;
    self.xttFieldLastName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
    self.xttFieldLastName.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
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

- (IBAction)btnSaveClicked:(id)sender {
    if([self.delegate respondsToSelector:@selector(detailsEntered:forType:)]){
        [self.delegate detailsEntered:[NSString stringWithFormat:@"%@ %@",self.txtFieldFirstName.text,self.xttFieldLastName.text] forType:DetailTypeName];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
