// Author of Original JavaScript Version: Raul Pedro Fernandes Santos
// Author of this Objective-C port is Guillermo Sáenz Urday of PROPERTY ATOMIC STRONG SAC
// Project homepage for JavaScript Version: http://www.borfast.com/projects/arrispwgen
//
// This software is distributed under the Simplified BSD License.
//
// Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "PDPasswordOfTheDaySI.h"

#define Debug 0

static NSString *defaultSeed = @"MPSJKMDHAI";

@interface PDPasswordOfTheDaySI ()

@property (nonatomic, strong) NSString *seed8;
@property (nonatomic, strong) NSArray *tableValues1, *tableValues2, *alphanumValuesTable;
@property (nonatomic, strong) NSDateFormatter *dateFormatterYear, *dateFormatterMonth, *dateFormatterDay, *dateFormatterComplete;
@property (nonatomic, strong) NSCalendar *calendar;

@end

@implementation PDPasswordOfTheDaySI

static PDPasswordOfTheDaySI *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

- (id)copy{
    return [[PDPasswordOfTheDaySI alloc] init];
}

- (id)mutableCopy{
    return [[PDPasswordOfTheDaySI alloc] init];
}

- (id) init{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    
    if (self) {
        NSString *savedSeed = [[NSUserDefaults standardUserDefaults] stringForKey:@"seedKey"];
        
        [self setSeed:savedSeed?savedSeed:[PDPasswordOfTheDaySI defaultSeed]];
        [self setTables];
        [self setupDateFormatters];
    }
    
    return self;
}

