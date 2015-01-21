//
//  PAPasswordOfTheDaySI.h
//  PassDay
//
//  Created by Guillermo Saenz on 1/21/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

@interface PAPasswordOfTheDaySI : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (PAPasswordOfTheDaySI*)sharedInstance;

@property (nonatomic, strong) NSString *seed;

- (NSString *)generatePasswordForToday;
- (NSString *)generatePasswordForDay:(NSDate *)date;
+ (NSString *)defaultSeed;

@end
