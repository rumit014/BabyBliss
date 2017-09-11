//
//  PProfileManager.m
//  BabyBliss
//
//  Created by Rumit Singh Tuteja on 4/18/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

#import "PProfileManager.h"
#import "ParentProfile.h"

@implementation PProfileManager

+(ParentProfile *)fetchParentProfileWithID:(NSString *)emailID{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Parents" ofType:@"plist"];
    NSArray *arrParents = [NSDictionary dictionaryWithContentsOfFile:filepath][@"Parents"];
    __block ParentProfile *parent = nil;
    [arrParents enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = (NSDictionary *)obj;
        if([obj[@"id"] isEqualToString:emailID]){
            parent = [[ParentProfile alloc] createProfile:dict];
        }
    }];
    return parent;
}

@end
