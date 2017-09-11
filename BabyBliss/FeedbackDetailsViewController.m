//
//  FeedbackDetailsViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/28/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "FeedbackDetailsViewController.h"
#import "Feedback.h"
#import "FeedbackManager.h"
#import "FeedbackDetailCellTableViewCell.h"

@interface FeedbackDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *arrfeedbacks;
}

@end

@implementation FeedbackDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tblView registerNib:[UINib nibWithNibName:@"FeedbackDetailCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"feedbackDetailCell"];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_feedback == nil){
        if(self.parent != nil){
            arrfeedbacks = [FeedbackManager fetchReceivedFeedbacksForParent:self.parent];
        }else if(self.babysitter != nil){
            arrfeedbacks = [FeedbackManager fetchReceivedFeedbacksForBabysitter:self.babysitter];
        }
    }else{
        arrfeedbacks = [NSArray arrayWithObject:self.feedback];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrfeedbacks.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    UIView *view = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][11];
    return view.frame.size.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[NSBundle mainBundle] loadNibNamed:@"Views" owner:nil options:nil][11];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FeedbackDetailCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedbackDetailCell"];
    if(_feedback != nil){
        Feedback *feedback = arrfeedbacks[indexPath.row];
        FeedbackDetailCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedbackDetailCell"];
        cell.lblRating.text = [NSString stringWithFormat:@"%@/10",feedback.strRating];
        cell.lblReview.text = feedback.strTestimonial;
        return cell;
    }else{
        Request *request = arrfeedbacks[indexPath.row];
        if(self.parent){
            cell.lblRating.text = [NSString stringWithFormat:@"%@/10",request.objBabysitterFeedback.strRating];
            cell.lblReview.text = request.objBabysitterFeedback.strTestimonial;
        }else if(self.babysitter){
            cell.lblRating.text = [NSString stringWithFormat:@"%@/10",request.objBabysitterFeedback.strRating];;
            cell.lblReview.text = request.objParentFeedback.strTestimonial;
        }
    }
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
