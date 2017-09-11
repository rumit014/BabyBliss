//
//  ParentProfileViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/27/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "ParentProfileViewController.h"
#import "PProfileManager.h"
#import "SharedData.h"
#import "BabySitterBioCellTableViewCell.h"
#import "FeedbacksListViewController.h"
#import "FeedbackDetailsViewController.h"

@interface ParentProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tblView;

@end

@implementation ParentProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tblView registerNib:[UINib nibWithNibName:@"BabySitterBioCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"BSBioCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title-icon"]];
    [imgView clipsToBounds];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.frame = CGRectMake(0, 0, 70, 40);
    self.navigationItem.titleView = imgView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 1){
        return 4;
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
        UIView *viewHeading = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][2] ;
        return 168.0;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *viewHeading = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][3] ;
        return viewHeading;
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 1){
        UIButton *btnFeedbacks = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][8] ;
        return btnFeedbacks.frame.size.height;
    }else if (section == 2){
        
    }
    return 0;
}

-(void)btnAddFeedbacks:(UIButton *)btn{
    }

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section == 1){
        UIButton *btnFeedbacks = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][8];
        [btnFeedbacks addTarget:self action:@selector(btnFeedbacks:) forControlEvents:UIControlEventTouchUpInside];
        return btnFeedbacks;
        
    }
    return nil;
}

-(void)btnFeedbacks:(UIButton *)btn{
    // lead to my feedback page
    if(self.request == nil){ // viewing own profile
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FeedbacksListViewController *vc = (FeedbacksListViewController *)[storyboard instantiateViewControllerWithIdentifier:@"myFeedbackList"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FeedbackDetailsViewController *vc = (FeedbackDetailsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"feedbackList"];
        vc.parent = self.request.objParentProfile;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BabySitterBioCellTableViewCell *cell = (BabySitterBioCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BSBioCell"];
    ParentProfile *objParentProfile = self.request == nil ?[SharedData sharedData].inSessionParent : self.request.objParentProfile;
    if(indexPath.row == 0){
        cell.lblBioName.text = @"Name";
        cell.lblBioDEsc.text = objParentProfile.strName;
    }if(indexPath.row == 1){
        cell.lblBioName.text = @"Email ID";
        cell.lblBioDEsc.text = objParentProfile.strEmailId;
    }if(indexPath.row == 2){
        cell.lblBioName.text = @"Location";
        cell.lblBioDEsc.text = objParentProfile.strLocation;
    }if(indexPath.row == 3){
        cell.lblBioName.text = @"Profession";
        cell.lblBioDEsc.text = objParentProfile.strProfession;
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
