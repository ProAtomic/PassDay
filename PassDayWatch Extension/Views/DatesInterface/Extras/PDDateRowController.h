//
//  PDDateRowController.h
//  PassDay
//
//  Created by Guillermo Saenz on 01/21/16.
//  Copyright © 2016 Property Atomic Strong SAC. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

#import "PDPasswordOfTheDaySI.h"

@interface PDDateRowController : NSObject

@property (nonatomic, strong) PDPasswordObject *passwordObject;

- (void)setAsToday;

@end
