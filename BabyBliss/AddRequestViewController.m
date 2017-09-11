//
//  ViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/4/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "AddRequestViewController.h"
#import "RequesIItemCellTableViewCell.h"
#import "RelevantBSListViewController.h"
#import "EnterNameViewController.h"
#import "EnterLocationViewController.h"
#import "EnterPriceCapViewController.h"
#import "EnterScheduleViewController.h"
#import "ExperienceViewController.h"
#import "Request.h"
#import "RequestManager.h"
#import "PProfileManager.h"
#import "SharedData.h"


@interface AddRequestViewController ()<DataEnteredDelegate>{
    ParentProfile *parent;
    NSArray *arrFieldsNames;
    NSMutableArray *arrFieldValues;
    UIButton *btnSave;
    __weak IBOutlet UITableView *tblView;
}
@end

@implementation AddRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrFieldsNames = @[@"NAME",@"LOCATION",@"PRICE CAP",@"SCHEDULE",@"EXPERIENCE"];
    arrFieldValues = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"", nil];
//    arrFieldValues = [@[@"Bob Smith",@"New York",@"$10 - $20",@"Feb 20th, 2017  2:00pm to 4:00 pm",@"2 years"] mutableCopy];
    [tblView registerNib:[UINib nibWithNibName:@"RequesIItemCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"requestItemCell"];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [tblView reloadData];
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

#pragma mark UITableView delegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *viewHeading = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][2] ;
        return viewHeading.frame.size.height;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *viewHeading = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][2] ;

        return viewHeading;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 1){
        return arrFieldsNames.count;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RequesIItemCellTableViewCell *cell = (RequesIItemCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"requestItemCell"];
    cell.lblParamName.text = arrFieldsNames[indexPath.row];
    cell.lblParamValue.text = arrFieldValues[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 2){
        return 70;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section == 2){
        UIButton *btnSubmit = [[[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil] firstObject] ;
        [btnSubmit setTitle:@"SUBMIT" forState:UIControlStateNormal];
        btnSubmit.layer.cornerRadius = 10.0;
        btnSave = btnSubmit;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tblView.frame.size.width, 70)];
        [view addSubview:btnSubmit];
        [self setAptColorForSaveButton];
        btnSubmit.center = CGPointMake(view.center.x, view.center.y);
        [btnSubmit addTarget:self action:@selector(btnSubmitClicked:) forControlEvents:UIControlEventTouchUpInside];
        return view;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *mianStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if(indexPath.row == DetailTypeName){
        EnterNameViewController *nameVC = (EnterNameViewController *)[mianStoryBoard instantiateViewControllerWithIdentifier:@"enterName"];
        nameVC.delegate = self;
        [self.navigationController pushViewController:nameVC animated:YES];
    }else if(indexPath.row == DetailTypeLocation){
        EnterLocationViewController *nameVC = (EnterLocationViewController *)[mianStoryBoard instantiateViewControllerWithIdentifier:@"EnterLocation"];
        nameVC.delegate = self;

        [self.navigationController pushViewController:nameVC animated:YES];
    }else if (indexPath.row == DetailTypePriceCap){
        EnterPriceCapViewController *nameVC = (EnterPriceCapViewController *)[mianStoryBoard instantiateViewControllerWithIdentifier:@"EnterPriceCap"];
        nameVC.delegate = self;

        [self.navigationController pushViewController:nameVC animated:YES];

    }else if (indexPath.row == DetailTypeSchedule){
        EnterScheduleViewController *nameVC = (EnterScheduleViewController *)[mianStoryBoard instantiateViewControllerWithIdentifier:@"EnterDate"];
        nameVC.delegate = self;

        [self.navigationController pushViewController:nameVC animated:YES];
        
    }else if (indexPath.row == DetailTypeExpereince){
        ExperienceViewController *nameVC = (ExperienceViewController *)[mianStoryBoard instantiateViewControllerWithIdentifier:@"EnterExperience"];
        nameVC.delegate = self;
        [self.navigationController pushViewController:nameVC animated:YES];
        
    }
    [tableView reloadData];
}

-(void)btnSubmitClicked:(UIButton *)btn{
    NSLog(@"Submit button clicked");
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RelevantBSListViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"babysittersList"];
    vc.request =  [RequestManager createRequestWithParams:@{@"name":arrFieldValues[0],@"location":arrFieldValues[1],@"priceCap":arrFieldValues[2],@"schedule":arrFieldValues[3],@"experience":arrFieldValues[4],@"isScheduled":@"false",@"isApproved":@"false",@"isSessionComplete":@"false"}];
    ;
    vc.parent = [SharedData sharedData].inSessionParent;
    vc.isRequestPage = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Delegate call received

-(void)setAptColorForSaveButton{
    [btnSave setBackgroundColor:[UIColor lightGrayColor]];
    [btnSave setEnabled:NO];
    __block BOOL areAllFieldsEntered = YES;
    [arrFieldValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *strDetail = (NSString *)obj;
        if(strDetail.length == 0){
            areAllFieldsEntered = NO;
        }
    }];
    if(areAllFieldsEntered){
        [btnSave setEnabled:YES];
        [btnSave setBackgroundColor:[UIColor colorWithRed:82.0/255.0 green:175.0/255.0 blue:68.0/255.0 alpha:1.0]];
    }
}

-(void)detailsEntered:(NSString *)strDetails forType:(EnteredDataType)dataType{
    [arrFieldValues replaceObjectAtIndex:dataType withObject:strDetails];
    [self setAptColorForSaveButton];
}



@end
