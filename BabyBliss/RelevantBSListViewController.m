//
//  BabysittersListViewControlleViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/4/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "RelevantBSListViewController.h"
#import "BabySittersListCellTableViewCell.h"
#import "BabysitterProfile.h"
#import "BSProfileManager.h"
#import "Request.h"
#import "RequestManager.h"


@interface RelevantBSListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *arrBabysitterProfiles;
    NSArray *arrBabysitters;
    NSArray *arrBabysitterImages;
    NSArray *arrBabySiterDetails;
}
@end

@implementation RelevantBSListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrBabysitters = @[@"JANE SMITH",@"MICHAEL MURRAY",@"JOHN MATTHEW"];
    arrBabysitterImages = @[@"baby-list-item",@"baby-list-item-1",@"baby-list-item"];
    arrBabySiterDetails = @[@"4 years of exp.\nNew York\n$14 - $19",@"3 years of exp.\nNew York\n$12 - $16",@"3 years of exp.\nNew York\n$10 - $15"];
    [_tblView registerNib:[UINib nibWithNibName:@"BabySittersListCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"babysitterListCell"];
    arrBabysitterProfiles = [BSProfileManager fetchBabysitterProfilesForRequest:self.request];
    // Do any additional setup after loading the view from its nib.
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
    return arrBabysitterProfiles.count;
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
    BabysitterProfile *bsProfile = (BabysitterProfile *)arrBabysitterProfiles[indexPath.row];
    cell.lblName.text = bsProfile.strName;
    cell.lblDetails.text = bsProfile.strBio;
    cell.imgView.image = [UIImage imageNamed:bsProfile.strImgName];
    cell.btnSendrequest.tag = indexPath.row;
    [cell.btnSendrequest setTitle:@"Send Request" forState:UIControlStateNormal];
    [cell.btnSendrequest setTitle:@"Request Sent" forState:UIControlStateSelected];
    [cell.btnSendrequest addTarget:self action:@selector(btnSendRequestAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)btnSendRequestAction:(UIButton *)btn{
    if([RequestManager postRequest:self.request fromParent:self.parent toBabysitter:arrBabysitterProfiles[btn.tag]]){
        // remove item from list
        BabysitterProfile *bs = arrBabysitterProfiles[btn.tag];
        NSString *strMessage = [NSString stringWithFormat:@"We have requested %@ on your behalf. They would respond to your request shortly.",bs.strName];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thank you!" message:strMessage preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelaction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [arrBabysitterProfiles removeObjectAtIndex:btn.tag];
        [alert addAction:cancelaction];
        [self presentViewController:alert animated:YES completion:nil];
        [self.tblView reloadData];
    };
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
