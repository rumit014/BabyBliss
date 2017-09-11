//
//  ParentProfile.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/18/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParentProfile : NSObject

@property (strong,nonatomic) NSString *strName;
@property (strong,nonatomic) NSString *strRating;
@property (strong,nonatomic) NSString *strImgName;
@property (strong,nonatomic) NSString *strLocation;
@property (strong,nonatomic) NSMutableArray *arrFeedbacks;
@property (strong,nonatomic) NSMutableArray *arrRequests;
@property (strong,nonatomic) NSString *strProfession;
@property (strong,nonatomic) NSString *strEmailId;
@property NSInteger numberOfChildren;
@property (strong,nonatomic) NSDictionary *dictParent;

-(ParentProfile *)createProfile:(NSDictionary *)dict;
-(ParentProfile *)updateProfile:(ParentProfile *)parent withData:(NSDictionary *)dict;

@end
