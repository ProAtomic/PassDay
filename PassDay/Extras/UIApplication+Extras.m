//
//  UIApplication+Extras.m
//  Waqay
//
//  Created by Guillermo Saenz on 1/15/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "UIApplication+Extras.h"

@implementation UIApplication (Extras)

+ (NSString*)versionNumber{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString*)buildNumber{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
}

+ (NSString*)versionBuildNumber{
    NSString *version = [self versionNumber];
    NSString *buildNumber = [self buildNumber];
    
    NSString *versionBuildNumber = [version stringByAppendingString:[NSString stringWithFormat:@"(%@)", buildNumber]];
    
    return versionBuildNumber;
}

@end
