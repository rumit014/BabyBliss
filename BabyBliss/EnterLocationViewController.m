//
//  EnterLocationViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/11/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "EnterLocationViewController.h"
#import "AddRequestViewController.h"


@interface EnterLocationViewController ()

@end

@implementation EnterLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self additionalUISetup];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.txtFieldLocation becomeFirstResponder];UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title-icon"]];
    [imgView clipsToBounds];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.frame = CGRectMake(0, 0, 70, 40);
    self.navigationItem.titleView = imgView;
}


-(void)additionalUISetup{
    self.txtFieldLocation.layer.cornerRadius = 10.0;
    self.txtFieldLocation.layer.borderWidth = 1.0;
    self.txtFieldLocation.layer.borderColor = [UIColor blackColor].CGColor;
    self.txtFieldLocation.leftViewMode = UITextFieldViewModeAlways;
    self.txtFieldLocation.rightViewMode = UITextFieldViewModeAlways;
    self.txtFieldLocation.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
    self.txtFieldLocation.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
    self.btnSave.layer.cornerRadius = 10.0;
    self.imgViewMap.layer.borderWidth = 2.0;
    self.imgViewMap.layer.borderColor = [UIColor grayColor].CGColor;
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

- (IBAction)btnSaveAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(detailsEntered:forType:)]){
        [self.delegate detailsEntered:self.txtFieldLocation.text forType:DetailTypeLocation];
    }
    [self.navigationController popViewControllerAnimated:YES];
}



@end
