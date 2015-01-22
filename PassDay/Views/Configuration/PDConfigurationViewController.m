//
//  PDConfigurationViewController.m
//  PassDay
//
//  Created by Guillermo Saenz on 1/21/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "PDConfigurationViewController.h"

#define Debug 0

@interface PDConfigurationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *lblSeed;

@end

@implementation PDConfigurationViewController

- (void)viewDidLoad {
    ReallyDebug
    [super viewDidLoad];
    
    [self.lblSeed setText:[[PDPasswordOfTheDaySI sharedInstance] seed]];
}

- (void)viewWillDisappear:(BOOL)animated{
    ReallyDebug
    [super viewWillDisappear:animated];
    
    if (![self.lblSeed.text isEqualToString:[PDPasswordOfTheDaySI defaultSeed]]) [[PDPasswordOfTheDaySI sharedInstance] setSeed:self.lblSeed.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)resetActn:(id)sender {
    ReallyDebug
    
    [self.lblSeed setText:[PDPasswordOfTheDaySI defaultSeed]];
}

@end
