//
//  SharedData.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/27/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BabysitterProfile.h"
#import "ParentProfile.h"

@interface SharedData : NSObject
@property (strong,nonatomic) ParentProfile *inSessionParent;
@property (strong,nonatomic) BabysitterProfile *inSessionBabysitter;
+(SharedData *)sharedData;
-(void)setInSessionParentWithID:(NSString *)emailID;
-(void)setInSessionBabysitterWithID:(NSString *)emailID;

@end
