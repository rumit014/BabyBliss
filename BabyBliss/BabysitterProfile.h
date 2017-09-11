//
//  BabysitterProfile.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/18/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BabysitterProfile : NSObject
//name:String
//age:int
//dateofbirth:int
//location:String
//bio:String
//rating:String
//experienceinyears:int
//schedule:String
//priceCap: Double
//babysitterID:String


@property (strong,nonatomic) NSString *strName;
@property (strong,nonatomic) NSString *strRating;
@property (strong,nonatomic) NSString *strImgName;
@property (strong,nonatomic) NSString *strBio;
@property (strong,nonatomic) NSString *strSchedule; // date formatted from the picker
@property (strong,nonatomic) NSString *strLocation;
@property (strong,nonatomic) NSString *strEmailId;
@property (strong,nonatomic) NSString *strPriceCap;
@property (strong,nonatomic) NSMutableArray *arrFeedbacks;
@property (strong,nonatomic) NSMutableArray *arrRequests;
@property NSInteger experience;
@property (strong,nonatomic) NSDictionary *dictBabysitter;

-(BabysitterProfile *)createProfile:(NSDictionary *)dict;
-(BabysitterProfile *)updateProfile:(BabysitterProfile *)parent withData:(NSDictionary *)dict;

@end
