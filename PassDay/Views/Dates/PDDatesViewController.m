//
//  PDDatesViewController.m
//  PassDay
//
//  Created by Guillermo Saenz on 1/21/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "PDDatesViewController.h"

#import "PDPasswordsViewController.h"
#import "PDProgressHUD.h"

#define Debug 0

@interface PDDatesViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerStart;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerEnd;

@end

@implementation PDDatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickerValueDidChange:(UIDatePicker *)sender {
    ReallyDebug
    
}

#pragma mark - Action

- (IBAction)generateActn:(id)sender {
    ReallyDebug
    
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate interval:NULL forDate:self.datePickerStart.date];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate interval:NULL forDate:self.datePickerEnd.date];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit fromDate:fromDate toDate:toDate options:0];
    
    NSInteger numberOfDays = [difference day]+1;
    
    if (numberOfDays>365) {
        
        PDProgressHUD *progressHUD = [PDProgressHUD newWithText:NSLocalizedString(@"Less than 365\ndays please", nil)];
        [progressHUD showInView:self.view];
        
        return;
    }else if (numberOfDays<1){
        
        PDProgressHUD *progressHUD = [PDProgressHUD newWithText:NSLocalizedString(@"Negative dates\nnot allowed!", nil)];
        [progressHUD showInView:self.view];
        
        [self.datePickerStart setDate:[NSDate date]];
        [self.datePickerEnd setDate:[NSDate date]];
        
        return;
    }
    
    [self performSegueWithIdentifier:@"GenerateSID" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"GenerateSID"]) {
        PDPasswordsViewController *passwordsVC = [segue destinationViewController];
        
        [passwordsVC setStartDate:self.datePickerStart.date];
        [passwordsVC setEndDate:self.datePickerEnd.date];
    }
}


@end
