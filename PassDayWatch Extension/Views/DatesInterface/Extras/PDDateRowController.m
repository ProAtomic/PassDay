//
//  PDDateRowController.m
//  PassDay
//
//  Created by Guillermo Saenz on 01/21/16.
//  Copyright © 2016 Property Atomic Strong SAC. All rights reserved.
//

#import "PDDateRowController.h"

@interface PDDateRowController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceSeparator *separator;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *dateLbl;

@end

@implementation PDDateRowController

- (void)setPasswordObject:(PDPasswordObject *)passwordObject{
    
    _passwordObject = passwordObject;
    
    [self updatePasswordObject];
}

- (void)updatePasswordObject{
    
    [self.dateLbl setText:self.passwordObject.date];
}

- (void)setAsToday{
    [self.separator setColor:[UIColor yellowColor]];
    [self.dateLbl setTextColor:[UIColor yellowColor]];
    [self.dateLbl setText:NSLocalizedString(@"dateLbl.today", @"Text for label of today")];
}

@end
