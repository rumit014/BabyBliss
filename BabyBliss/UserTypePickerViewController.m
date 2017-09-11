//
//  UserTypePickerViewController.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/4/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "UserTypePickerViewController.h"
#import "AppDelegate.h"
#import "SharedData.h"

@interface UserTypePickerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *parentbackView;
- (IBAction)btnParentSelected:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *babysitterBackView;
- (IBAction)btnBabysitterSelected:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnGo2;
@property (weak, nonatomic) IBOutlet UIButton *btnGo1;

@end

@implementation UserTypePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self additionalUISetup];
    // Do any additional setup after loading the view.
}

-(void)additionalUISetup{
    self.btnGo1.layer.cornerRadius = 10.0;
    self.btnGo2.layer.cornerRadius = 10.0;
    self.babysitterBackView.layer.cornerRadius = 20.0;
    self.parentbackView.layer.cornerRadius = 20.0;

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

- (IBAction)btnParentSelected:(id)sender {
    if(self.txtFieldParentID.text.length != 0){
        [[SharedData sharedData] setInSessionParentWithID:self.txtFieldParentID.text];
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [window setRootViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"parentTabBar"]];
    }
}

- (IBAction)btnBabysitterSelected:(id)sender {
    if(self.txtFieldBabysitterID.text.length != 0){
        [[SharedData sharedData] setInSessionBabysitterWithID:self.txtFieldBabysitterID.text];
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [window setRootViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"babysitterTabBar"]];
    }
}
@end
