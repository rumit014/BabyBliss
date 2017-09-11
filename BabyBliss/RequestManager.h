//
//  RequestManager.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/18/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "BabysitterProfile.h"

@interface RequestManager : NSObject

//+addRequest():Babysitter[]
//+fetchBabySitterList():BSProfile[]
//+fetchApprovedBSList():BSProfileProfile[]
//+fetchMyCompletedSessionsList:Request[]
//+addFeedback():Boolean


+(NSString *)postAdvertisement:(Request *)request fromBabysitter:(BabysitterProfile *)babysitter;
+(Request *)createRequestWithParams:(NSDictionary *)dict;
+(BOOL)postRequest:(Request *)request fromParent:(ParentProfile *)parent toBabysitter:(BabysitterProfile *)babisitter;
+(NSMutableArray *)fetchInterestedParentsListForBabysitter:(BabysitterProfile *)babysitter;
+(BOOL)addApprovalForRequest:(Request *)request;
+(NSArray *)fetchApprovedBSListForParent:(ParentProfile *)parent;
+(NSMutableArray *)fetchAdvertisementList;

+(BOOL)scheduleASessionForRequest:(Request *)request forParent:(ParentProfile *)parent andBabysitter:(BabysitterProfile *)babysitter;
+(NSMutableArray *)fetchMyCompletedSessionsListForParent:(ParentProfile *)parent;
+(NSMutableArray *)fetchMyCompletedSessionsListForBabysitter:(BabysitterProfile *)babystter;
+(NSMutableArray *)fetchMyScheduledSessionsListForParent:(ParentProfile *)parent;
+(NSMutableArray *)fetchMyScheduledSessionsListForBabysitter:(BabysitterProfile *)babystter;

+(BOOL)markSessionbCompleteForRequest:(Request *)request;
+(BOOL)dropSessionForRequest:(Request *)request;

+(BOOL)updateRequest:(Request *)request withParentsFeedback:(Feedback *)feedback;
+(BOOL)updateRequest:(Request *)request withBabysittersFeedback:(Feedback *)feedback;

@end
