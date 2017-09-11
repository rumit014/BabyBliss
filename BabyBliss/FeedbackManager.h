//
//  FeedbackManager.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/27/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParentProfile.h"
#import "BabysitterProfile.h"
#import "RequestManager.h"

@interface FeedbackManager : NSObject
+(NSMutableArray *)fetchPendingFeedbacksForParent:(ParentProfile *)parent;
+(NSMutableArray *)fetchPendingFeedbacksForBabysitter:(BabysitterProfile *)babysitter;
+(NSMutableArray *)fetchReceivedFeedbacksForParent:(ParentProfile *)parent;
+(NSMutableArray *)fetchReceivedFeedbacksForBabysitter:(BabysitterProfile *)babysitter;
+(BOOL)postFeedback:(Feedback *)feedback fromParentToBabysitterForRequest:(Request *)request;
+(BOOL)postFeedback:(Feedback *)feedback fromBabysitterToParentForRequest:(Request *)request;
+(Feedback *)createFeedback:(NSString *)strTestimonial andRating:(NSString *)rating;

@end
