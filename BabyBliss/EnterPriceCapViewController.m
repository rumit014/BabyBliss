//
//  EnterPriceCapViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/11/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "EnterPriceCapViewController.h"

@interface EnterPriceCapViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end

@implementation EnterPriceCapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self additionalUISetup];

    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.txtFieldPriceCap becomeFirstResponder];UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title-icon"]];
    [imgView clipsToBounds];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.frame = CGRectMake(0, 0, 70, 40);
    self.navigationItem.titleView = imgView;

}


-(void)additionalUISetup{
    self.txtFieldPriceCap.layer.cornerRadius = 10.0;
    self.txtFieldPriceCap.layer.borderWidth = 1.0;
    self.txtFieldPriceCap.layer.borderColor = [UIColor blackColor].CGColor;
    self.txtFieldPriceCap.leftViewMode = UITextFieldViewModeAlways;
    self.txtFieldPriceCap.rightViewMode = UITextFieldViewModeAlways;
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 30, 40)];
    lbl.text = @"$";
    [lbl setFont:[UIFont boldSystemFontOfSize:14.0]];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor darkGrayColor];
    self.txtFieldPriceCap.leftView = lbl;
    self.txtFieldPriceCap.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
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

- (IBAction)btnSaveAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(detailsEntered:forType:)]){
        [self.delegate detailsEntered:self.txtFieldPriceCap.text forType:DetailTypePriceCap];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
