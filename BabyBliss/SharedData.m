//
//  SharedData.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/27/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "SharedData.h"
#import "BSProfileManager.h"
#import "PProfileManager.h"


static SharedData *sharedData;
@implementation SharedData

+(SharedData *)sharedData{
    if(sharedData == nil){
        sharedData = [[SharedData alloc] init];
    }
    return sharedData;
    
}

-(void)setInSessionParentWithID:(NSString *)emailID{
    self.inSessionParent = [PProfileManager fetchParentProfileWithID:emailID];
}
-(void)setInSessionBabysitterWithID:(NSString *)emailID{
    self.inSessionBabysitter = [BSProfileManager fetchBSProfileProfileWithID:emailID];
}

@end
