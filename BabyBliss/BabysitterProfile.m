//
//  BabysitterProfile.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/18/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "BabysitterProfile.h"

@implementation BabysitterProfile
-(void)fillInData:(NSDictionary *)dict{
    self.strRating = dict[@"rating"];
    self.strName = dict[@"name"];
    self.strBio = dict[@"bio"];
    self.strLocation = dict[@"location"];
    self.strSchedule = dict[@"schedule"];
    self.strEmailId = dict[@"id"];
    self.experience = [dict[@"experience"] integerValue];
    self.strPriceCap = dict[@"priceCap"];
    self.arrRequests = dict[@"requests"];
    self.arrFeedbacks = dict[@"feedbacks"];
    self.dictBabysitter = dict;
}


-(id)initWithDictionary:(NSDictionary *)dict{
    if(self == nil){
        self = [super init];
    }
    [self fillInData:dict];
    return self;
}

-(BabysitterProfile *)createProfile:(NSDictionary *)dict{
    return [self initWithDictionary:dict];
}

-(BabysitterProfile *)updateProfile:(BabysitterProfile *)parent withData:(NSDictionary *)dict{
    [self fillInData:dict];
    return self;
}
@end
