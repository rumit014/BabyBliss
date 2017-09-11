//
//  Request.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/18/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "Request.h"
#import "ParentProfile.h"
#import "BabysitterProfile.h"

@implementation Request


-(id)initRequestWithDict:(NSDictionary *)dict{
    if(self == nil){
        self = [super init];
    }
    self.strReqID = dict[@"id"];
    self.isScheduled = [dict[@"isScheduled"] isEqualToString:@"true"] ? YES : NO;
    self.isApproved = [dict[@"isApproved"] isEqualToString:@"true"] ? YES : NO;
    self.isSessionComplete = [dict[@"isSessionComplete"] isEqualToString:@"true"] ? YES : NO;
    self.objParentFeedback = [Feedback createFeedbackWithDict:dict[@"parentFeedback"]];
    self.objBabysitterFeedback = [Feedback createFeedbackWithDict:dict[@"babysitterFeedback"]];
    self.strName = dict[@"name"];
    self.strPriceCap = dict[@"priceCap"];
    self.strLocation = dict[@"location"];
    self.strSchedule = dict[@"schedule"];
    self.strExperience = dict[@"experience"];
    self.objParentProfile = [[ParentProfile alloc] createProfile:dict[@"parent"]]; // possible crash
    self.objBabysitterProfile = [[BabysitterProfile alloc] createProfile:dict[@"babysitter"]]; // possible crash
    return self;
}


-(Request *)createRequestForQuery:(NSDictionary *)reqParams{
    return [self initRequestWithDict:reqParams];
}

-(Request *)createRequestWithParams:(NSDictionary *)reqParams{
    return [self initRequestWithDict:reqParams];
}

//
//-(Request *)createRequestToAdd:(Request *)request fromParent:(ParentProfile *)parent forBabysitter:(BabysitterProfile *)babysitter{
//    
//}

-(void)updateApprovalStatus:(BOOL)isApproved{
    self.isApproved = isApproved;
}

-(void)updateSessionScheduleStatus:(BOOL)isScheduled{
    self.isScheduled = isScheduled;
}

-(void)updateSessionCompletionStatus:(BOOL)isSessionComplete{
    self.isSessionComplete = isSessionComplete;
}


@end
