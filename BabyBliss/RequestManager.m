//
//  RequestManager.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/18/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager
+(Request *)createRequestWithParams:(NSDictionary *)dict{
    return [[Request alloc] createRequestForQuery:dict];
}

+(NSString *)filepathForRequestsPlist{
    NSArray *sysPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory ,NSUserDomainMask, YES);
    NSString *documentsDirectory = [sysPaths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Requests.plist"];
    return filePath;
}

+(NSMutableDictionary *)getRootRequestsDictionary{
    NSMutableDictionary *plistDict;
    NSString *filepath = [self filepathForRequestsPlist];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]){
        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
    }
    return plistDict;
}


+ (NSString *)uuid
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge NSString *)(uuidStringRef) ;
}

+(BOOL)postRequest:(Request *)request fromParent:(ParentProfile *)parent toBabysitter:(BabysitterProfile *)babysitter{
    NSDictionary *dictRequest = @{@"id": [self uuid],
                                  @"name":request.strName,
                                  @"location":request.strLocation,
                                  @"priceCap":request.strPriceCap,
                                  @"schedule":request.strSchedule,
                                  @"isScheduled":@"false",
                                  @"isApproved":@"false",
                                  @"isSessionComplete":@"false",
                                  @"parent":parent.dictParent,
                                  @"babysitter":babysitter.dictBabysitter,
                                  @"parentFeedback":@{},
                                  @"babysitterFeedback":@{}};
    NSMutableDictionary *plistDict;
    NSMutableArray *arrRequests;
    
    if((plistDict = [self getRootRequestsDictionary]) != nil){
        arrRequests = [NSMutableArray arrayWithArray:plistDict[@"Requests"]];
    }else{
        // Step4: If doesn't exist, start with an empty dictionary
        plistDict = [[NSMutableDictionary alloc] init];
        [plistDict setObject:(arrRequests = [NSMutableArray array]) forKey:@"Requests"];
    }
    
    [arrRequests addObject:dictRequest];
    [plistDict setObject:arrRequests forKey:@"Requests"];
    // add request to parent and babysitter and store on file.
    return [plistDict writeToFile: [self filepathForRequestsPlist] atomically:YES];
}

+(NSMutableArray *)fetchInterestedParentsListForBabysitter:(BabysitterProfile *)babysitter{
    NSMutableArray *arrRequests;
    NSMutableArray *arrRequestObjs = [NSMutableArray array];
    NSMutableDictionary *plistDict;
    if((plistDict = [self getRootRequestsDictionary]) != nil){
        arrRequests = plistDict[@"Requests"];
        [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *requestDict = (NSDictionary *)obj;
            Request *requestObj = [[Request alloc] createRequestWithParams:requestDict];
            if([requestObj.objBabysitterProfile.strEmailId isEqualToString:babysitter.strEmailId] && !requestObj.isApproved){
                Request *request = [[Request alloc] createRequestWithParams:requestDict];
                [arrRequestObjs addObject:request];
            }
        }];
    }
    return arrRequestObjs;
}

+(BOOL)addApprovalForRequest:(Request *)request{
    NSMutableArray *arrRequests;
    NSMutableArray *arrRequestObjs = [NSMutableArray array];
    NSMutableDictionary *plistDict;
    __block NSInteger requestIndex = 0;
    __block NSMutableDictionary *requestToModify;
    if((plistDict = [self getRootRequestsDictionary]) != nil){
        arrRequests = plistDict[@"Requests"];
        [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *requestDict = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)obj];
            if([request.strReqID isEqualToString:requestDict[@"id"]]){
                requestToModify = [requestDict mutableCopy];
                requestIndex = [arrRequests indexOfObject:requestDict];
            }
        }];
    }
    [requestToModify setObject:@"true" forKey:@"isApproved"];
    [arrRequests replaceObjectAtIndex:requestIndex withObject:requestToModify];
    return [plistDict writeToFile: [self filepathForRequestsPlist] atomically:YES];
}

