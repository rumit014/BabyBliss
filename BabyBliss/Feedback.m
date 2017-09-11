//
//  Feedback.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/18/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "Feedback.h"

@implementation Feedback

+(Feedback *)createFeedback:(NSString *)strTestimonial andRating:(NSString *)rating{
    Feedback *feedback = [[Feedback alloc] init];
    feedback.strRating = rating;
    feedback.strTestimonial = strTestimonial;
    return feedback;
}

+(Feedback *)createFeedbackWithDict:(NSDictionary *)dict{
    Feedback *feedback = nil;
    if([dict allKeys].count){
        feedback = [[Feedback alloc] init];
        feedback.strRating = dict[@"rating"];
        feedback.strTestimonial = dict[@"testimonial"];
        return feedback;
    }
    return feedback;
}


@end
