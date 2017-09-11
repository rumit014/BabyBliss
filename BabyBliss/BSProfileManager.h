//
//  BSProfileManager.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/18/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "BabysitterProfile.h"


@interface BSProfileManager : NSObject
//+fetchProfile():BSProfile +babySitterProfile
//+saveProfile: Boolean
//+deleteProfile: Boolean
//+addProfile: Boolean

+(BabysitterProfile *)fetchBSProfileProfileWithID:(NSString *)emailID;
+(NSMutableArray *)fetchBabysitterProfilesForRequest:(Request *)request;

@end
