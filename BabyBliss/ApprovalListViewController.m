//
//  ApprovalListViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/25/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "ApprovalListViewController.h"
#import "RequestManager.h"
#import "PProfileManager.h"
#import "BabySittersListCellTableViewCell.h"
#import "BabysitterProfileViewController.h"
#import "SharedData.h"

@interface ApprovalListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *arrBabysittersWhoAccepted;
}

@end

@implementation ApprovalListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Page loaded");
    [self.tblView registerNib:[UINib nibWithNibName:@"BabySittersListCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"babysitterListCell"];
    // Do any additional setup after loading the view.
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title-icon"]];
    [imgView clipsToBounds];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.frame = CGRectMake(0, 0, 70, 40);
    self.navigationItem.titleView = imgView;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tblView reloadData];
    [super viewWillAppear:animated];
    self.navigationItem.titleView = nil;
    arrBabysittersWhoAccepted = [RequestManager fetchApprovedBSListForParent:[PProfileManager fetchParentProfileWithID:[SharedData sharedData].inSessionParent.strEmailId]];
    [self.tblView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    _lblNoData.hidden = YES;
    self.tblView.hidden = NO;
    if(arrBabysittersWhoAccepted.count == 0){
        _lblNoData.hidden = false;
        self.tblView.hidden = true;
    }
    return arrBabysittersWhoAccepted.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    UIView *viewPageTitle = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][1];
    return viewPageTitle.frame.size.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *viewPageTitle = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][1] ;
    return viewPageTitle;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BabySittersListCellTableViewCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"babysitterListCell"];
    Request *request = arrBabysittersWhoAccepted[indexPath.row];
    BabysitterProfile *babysitter = request.objBabysitterProfile;
    cell.lblName.text = babysitter.strName;
    cell.lblDetails.text = babysitter.strBio;
    cell.imgView.image = [UIImage imageNamed:babysitter.strImgName];
    cell.btnSendrequest.tag = indexPath.row;
//    [cell.btnSendrequest setTitle:@"Send Request" forState:UIControlStateNormal];
//    [cell.btnSendrequest setTitle:@"Request Sent" forState:UIControlStateSelected];
    cell.btnSendrequest.hidden = YES;
//    [cell.btnSendrequest addTarget:self action:@selector(btnSendRequestAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tblView reloadData];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BabysitterProfileViewController *babysitterVC = (BabysitterProfileViewController *)    [storyBoard instantiateViewControllerWithIdentifier:@"babysitterProfileVC"];
    babysitterVC.request = arrBabysittersWhoAccepted[indexPath.row];
    [self.navigationController pushViewController:babysitterVC animated:YES];
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
