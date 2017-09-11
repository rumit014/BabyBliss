//
//  Feedback.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/18/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feedback : NSObject
@property (strong,nonatomic) NSString *strTestimonial;
@property (strong,nonatomic) NSString *strRating;

+(Feedback *)createFeedback:(NSString *)strTestimonial andRating:(NSString *)rating;

+(Feedback *)createFeedbackWithDict:(NSDictionary *)dict;

@end