+(BOOL)scheduleASessionForRequest:(Request *)request forParent:(ParentProfile *)parent andBabysitter:(BabysitterProfile *)babysitter{
    NSMutableArray *arrRequests;
    NSMutableArray *arrRequestObjs = [NSMutableArray array];
    NSMutableDictionary *plistDict;
    __block NSInteger requestIndex = 0;
    __block NSMutableDictionary *requestToModify;

    if((plistDict = [self getRootRequestsDictionary]) != nil){
        arrRequests = plistDict[@"Requests"];
        [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *requestDict = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)obj];
            if([request.strReqID isEqualToString:requestDict[@"id"]]){
                requestToModify = [requestDict mutableCopy];
                requestIndex = [arrRequests indexOfObject:requestDict];
            }
        }];
    }
    [requestToModify setObject:@"true" forKey:@"isScheduled"];
    if([requestToModify[@"parent"] allKeys].count == 0){ // case of advertisement when a parent is hooked with a request only upon acceptance.
        [requestToModify setObject:parent.dictParent forKey:@"parent"];
    }
    [arrRequests replaceObjectAtIndex:requestIndex withObject:requestToModify];
    [plistDict setObject:arrRequests forKey:@"Requests"];
    return [plistDict writeToFile: [self filepathForRequestsPlist] atomically:YES];
}

+(NSArray *)fetchApprovedBSListForParent:(ParentProfile *)parent{
    NSMutableArray *arrRequests;
    NSMutableArray *arrRequestObjs = [NSMutableArray array];
    NSMutableDictionary *plistDict;
    if((plistDict = [self getRootRequestsDictionary]) != nil){
        arrRequests = plistDict[@"Requests"];
        [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *requestDict = (NSDictionary *)obj;
            Request *request = [[Request alloc] createRequestForQuery:requestDict];
            if([request.objParentProfile.strEmailId isEqualToString:parent.strEmailId] && request.isApproved && !request.isScheduled && !request.isSessionComplete){
                [arrRequestObjs addObject:request];
            }
        }];
    }
    return arrRequestObjs;
}


+(NSString *)postAdvertisement:(Request *)request fromBabysitter:(BabysitterProfile *)babysitter{
    NSDictionary *dictRequest = @{@"id": [self uuid],
                                  @"name":request.strName,
                                  @"location":request.strLocation,
                                  @"priceCap":request.strPriceCap,
                                  @"schedule":request.strSchedule,
                                  @"isScheduled":@"false",
                                  @"isApproved":@"true",
                                  @"isSessionComplete":@"false",
                                  @"parent":@{},
                                  @"babysitter":babysitter.dictBabysitter,
                                  @"parentFeedback":@{},
                                  @"babysitterFeedback":@{}};
    NSMutableDictionary *plistDict;
    NSMutableArray *arrRequests;
    if((plistDict = [self getRootRequestsDictionary]) != nil){
        arrRequests = [NSMutableArray arrayWithArray:plistDict[@"Requests"]];
    }else{
        // Step4: If doesn't exist, start with an empty dictionary
        plistDict = [[NSMutableDictionary alloc] init];
        [plistDict setObject:(arrRequests = [NSMutableArray array]) forKey:@"Requests"];
    }
    for (NSDictionary *requestDict in arrRequests) {
        BabysitterProfile *objbabysitter = [[BabysitterProfile alloc] createProfile:requestDict[@"babysitter"]];
        if([babysitter.strEmailId isEqualToString:objbabysitter.strEmailId] && [babysitter.strSchedule isEqualToString:objbabysitter.strSchedule] && [requestDict[@"isApproved"] isEqualToString:@"true"] && [requestDict[@"isScheduled"] isEqualToString:@"false"] && [requestDict[@"isSessionComplete"] isEqualToString:@"false"]){
            return @"Your profile with current schedule is already advertised";
        }
    }
    [arrRequests addObject:dictRequest];
    [plistDict setObject:arrRequests forKey:@"Requests"];
    NSLog(@"Request array : %@",arrRequests);
    // add request to parent and babysitter and store on file.
    if([plistDict writeToFile: [self filepathForRequestsPlist] atomically:YES]){
        return @"We have advertised your profile. Now parents can see your profile, and may contact you for scheduling a session.";
    }else{
        
        return @"There was an error, please try adverstising your profile again later.";
    }
}

+(NSMutableArray *)fetchAdvertisementList{
    NSMutableArray *arrRequests;
    NSMutableArray *arrRequestObjs  = [NSMutableArray array];
    NSMutableDictionary *plistDict;
    if((plistDict = [self getRootRequestsDictionary]) != nil){
        arrRequests = plistDict[@"Requests"];
        [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *requestDict = (NSDictionary *)obj;
            NSDictionary *parent = requestDict[@"parent"];
            if([parent allKeys].count == 0 && [requestDict[@"isApproved"] isEqualToString:@"true"] && [requestDict[@"isScheduled"] isEqualToString:@"false"] && [requestDict[@"isSessionComplete"] isEqualToString:@"false"]){
                Request *request = [[Request alloc] createRequestForQuery:requestDict];
                [arrRequestObjs addObject:request];
            }
        }];
    }
    return arrRequestObjs;
}

