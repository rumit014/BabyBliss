//
//  MyScheduledSessionsViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/28/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "MyScheduledSessionsViewController.h"
#import "RequestManager.h"
#import "SharedData.h"
#import "MyScheduledSessionsTableViewCell.h"

@interface MyScheduledSessionsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *arrMySessions;
}
@property (weak, nonatomic) IBOutlet UITableView *tblView;

@end

@implementation MyScheduledSessionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tblView registerNib:[UINib nibWithNibName:@"MyScheduledSessionsTableViewCell" bundle:nil] forCellReuseIdentifier:@"scheduledSessionCell"];
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
    [self.tblView reloadData];
    self.navigationItem.titleView = nil;
    [super viewWillAppear:animated];
    if([SharedData sharedData].inSessionParent != nil){
        arrMySessions = [RequestManager fetchMyScheduledSessionsListForParent:[SharedData sharedData].inSessionParent];
    }else if([SharedData sharedData].inSessionBabysitter != nil){
        arrMySessions = [RequestManager fetchMyScheduledSessionsListForBabysitter:[SharedData sharedData].inSessionBabysitter];
    }
    [self.tblView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    _lblNoData.hidden = YES;
    self.tblView.hidden = NO;
    if(arrMySessions.count == 0){
        _lblNoData.hidden = false;
        self.tblView.hidden = true;
    }
    return arrMySessions.count;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 132.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyScheduledSessionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scheduledSessionCell"];
    Request *request = arrMySessions[indexPath.row];
    if([SharedData sharedData].inSessionBabysitter != nil){
        ParentProfile *parent = request.objParentProfile;
        cell.lblName.text = parent.strName;
        cell.lblLocation.text = request.strLocation;
        cell.lblSchedule.text = request.strSchedule;
    }else if([SharedData sharedData].inSessionParent != nil){
        BabysitterProfile *babysitterprofile = request.objBabysitterProfile
        ;
        cell.lblName.text = babysitterprofile.strName;
        cell.lblLocation.text = request.strLocation;
        cell.lblSchedule.text = request.strSchedule;
    }
    [cell.btnComplete addTarget:self action:@selector(btnCompleteSession:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnComplete.tag = indexPath.row;
    [cell.btnDrop addTarget:self action:@selector(btnDropSession:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnDrop.tag = indexPath.row;
    return cell;
}

-(void)btnDropSession:(UIButton *)btn{
    if([RequestManager dropSessionForRequest:arrMySessions[btn.tag]]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Session Dropped" message:@"We have succesfully removed your session." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            // push add feedback controller here.
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        [arrMySessions removeObjectAtIndex:btn.tag];
        [_tblView reloadData];
    }
}

-(void)btnCompleteSession:(UIButton *)btn{
    if([RequestManager markSessionbCompleteForRequest:arrMySessions[btn.tag]]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thank you!" message:@"We hope you had a pleasant experience." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            // push add feedback controller here.
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        [arrMySessions removeObjectAtIndex:btn.tag];
        [_tblView reloadData];
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
