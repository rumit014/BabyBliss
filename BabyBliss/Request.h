//
//  Request.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/18/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParentProfile.h"
#import "BabysitterProfile.h"
#import "Feedback.h"

@interface Request : NSObject
@property (strong,nonatomic) NSString *strReqID;
@property (strong,nonatomic) NSString *strName;
@property (strong,nonatomic) NSString *strLocation;
@property (strong,nonatomic) NSString *strPriceCap;
@property (strong,nonatomic) NSString *strSchedule;
@property (strong,nonatomic) NSString *strExperience;
@property Boolean isApproved;
@property Boolean isScheduled;
@property Boolean isSessionComplete;
@property (strong,nonatomic) ParentProfile *objParentProfile;
@property (strong,nonatomic) BabysitterProfile *objBabysitterProfile;
@property (strong,nonatomic) Feedback *objParentFeedback;
@property (strong,nonatomic) Feedback *objBabysitterFeedback;

-(Request *)createRequestWithParams:(NSDictionary *)reqParams;
-(Request *)createRequestForQuery:(NSDictionary *)reqParams;
//-(Request *)createRequestToAdd:(Request *)request fromParent:(ParentProfile *)parent forBabysitter:(BabysitterProfile *)babysitter;
@end
