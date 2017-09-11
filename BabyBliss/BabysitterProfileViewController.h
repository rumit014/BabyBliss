//
//  BabysitterProfileViewController.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/11/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSProfileManager.h"
#import "BabysitterProfile.h"

@interface BabysitterProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (strong,nonatomic) Request *request;
@end
