//
//  FeedbackManager.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/27/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "FeedbackManager.h"


@implementation FeedbackManager


+(Feedback *)createFeedback:(NSString *)strTestimonial andRating:(NSString *)rating{
    return [Feedback createFeedback:strTestimonial andRating:rating];
}


+(NSMutableArray *)fetchCompletedSessionRequestsListForParent:(ParentProfile *)parent{
    return [RequestManager fetchMyCompletedSessionsListForParent:parent];
}

+(NSMutableArray *)fetchCompletedSessionRequestsListForBabysitter:(BabysitterProfile *)babysitter{
    return [RequestManager fetchMyCompletedSessionsListForBabysitter:babysitter];
}
+(NSMutableArray *)fetchPendingFeedbacksForParent:(ParentProfile *)parent{
    NSMutableArray *arrRequestsWithPendingFeebacks = [NSMutableArray array];
    NSMutableArray *arrRequests = [self fetchCompletedSessionRequestsListForParent:parent];
    [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Request *objRequest = (Request *)obj;
        if(objRequest.objParentFeedback == nil){
            [arrRequestsWithPendingFeebacks addObject:obj];
        }
    }];
    return arrRequestsWithPendingFeebacks;
}
+(NSMutableArray *)fetchPendingFeedbacksForBabysitter:(BabysitterProfile *)babysitter{
    NSMutableArray *arrRequests = [self fetchCompletedSessionRequestsListForBabysitter:babysitter];
    NSMutableArray *arrRequestsWithPendingFeebacks = [NSMutableArray array];
    [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Request *objRequest = (Request *)obj;
        if(objRequest.objBabysitterFeedback == nil){
            [arrRequestsWithPendingFeebacks addObject:obj];
        }
    }];
    return arrRequestsWithPendingFeebacks;
}
+(NSMutableArray *)fetchReceivedFeedbacksForParent:(ParentProfile *)parent{
    NSMutableArray *arrRequests = [self fetchCompletedSessionRequestsListForParent:parent];
    NSMutableArray *arrRequestsWithPendingFeebacks = [NSMutableArray array];
    [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Request *objRequest = (Request *)obj;
        if(objRequest.objBabysitterFeedback != nil){
            [arrRequestsWithPendingFeebacks addObject:obj];
        }
    }];
    return arrRequestsWithPendingFeebacks;
}


+(NSMutableArray *)fetchReceivedFeedbacksForBabysitter:(BabysitterProfile *)babysitter{
    NSMutableArray *arrRequests = [self fetchCompletedSessionRequestsListForBabysitter:babysitter];
    NSMutableArray *arrRequestsWithPendingFeebacks = [NSMutableArray array];
    [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Request *objRequest = (Request *)obj;
        if(objRequest.objParentFeedback != nil){
            [arrRequestsWithPendingFeebacks addObject:obj];
        }
    }];
    return arrRequestsWithPendingFeebacks;
}

+(BOOL)postFeedback:(Feedback *)feedback fromParentToBabysitterForRequest:(Request *)request{
    return [RequestManager updateRequest:request withParentsFeedback:feedback];
}

+(BOOL)postFeedback:(Feedback *)feedback fromBabysitterToParentForRequest:(Request *)request{
    return [RequestManager updateRequest:request withBabysittersFeedback:feedback];
}



@end
