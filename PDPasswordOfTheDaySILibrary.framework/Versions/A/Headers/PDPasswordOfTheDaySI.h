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

#import <UIKit/UIKit.h>

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