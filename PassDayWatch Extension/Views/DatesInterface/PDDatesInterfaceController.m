//
//  PDDatesInterfaceController.m
//  PassDay
//
//  Created by Guillermo Saenz on 01/21/16.
//  Copyright © 2016 Property Atomic Strong SAC. All rights reserved.
//

#import "PDDatesInterfaceController.h"

#import "PDPasswordOfTheDaySI.h"

#import "PDDateRowController.h"

@interface PDDatesInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *tableInterface;

@property (nonatomic, strong) NSArray *passwordObjects;

@end

@implementation PDDatesInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponent = [NSDateComponents new];
    NSDate *date = [NSDate date];
    
    [dayComponent setDay:-10];
    NSDate *fromDate = [theCalendar dateByAddingComponents:dayComponent toDate:date options:0];
    
    [dayComponent setDay:10];
    NSDate *toDate = [theCalendar dateByAddingComponents:dayComponent toDate:date options:0];
    
    [[PDPasswordOfTheDaySI sharedInstance] generatePasswordFromStartDay:fromDate toEndDay:toDate withCompletion:^(NSArray *passwordsArray) {
        [self setPasswordObjects:passwordsArray];
    } withFailure:^(PDAlgorithmFailure algorithmFailure) {
        NSLog(@"Fallo! :(");
    }];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)setPasswordObjects:(NSArray *)passwordObjects{
    _passwordObjects = passwordObjects;
    
    [self refreshTable];
}

- (void)refreshTable{
    [self.tableInterface setNumberOfRows:self.passwordObjects.count withRowType:@"DateRow"];
    [self.tableInterface scrollToRowAtIndex:12];
    
    for (int i = 0; i<self.tableInterface.numberOfRows; i++) {
        PDDateRowController *rowController = [self.tableInterface rowControllerAtIndex:i];
        if (rowController) {
            [rowController setPasswordObject:[self.passwordObjects objectAtIndex:i]];
            
            if (i == 10) {
                [rowController setAsToday];
            }
        }
    }
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex{
    PDPasswordObject *passwordObject = [self.passwordObjects objectAtIndex:rowIndex];
    [self presentControllerWithName:@"Password" context:passwordObject];
}

@end
