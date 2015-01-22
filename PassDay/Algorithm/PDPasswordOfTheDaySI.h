//
//  PDPasswordOfTheDaySI.h
//  PassDay
//
//  Created by Guillermo Saenz on 1/21/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

typedef enum : NSUInteger {
    PDAlgorithmFailureOutOfBounds,
    PDAlgorithmFailureNegativeRestDates,
    PDAlgorithmFailureIterationError,
    PDAlgorithmFailureUknown,
} PDAlgorithmFailure;

@class PDPasswordObject;

@interface PDPasswordOfTheDaySI : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (PDPasswordOfTheDaySI*)sharedInstance;

@property (nonatomic, strong) NSString *seed;

- (PDPasswordObject *)generatePasswordForToday;
- (PDPasswordObject *)generatePasswordForDay:(NSDate *)date;
- (void)generatePasswordFromStartDay:(NSDate *)startDay toEndDay:(NSDate *)endDay withCompletion:(void (^)(NSArray *passwordsArray))completion withFailure:(void (^)(PDAlgorithmFailure algorithmFailure))failure;
+ (NSString *)defaultSeed;

@end

@interface PDPasswordObject : NSObject

@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *date;

@end