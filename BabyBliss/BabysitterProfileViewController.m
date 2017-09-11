//
//  BabysitterProfileViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/11/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "BabysitterProfileViewController.h"
#import "BabySitterBioCellTableViewCell.h"
#import "RequestManager.h"
#import "SharedData.h"
#import "PProfileManager.h"
#import "FeedbacksListViewController.h"
#import "FeedbackDetailsViewController.h"

@interface BabysitterProfileViewController ()<UITableViewDataSource, UITableViewDelegate>{

}

@end

@implementation BabysitterProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tblView registerNib:[UINib nibWithNibName:@"BabySitterBioCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"BSBioCell"];
    // Do any additional setup after loading the view.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title-icon"]];
    [imgView clipsToBounds];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.frame = CGRectMake(0, 0, 70, 40);
    self.navigationItem.titleView = imgView;
    
}

-(void)populateData{
//    arrBioDescs = @[@"Location",@"Price Cap",@"Expereince",@"Skills"];
//    arrBioNames = @[@"New York",@"$10 - $12",@"4 years",@"CPR certified"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 1){
        return 5;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
//        UIView *viewHeading = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][2] ;
        return 168.0;
    }else if(section == 2){
        return 10.0;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *viewHeading = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][3] ;
        return viewHeading;
    }else if (section == 2){
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10.0)];
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(self.request == nil){
        if(section == 1){
            UIButton *btnAdvertiseMyProfile = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][5] ;
            return btnAdvertiseMyProfile.frame.size.height;
        }else if(section == 2){
            UIButton *btnFeedbacks = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][8] ;
            return btnFeedbacks.frame.size.height;
        }
    }else{
        if(section == 1){
            UIButton *btnScheduleASession = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][7] ;
            return btnScheduleASession.frame.size.height;
        }else if(section == 2){
            UIButton *btnFeedbacks = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][8] ;
            return btnFeedbacks.frame.size.height;
        }
    }
    return 0;
}

-(void)btnAddFeedbacks:(UIButton *)btn{
    // lead to my feedback page
    if(self.request == nil){ // viewing own profile
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FeedbacksListViewController *vc = (FeedbacksListViewController *)[storyboard instantiateViewControllerWithIdentifier:@"myFeedbackList"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FeedbackDetailsViewController *vc = (FeedbackDetailsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"feedbackList"];
        vc.babysitter = self.request.objBabysitterProfile;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(self.request == nil){
        if(section == 1){
            UIButton *btnAdvertiseMyProfile = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][5] ;
            [btnAdvertiseMyProfile addTarget:self action:@selector(btnAdvertiseMyProfileAction:) forControlEvents:UIControlEventTouchUpInside];
            return btnAdvertiseMyProfile;
        }else if(section == 2){
            UIButton *btnFeedbacks = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][8] ;
            [btnFeedbacks addTarget:self action:@selector(btnAddFeedbacks:) forControlEvents:UIControlEventTouchUpInside];
            return btnFeedbacks;
        }
    }else{
        if(section == 1){
            UIButton *btnScheduleASession = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][7] ;
            [btnScheduleASession addTarget:self action:@selector(btnScheduleASession:) forControlEvents:UIControlEventTouchUpInside];
            return btnScheduleASession;
        }else if(section == 2){
            UIButton *btnFeedbacks = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][8] ;
            [btnFeedbacks addTarget:self action:@selector(btnAddFeedbacks:) forControlEvents:UIControlEventTouchUpInside];
            return btnFeedbacks;
        }
    }
    return nil;
}

-(void)btnScheduleASession:(UIButton *)btn{
    if([RequestManager scheduleASessionForRequest:self.request forParent:[SharedData sharedData].inSessionParent andBabysitter:self.request.objBabysitterProfile]){
        [btn setTitle:@"Session Scheduled" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        NSString *strMessage = [NSString stringWithFormat:@"We have requested %@ on your behalf. They would respond to your request shortly.",self.request.objBabysitterProfile.strName];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thank you!" message:strMessage preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelaction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:cancelaction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)btnAdvertiseMyProfileAction:(UIButton *)btn{
    Request *request = [RequestManager createRequestWithParams:@{@"name":[SharedData sharedData].inSessionBabysitter.strName,@"location":[SharedData sharedData].inSessionBabysitter.strLocation,@"priceCap":[SharedData sharedData].inSessionBabysitter.strPriceCap,@"schedule":[SharedData sharedData].inSessionBabysitter.strSchedule,@"experience":[NSString stringWithFormat:@"%ld",[SharedData sharedData].inSessionBabysitter.experience],@"isScheduled":@"false",@"isApproved":@"false",@"isSessionComplete":@"false"}];
    NSString *strMessage = [RequestManager postAdvertisement:request fromBabysitter:[SharedData sharedData].inSessionBabysitter];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thank you!" message:strMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelaction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancelaction];
    [self presentViewController:alert animated:YES completion:nil];
}

//*strName;
//*strImgName;
//*strBio;
//*strSchedule; // d
//*strLocation;
//*strEmailId;
//*strPriceCap;
//eArray *arrFeedback



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BabySitterBioCellTableViewCell *cell = (BabySitterBioCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BSBioCell"];
    BabysitterProfile *objBabysitter = self.request ? self.request.objBabysitterProfile : [SharedData sharedData].inSessionBabysitter;
    if(indexPath.row == 0){
        cell.lblBioName.text = @"Name";
        cell.lblBioDEsc.text = objBabysitter.strName;
    }if(indexPath.row == 1){
        cell.lblBioName.text = @"About";
        cell.lblBioDEsc.text = objBabysitter.strBio;
    }if(indexPath.row == 2){
        cell.lblBioName.text = @"Email ID";
        cell.lblBioDEsc.text = objBabysitter.strEmailId;
    }if(indexPath.row == 3){
        cell.lblBioName.text = @"Location";
        cell.lblBioDEsc.text = objBabysitter.strLocation;
    }if(indexPath.row == 4){
        cell.lblBioName.text = @"Price Cap";
        cell.lblBioDEsc.text = objBabysitter.strPriceCap;
    }if(indexPath.row == 5){
        cell.lblBioName.text = @"Schedule";
        cell.lblBioDEsc.text = objBabysitter.strSchedule;
    }
//    cell.lblBioDEsc.text = arrBioNames[indexPath.row];
//    cell.lblBioName.text = arrBioDescs[indexPath.row];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
