//
//  PAPasswordOfTheDay.m
//  PassDay
//
//  Created by Guillermo Saenz on 1/20/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "PAPasswordOfTheDay.h"

#import <math.h>

#define Debug 0

@implementation PAPasswordOfTheDay

+ (NSString *)generateForDay:(NSDate *)date{
    ReallyDebug
    
    NSString *seed = @"MPSJKMDHAI";
    NSString *seedeight = [seed substringToIndex:8];
    NSString *seedten = seed;
    
    NSArray *table1 = @[
        @[@15, @15, @24, @20, @24],
        @[@13, @14, @27, @32, @10],
        @[@29, @14, @32, @29, @24],
        @[@23, @32, @24, @29, @29],
        @[@14, @29, @10, @21, @29],
        @[@34, @27, @16, @23, @30],
        @[@14, @22, @24, @17, @13]
    ];
    
    NSArray *table2 = @[
        @[@0, @1, @2, @9, @3, @4, @5, @6, @7, @8],
        @[@1, @4, @3, @9, @0, @7, @8, @2, @5, @6],
        @[@7, @2, @8, @9, @4, @1, @6, @0, @3, @5],
        @[@6, @3, @5, @9, @1, @8, @2, @7, @4, @0],
        @[@4, @7, @0, @9, @5, @2, @3, @1, @8, @6],
        @[@5, @6, @1, @9, @8, @0, @4, @3, @2, @7]
    ];
    
    NSArray *alphanum = @[
                          @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"A", @"B", @"C", @"D",
                          @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R",
                          @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"
                          ];
    
    NSMutableArray *list1 = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *list2 = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *list3 = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *list4 = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *list5 = [NSMutableArray arrayWithCapacity:10];
    
    int year;
    int month;
    int dayOfMonth;
    int dayOfWeek;

    // Now let's generate one password for each day
    // For each iteration advance the date one day
    
    // Last two digits of the year
    //TODO: year = date.Year % 100;
    year = 15;
    
    // Number of the month (no leading zero; January == 0)
    //TODO: month = date.Month;
    month = 0;
    
    // Day of the month
    //TODO: dayOfMonth = date.Day;
    dayOfMonth = 21;
    
    // Day of the week. Normally 0 would be Sunday but we need it to be Monday.
    //TODO: dayOfWeek = (int)date.DayOfWeek - 1;
    dayOfWeek = 2;
    
    if (dayOfWeek < 0) {
        dayOfWeek = 6;
    }

    // Now build the lists that will be used by each other.
    // list1
    for (int i = 0; i <= 4; i++) {
        list1[i] = table1[dayOfWeek][i];
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
        list2[i] = @([[seedeight substringWithRange:NSMakeRange(i, 1)] characterAtIndex:0] % 36);
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
        list4[i] = list3[[table2[num8][i] intValue]];
    }
    
    // list5
    for (int i = 0; i <= 9; i++) {
        list5[i] = @(([[seedten substringWithRange:NSMakeRange(i, 1)] characterAtIndex:0] + [list4[i] intValue]) % 36);
    }
    
    // Finally, build the password of the day.
    int len = (int)list5.count;
    //NSLog(@"len: %i", len);
    NSString *passwordOfTheDay = [NSString new];
    for (int i = 0; i < len; i++) {
        /*NSLog(@"i: %i", i);
        NSLog(@"(int)list5[i]: %i", [list5[i] intValue]);
        NSLog(@"Num: %@", alphanum[[list5[i] intValue]]);*/
        passwordOfTheDay = [passwordOfTheDay stringByAppendingString:alphanum[[list5[i] intValue]]];
    }
    
    return passwordOfTheDay;
}

@end