+(NSMutableArray *)fetchMyCompletedSessionsListForParent:(ParentProfile *)parent{
    NSMutableArray *arrRequests;
    NSMutableArray *arrRequestObjs  = [NSMutableArray array];
    NSMutableDictionary *plistDict;
    if((plistDict = [self getRootRequestsDictionary]) != nil){
        arrRequests = plistDict[@"Requests"];
        [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *requestDict = (NSDictionary *)obj;
            NSDictionary *parentDict = requestDict[@"parent"];
            if([parentDict[@"id"] isEqualToString:parent.strEmailId] && [requestDict[@"isApproved"] isEqualToString:@"true"] &&[requestDict[@"isScheduled"] isEqualToString:@"true"] && [requestDict[@"isSessionComplete"] isEqualToString:@"true"]){
                Request *request = [[Request alloc] createRequestForQuery:requestDict];
                [arrRequestObjs addObject:request];
            }
        }];
    }
    return arrRequestObjs;
}

+(NSMutableArray *)fetchMyCompletedSessionsListForBabysitter:(BabysitterProfile *)babystter{
    NSMutableArray *arrRequests;
    NSMutableArray *arrRequestObjs  = [NSMutableArray array];
    NSMutableDictionary *plistDict;
    if((plistDict = [self getRootRequestsDictionary]) != nil){
        arrRequests = plistDict[@"Requests"];
        [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *requestDict = (NSDictionary *)obj;
            NSDictionary *babysitterDict = requestDict[@"babysitter"];
            if([babysitterDict[@"id"] isEqualToString:babystter.strEmailId] &&
               [requestDict[@"isApproved"] isEqualToString:@"true"] &&[requestDict[@"isScheduled"] isEqualToString:@"true"] && [requestDict[@"isSessionComplete"] isEqualToString:@"true"]){
                Request *request = [[Request alloc] createRequestForQuery:requestDict];
                [arrRequestObjs addObject:request];
            }
        }];
    }
    return arrRequestObjs;
}


+(NSMutableArray *)fetchMyScheduledSessionsListForParent:(ParentProfile *)parent{
    NSMutableArray *arrRequests;
    NSMutableArray *arrRequestObjs  = [NSMutableArray array];
    NSMutableDictionary *plistDict;
    if((plistDict = [self getRootRequestsDictionary]) != nil){
        arrRequests = plistDict[@"Requests"];
        [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *requestDict = (NSDictionary *)obj;
            NSDictionary *parentDict = requestDict[@"parent"];
            if([parentDict[@"id"] isEqualToString:parent.strEmailId] && [requestDict[@"isApproved"] isEqualToString:@"true"] &&[requestDict[@"isScheduled"] isEqualToString:@"true"] && [requestDict[@"isSessionComplete"] isEqualToString:@"false"]){
                Request *request = [[Request alloc] createRequestForQuery:requestDict];
                [arrRequestObjs addObject:request];
            }
        }];
    }
    return arrRequestObjs;
}

+(NSMutableArray *)fetchMyScheduledSessionsListForBabysitter:(BabysitterProfile *)babystter{
    NSMutableArray *arrRequests;
    NSMutableArray *arrRequestObjs  = [NSMutableArray array];
    NSMutableDictionary *plistDict;
    if((plistDict = [self getRootRequestsDictionary]) != nil){
        arrRequests = plistDict[@"Requests"];
        [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *requestDict = (NSDictionary *)obj;
            NSDictionary *babysitterDict = requestDict[@"babysitter"];
            if([babysitterDict[@"id"] isEqualToString:babystter.strEmailId] && [requestDict[@"isApproved"] isEqualToString:@"true"] &&[requestDict[@"isScheduled"] isEqualToString:@"true"] && [requestDict[@"isSessionComplete"] isEqualToString:@"false"]){
                Request *request = [[Request alloc] createRequestForQuery:requestDict];
                [arrRequestObjs addObject:request];
            }
        }];
    }
    return arrRequestObjs;
}


