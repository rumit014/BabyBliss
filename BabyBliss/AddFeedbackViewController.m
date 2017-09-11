//
//  AddFeedbackViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/28/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "AddFeedbackViewController.h"
#import "SharedData.h"

@interface AddFeedbackViewController ()

@end

@implementation AddFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self additionalUISetup];
    [self populateData];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.titleView = nil;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title-icon"]];
    [imgView clipsToBounds];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.frame = CGRectMake(0, 0, 70, 40);
    self.navigationItem.titleView = imgView;
}


-(void)populateData{
    if([SharedData sharedData].inSessionBabysitter != nil){
        self.lblName.text = self.request.objParentProfile.strName;
        self.lblBio.text = self.request.objParentProfile.strProfession;
    }else if([SharedData sharedData].inSessionParent != nil){
        self.lblName.text = self.request.objBabysitterProfile.strName;
        self.lblBio.text = self.request.objBabysitterProfile.strBio;
    }
}

-(void)additionalUISetup{
    self.viewHeaderback.layer.cornerRadius = 20.0;
    self.txtViewReview.layer.borderWidth = 1.0;
    self.txtViewReview.layer.borderColor = [UIColor blackColor].CGColor;
    self.txtFieldRating.layer.borderWidth = 1.0;
    self.txtFieldRating.layer.borderColor = [UIColor blackColor].CGColor;
    self.btnSubmit.layer.cornerRadius = 10.0;
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

- (IBAction)btnSubmit:(id)sender {
    Feedback *feedback = [FeedbackManager createFeedback:self.txtViewReview.text andRating:self.txtFieldRating.text];
    if([SharedData sharedData].inSessionParent != nil){
        [FeedbackManager postFeedback:feedback fromParentToBabysitterForRequest:self.request];
    }else if([SharedData sharedData].inSessionBabysitter != nil){
        [FeedbackManager postFeedback:feedback fromBabysitterToParentForRequest:self.request];
    }
}
@end
