//
//  FeedbacksListViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/27/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "FeedbacksListViewController.h"
#import "FeedbackCellTableViewCell.h"
#import "Request.h"
#import "Feedback.h"
#import "SharedData.h"
#import "FeedbackManager.h"
#import "AddFeedbackViewController.h"
#import "FeedbackDetailsViewController.h"

@interface FeedbacksListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *arrPendingFeedbacks;
    NSMutableArray *arrReceivedFeedbacks;
}

@end

@implementation FeedbacksListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tblView registerNib:[UINib nibWithNibName:@"FeedbackCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"feedbackCell"];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.titleView = nil;
    if([SharedData sharedData].inSessionBabysitter != nil){
        arrPendingFeedbacks = [FeedbackManager fetchPendingFeedbacksForBabysitter:[SharedData sharedData].inSessionBabysitter];
        arrReceivedFeedbacks = [FeedbackManager fetchReceivedFeedbacksForBabysitter:[SharedData sharedData].inSessionBabysitter];
    }else if([SharedData sharedData].inSessionParent){
        arrReceivedFeedbacks = [FeedbackManager fetchReceivedFeedbacksForParent:[SharedData sharedData].inSessionParent];
        arrPendingFeedbacks = [FeedbackManager fetchPendingFeedbacksForParent:[SharedData sharedData].inSessionParent];
    }
    [self.tblView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title-icon"]];
    [imgView clipsToBounds];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.frame = CGRectMake(0, 0, 70, 40);
    self.navigationItem.titleView = imgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return arrReceivedFeedbacks.count;
    }else{
        return arrPendingFeedbacks.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    UIView *viewHeader = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][9];
    return viewHeader.frame.size.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *viewHeader;
    if(section == 0){
        viewHeader = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][4];
        return viewHeader;
    }else if (section == 1){
        viewHeader = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][9];
        return viewHeader;
    }
    return nil;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FeedbackCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedbackCell"];
    if([SharedData sharedData].inSessionParent != nil){
        if(indexPath.section == 0){
            Request *request = arrReceivedFeedbacks[indexPath.row];
            BabysitterProfile *babysitterProfile = request.objBabysitterProfile;
            cell.lblName.text = babysitterProfile.strName;
            cell.imgView.image = [UIImage imageNamed:@"baby-sitter-profile"];
        }else if(indexPath.section == 1){
            Request *request = arrPendingFeedbacks[indexPath.row];
            BabysitterProfile *babysitterprofile = request.objBabysitterProfile;
            cell.lblName.text = babysitterprofile.strName;
            cell.imgView.image = [UIImage imageNamed:@"baby-sitter-profile"];
        }
    }else if([SharedData sharedData].inSessionBabysitter != nil){
        if(indexPath.section == 0){
            Request *request = arrReceivedFeedbacks[indexPath.row];
            ParentProfile *parentProfile = request.objParentProfile;
            cell.lblName.text = parentProfile.strName;
            cell.imgView.image = [UIImage imageNamed:@"baby-sitter-profile"];
        }else if(indexPath.section == 1){
            Request *request = arrPendingFeedbacks[indexPath.row];
            ParentProfile *parentProfile = request.objParentProfile;
            cell.lblName.text = parentProfile.strName;
            cell.imgView.image = [UIImage imageNamed:@"baby-sitter-profile"];
        }
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // take to fedback detail page.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [self.tblView reloadData];
    if(indexPath.section == 1){
        AddFeedbackViewController *addFeedbackVC = (AddFeedbackViewController *)[storyboard instantiateViewControllerWithIdentifier:@"addFeedback"];
        addFeedbackVC.request = arrPendingFeedbacks[indexPath.row];
        [self.navigationController pushViewController:addFeedbackVC animated:YES];
    }else if(indexPath.section == 0){
        Request *request = arrReceivedFeedbacks[indexPath.row];
        FeedbackDetailsViewController *vc = (FeedbackDetailsViewController *)(FeedbackDetailsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"feedbackList"];
        vc.feedback = [SharedData sharedData].inSessionParent ? request.objBabysitterFeedback : request.objParentFeedback;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
