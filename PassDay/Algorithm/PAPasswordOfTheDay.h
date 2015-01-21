//
//  PAPasswordOfTheDay.h
//  PassDay
//
//  Created by Guillermo Saenz on 1/20/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PAPasswordOfTheDay : NSObject

+ (NSString *)generateForDay:(NSDate *)date;

@end