+(BOOL)markSessionbCompleteForRequest:(Request *)request{
    NSMutableArray *arrRequests;
    NSMutableArray *arrRequestObjs = [NSMutableArray array];
    NSMutableDictionary *plistDict;
    __block NSInteger requestIndex = 0;
    __block NSMutableDictionary *requestToModify;
    
    if((plistDict = [self getRootRequestsDictionary]) != nil){
        arrRequests = plistDict[@"Requests"];
        [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *requestDict = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)obj];
            if([request.strReqID isEqualToString:requestDict[@"id"]]){
                requestToModify = [requestDict mutableCopy];
                requestIndex = [arrRequests indexOfObject:requestDict];
            }
        }];
    }
    [requestToModify setObject:@"true" forKey:@"isSessionComplete"];
    [arrRequests replaceObjectAtIndex:requestIndex withObject:requestToModify];
    [plistDict setObject:arrRequests forKey:@"Requests"];
    return [plistDict writeToFile: [self filepathForRequestsPlist] atomically:YES];
}

+(BOOL)updateRequest:(Request *)request withParentsFeedback:(Feedback *)feedback{
    NSMutableArray *arrRequests;
    NSMutableArray *arrRequestObjs = [NSMutableArray array];
    NSMutableDictionary *plistDict;
    __block NSInteger requestIndex = 0;
    __block NSMutableDictionary *requestToModify;
    
    if((plistDict = [self getRootRequestsDictionary]) != nil){
        arrRequests = plistDict[@"Requests"];
        [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *requestDict = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)obj];
            if([request.strReqID isEqualToString:requestDict[@"id"]]){
                requestToModify = [requestDict mutableCopy];
                requestIndex = [arrRequests indexOfObject:requestDict];
            }
        }];
    }
    NSDictionary *dictFeedback = @{@"testimonial":feedback.strTestimonial,
                                   @"rating":feedback.strRating};
    [requestToModify setObject:dictFeedback forKey:@"parentFeedback"];
    [arrRequests replaceObjectAtIndex:requestIndex withObject:requestToModify];
    [plistDict setObject:arrRequests forKey:@"Requests"];
    return [plistDict writeToFile: [self filepathForRequestsPlist] atomically:YES];
}

+(BOOL)updateRequest:(Request *)request withBabysittersFeedback:(Feedback *)feedback{
    NSMutableArray *arrRequests;
    NSMutableArray *arrRequestObjs = [NSMutableArray array];
    NSMutableDictionary *plistDict;
    __block NSInteger requestIndex = 0;
    __block NSMutableDictionary *requestToModify;
    
    if((plistDict = [self getRootRequestsDictionary]) != nil){
        arrRequests = plistDict[@"Requests"];
        [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *requestDict = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)obj];
            if([request.strReqID isEqualToString:requestDict[@"id"]]){
                requestToModify = [requestDict mutableCopy];
                requestIndex = [arrRequests indexOfObject:requestDict];
            }
        }];
    }
    NSDictionary *dictFeedback = @{@"testimonial":feedback.strTestimonial,
                                   @"rating":feedback.strRating};
    [requestToModify setObject:dictFeedback forKey:@"babysitterFeedback"];
    [arrRequests replaceObjectAtIndex:requestIndex withObject:requestToModify];
    [plistDict setObject:arrRequests forKey:@"Requests"];
    return [plistDict writeToFile: [self filepathForRequestsPlist] atomically:YES];
}


+(BOOL)dropSessionForRequest:(Request *)request{
    NSMutableArray *arrRequests;
    NSMutableArray *arrRequestObjs = [NSMutableArray array];
    NSMutableDictionary *plistDict;
    __block NSInteger requestIndex = 0;
    __block NSMutableDictionary *requestToModify = nil;
    
    if((plistDict = [self getRootRequestsDictionary]) != nil){
        arrRequests = plistDict[@"Requests"];
        [arrRequests enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *requestDict = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)obj];
            if([request.strReqID isEqualToString:requestDict[@"id"]]){
                requestToModify = requestDict;
                requestIndex = [arrRequests indexOfObject:requestDict];
            }
        }];
    }
    [arrRequests removeObject:requestToModify];
    [plistDict setObject:arrRequests forKey:@"Requests"];
    return [plistDict writeToFile: [self filepathForRequestsPlist] atomically:YES];
}

@end