- (void)setSeed:(NSString *)seed{
    ReallyDebug
    
    _seed = seed;
    self.seed8 = [seed substringToIndex:8];
    
    NSString *savedSeed = [[NSUserDefaults standardUserDefaults] stringForKey:@"seedKey"];
    
    if (![savedSeed isEqualToString:seed]) {
        [[NSUserDefaults standardUserDefaults] setObject:seed forKey:@"seedKey"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)setTables{
    ReallyDebug
    
    self.tableValues1 = @[
                        @[@15, @15, @24, @20, @24],
                        @[@13, @14, @27, @32, @10],
                        @[@29, @14, @32, @29, @24],
                        @[@23, @32, @24, @29, @29],
                        @[@14, @29, @10, @21, @29],
                        @[@34, @27, @16, @23, @30],
                        @[@14, @22, @24, @17, @13]
                        ];
    
    self.tableValues2 = @[
                        @[@0, @1, @2, @9, @3, @4, @5, @6, @7, @8],
                        @[@1, @4, @3, @9, @0, @7, @8, @2, @5, @6],
                        @[@7, @2, @8, @9, @4, @1, @6, @0, @3, @5],
                        @[@6, @3, @5, @9, @1, @8, @2, @7, @4, @0],
                        @[@4, @7, @0, @9, @5, @2, @3, @1, @8, @6],
                        @[@5, @6, @1, @9, @8, @0, @4, @3, @2, @7]
                        ];
    
    self.alphanumValuesTable = @[
                          @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"A", @"B", @"C", @"D",
                          @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R",
                          @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"
                          ];
}

- (void)setupDateFormatters{
    ReallyDebug
    
    self.dateFormatterYear = [NSDateFormatter new];
    [self.dateFormatterYear setDateFormat:@"YY"];
    self.dateFormatterMonth = [NSDateFormatter new];
    [self.dateFormatterMonth setDateFormat:@"MM"];
    self.dateFormatterDay = [NSDateFormatter new];
    [self.dateFormatterDay setDateFormat:@"dd"];
    self.dateFormatterComplete = [NSDateFormatter new];
    [self.dateFormatterComplete setDateFormat:@"MM/dd/YYYY"];
    
    self.calendar = [NSCalendar currentCalendar];
}

#pragma mark - Algorithm

- (PDPasswordObject *)generatePasswordForToday{
    return [self generatePasswordForDay:[NSDate date]];
}

- (void)generatePasswordFromStartDay:(NSDate *)startDay toEndDay:(NSDate *)endDay withCompletion:(void (^)(NSArray *passwordsArray))completion withFailure:(void (^)(PDAlgorithmFailure algorithmFailure))failure{
    ReallyDebug
    
    NSAssert(startDay, nil);
    NSAssert(endDay, nil);
    NSAssert(completion, nil);
    NSAssert(failure, nil);
    
    NSDate *fromDate;
    NSDate *toDate;
    
    [self.calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate interval:NULL forDate:startDay];
    [self.calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate interval:NULL forDate:endDay];
    
    NSDateComponents *difference = [self.calendar components:NSDayCalendarUnit fromDate:fromDate toDate:toDate options:0];
    
    NSInteger numberOfDays = [difference day]+1;
    
    if (numberOfDays>365) {
        failure(PDAlgorithmFailureOutOfBounds);
        return;
    }else if (numberOfDays<1){
        failure(PDAlgorithmFailureNegativeRestDates);
        return;
    }
    
    NSDateComponents *dayComponent = [NSDateComponents new];
    dayComponent.day = 1;
    
    NSMutableArray *passwords = [NSMutableArray array];
    NSDate *tempDate = startDay;
    for (int i = 0; i<numberOfDays; i++) {
        if (i!=0) tempDate = [self.calendar dateByAddingComponents:dayComponent toDate:tempDate options:0];
        [passwords addObject:[self generatePasswordForDay:tempDate]];
    }

    if (passwords) {
        completion ([passwords copy]);
        return;
    }else{
        failure(PDAlgorithmFailureIterationError);
        return;
    }
}

- (PDPasswordObject *)generatePasswordForDay:(NSDate *)date{
    ReallyDebug
    
    NSAssert(self.seed, nil);
    NSAssert(date, nil);
    
    NSMutableArray *list1 = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *list2 = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *list3 = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *list4 = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *list5 = [NSMutableArray arrayWithCapacity:10];
    
    // Now let's generate one password for each day
    
    // Last two digits of the year
    int year = [[self.dateFormatterYear stringFromDate:date] intValue];
    
    // Number of the month
    int month = [[self.dateFormatterMonth stringFromDate:date] intValue];
    
    // Day of the month
    int dayOfMonth = [[self.dateFormatterDay stringFromDate:date] intValue];
    
    // Day of the week. Normally 0 would be Sunday but we need it to be Monday.
    NSDateComponents *dateC = [self.calendar components:NSWeekdayCalendarUnit fromDate:date];
    int dayOfWeek = (int)[dateC weekday] - 2;
    
    if (dayOfWeek < 0) {
        dayOfWeek = 6;
    }
    if (IfDebug) NSLog(@"Y: %i M: %i MD: %i WD: %i", year, month, dayOfMonth, dayOfWeek);
    // Now build the lists that will be used by each other.
    // list1
    for (int i = 0; i <= 4; i++) {
        list1[i] = self.tableValues1[dayOfWeek][i];
    }
    
    list1[5] = @(dayOfMonth);
    if (((year + month) - dayOfMonth) < 0) {
        list1[6] = @((((year + month) - dayOfMonth) + 36) % 36);
    } else {
        list1[6] = @(((year + month) - dayOfMonth) % 36);
    }
    
    list1[7] = @((((3 + ((year + month) % 12)) * dayOfMonth) % 37) % 36);
    
    // list2
    for (int i = 0; i <= 7; i++) {
        list2[i] = @([[self.seed8 substringWithRange:NSMakeRange(i, 1)] characterAtIndex:0] % 36);
    }
    
    // list3
    for (int i = 0; i <= 7; i++) {
        list3[i] = @((([list1[i] intValue] + [list2[i] intValue])) % 36);
    }
    
    list3[8] = @(([list3[0] intValue] + [list3[1] intValue] + [list3[2] intValue] + [list3[3] intValue] + [list3[4] intValue] +
                  [list3[5] intValue] + [list3[6] intValue] + [list3[7] intValue]) % 36);
    int num8 = [list3[8] intValue] % 6;
    list3[9] = @(round(pow(num8, 2)));
    
    // list4
    for (int i = 0; i <= 9; i++) {
        list4[i] = list3[[self.tableValues2[num8][i] intValue]];
    }
    
    // list5
    for (int i = 0; i <= 9; i++) {
        list5[i] = @(([[self.seed substringWithRange:NSMakeRange(i, 1)] characterAtIndex:0] + [list4[i] intValue]) % 36);
    }
    
    // Finally, build the password of the day.
    int len = (int)list5.count;
    //NSLog(@"len: %i", len);
    NSString *passwordOfTheDay = [NSString new];
    for (int i = 0; i < len; i++) {
        passwordOfTheDay = [passwordOfTheDay stringByAppendingString:self.alphanumValuesTable[[list5[i] intValue]]];
    }
    
    PDPasswordObject *pObject = [PDPasswordObject new];
    [pObject setPassword:passwordOfTheDay];
    [pObject setDate:[self.dateFormatterComplete stringFromDate:date]];
    
    return pObject;
}

#pragma mark - Returns

+ (NSString *)defaultSeed{
    return defaultSeed;
}

@end

@implementation PDPasswordObject

@end
