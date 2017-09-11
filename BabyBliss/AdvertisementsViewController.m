//
//  AdvertisementsViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/27/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "AdvertisementsViewController.h"
#import "RequestManager.h"
#import "BabySittersListCellTableViewCell.h"
#import "BabysitterProfileViewController.h"

@interface AdvertisementsViewController (){
    NSMutableArray *arrBabysitterAdvertisements;
}
@property(strong,nonatomic) IBOutlet UITableView *tblView;
@end

@implementation AdvertisementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [super viewWillAppear:animated];
    self.navigationItem.titleView = nil;
    arrBabysitterAdvertisements = [RequestManager fetchAdvertisementList];
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
    if(arrBabysitterAdvertisements.count == 0){
        _lblNoData.hidden = false;
        self.tblView.hidden = true;
    }
    return arrBabysitterAdvertisements.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    UIView *viewPageTitle = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][6];
    return viewPageTitle.frame.size.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *viewPageTitle = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][6] ;
    return viewPageTitle;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BabySittersListCellTableViewCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"babysitterListCell"];
    Request *request = arrBabysitterAdvertisements[indexPath.row];
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
    babysitterVC.request = arrBabysitterAdvertisements[indexPath.row];
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
