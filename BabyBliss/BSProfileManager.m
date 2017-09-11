//
//  BSProfileManager.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/18/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "BSProfileManager.h"
#import "BabysitterProfile.h"

@implementation BSProfileManager

+(NSString *)filepathForBabysittersPlist{
    NSArray *sysPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory ,NSUserDomainMask, YES);
    NSString *documentsDirectory = [sysPaths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Babysitters.plist"];
    return filePath;
}

+(NSMutableDictionary *)getRootRequestsDictionary{
    NSMutableDictionary *plistDict;
    NSString *filepath = [self filepathForBabysittersPlist];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]){
        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
    }
    return plistDict;
}


+(BabysitterProfile *)fetchBSProfileProfileWithID:(NSString *)emailID{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Babysitters" ofType:@"plist"];
    NSArray *arrBabysitters = [NSDictionary dictionaryWithContentsOfFile:filepath][@"Babysitters"];
    __block BabysitterProfile *babysitter = nil;
    [arrBabysitters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = (NSDictionary *)obj;
        if([obj[@"id"] isEqualToString:emailID]){
            babysitter = [[BabysitterProfile alloc] createProfile:dict];
        }
    }];
    return babysitter;
}


+(void)populateBabysittersList:(NSDictionary *)allBS{
    [allBS writeToFile: [self filepathForBabysittersPlist] atomically:YES];
}


+(NSMutableArray *)fetchBabysitterProfilesForRequest:(Request *)request{
    //read babysitters from the plist and return to bs prfiles list
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Babysitters" ofType:@"plist"];
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:filepath];
    NSLog(@"babysiters : %@",plist);
//    [self populateBabysittersList:plist];
    NSArray *arrProfiesDicts = plist[@"Babysitters"];
    NSMutableArray *arrBSProfiles = [[NSMutableArray alloc] init];
    [arrProfiesDicts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = (NSDictionary *)obj;
        BabysitterProfile *objBSProfile = [[BabysitterProfile alloc] createProfile:dict];
        
        // so that the requests can fall within the babysitter's schedule
        if([objBSProfile.strLocation isEqualToString:request.strLocation] && [objBSProfile.strPriceCap integerValue] <= [request.strPriceCap integerValue] && [objBSProfile.strSchedule isEqualToString:request.strSchedule] && objBSProfile.experience >= [request.strExperience integerValue]){
            [arrBSProfiles addObject:objBSProfile];
        }
    }];
    return arrBSProfiles;
}

@end
