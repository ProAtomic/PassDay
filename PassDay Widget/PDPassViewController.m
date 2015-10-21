//
//  PDPassViewController.m
//  PassDay Widget
//
//  Created by Guillermo Saenz on 10/21/15.
//  Copyright © 2015 Property Atomic Strong SAC. All rights reserved.
//

#define IfDebug Debug==1
#define ReallyDebug if(IfDebug)NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));

#import "PDPassViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <PDPasswordOfTheDaySILibrary/PDPasswordOfTheDaySILibrary.h>

#define Debug 0

@interface PDPassViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblKey;

@end

@implementation PDPassViewController

- (void)viewDidLoad {
    ReallyDebug
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    ReallyDebug
    [super viewDidAppear:animated];
    
    [self updateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    ReallyDebug
    
    [self updateData];
    completionHandler(NCUpdateResultNewData);
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
    return UIEdgeInsetsZero;
}

#pragma mark - Actions

- (IBAction)copyActn:(id)sender {
    ReallyDebug
    
    [self updateData];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.lblKey.text];
}

#pragma mark - Update data

- (void)updateData{
    ReallyDebug
    
    PDPasswordObject *passwordObject = [[PDPasswordOfTheDaySI sharedInstance] generatePasswordForToday];
    [self.lblDate setText:passwordObject.date];
    [self.lblKey setText:passwordObject.password];
}

@end
