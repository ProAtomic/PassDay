//
//  PDPasswordInterfaceController.m
//  PassDay
//
//  Created by Guillermo Saenz on 2/21/16.
//  Copyright © 2016 Property Atomic Strong SAC. All rights reserved.
//

#import "PDPasswordInterfaceController.h"

#import "PDPasswordOfTheDaySI.h"

@interface PDPasswordInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *dateLbl;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *passwordLbl;

@property (nonatomic, strong) PDPasswordObject *passwordObject;

@end

@implementation PDPasswordInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    if ([context isKindOfClass:[PDPasswordObject class]]) {
        [self setPasswordObject:context];
    }
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)setPasswordObject:(PDPasswordObject *)passwordObject{
    
    _passwordObject = passwordObject;
    
    [self updatePassdword];
}

- (void)updatePassdword{
    
    [self.dateLbl setText:self.passwordObject.date];
    [self.passwordLbl setText:self.passwordObject.password];
}

@end



