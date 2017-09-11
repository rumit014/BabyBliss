//
//  PProfileManager.h
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/18/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParentProfile.h"


@interface PProfileManager : NSObject

+(ParentProfile *)fetchParentProfileWithID:(NSString *)emailID;
//+fetchProfile(): ParentProfile
//+saveProfile(): Boolean
//+deleteProfile(): Boolean
//+addProfile(): Boolean

@end
