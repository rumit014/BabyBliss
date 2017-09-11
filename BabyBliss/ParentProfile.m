//
//  ParentProfile.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/18/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "ParentProfile.h"

@implementation ParentProfile

-(void)fillInData:(NSDictionary *)dict{
    self.strName = dict[@"name"];
    self.strRating = dict[@"rating"];
    self.strLocation = dict[@"location"];
    self.strProfession = dict[@"profession"];
    self.strEmailId = dict[@"id"];
    self.numberOfChildren = [dict[@"numberOdChildren"] integerValue];
    self.arrRequests = dict[@"requests"];
    self.arrFeedbacks = dict[@"feedbacks"];
    self.dictParent = dict;
}


-(id)initWithDictionary:(NSDictionary *)dict{
    if(self == nil){
        self = [super init];
    }
    [self fillInData:dict];
    return self;
}

-(ParentProfile *)createProfile:(NSDictionary *)dict{
    return [self initWithDictionary:dict];
}

-(ParentProfile *)updateProfile:(ParentProfile *)parent withData:(NSDictionary *)dict{
    [self fillInData:dict];
    return self;
}

@end
