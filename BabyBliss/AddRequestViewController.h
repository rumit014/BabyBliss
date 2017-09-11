//
//  ViewController.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/4/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum DataDetail{
    DetailTypeName = 0,
    DetailTypeLocation,
    DetailTypePriceCap,
    DetailTypeSchedule,
    DetailTypeExpereince
} EnteredDataType;

@protocol DataEnteredDelegate <NSObject>
@required
-(void)detailsEntered:(NSString *)strDetails forType:(EnteredDataType)dataType;
@end


@interface AddRequestViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@end

