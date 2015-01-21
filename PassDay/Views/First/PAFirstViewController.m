//
//  PAFirstViewController.m
//  PassDay
//
//  Created by Guillermo Saenz on 1/20/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "PAFirstViewController.h"

#import "PAPasswordOfTheDaySI.h"

@interface PAFirstViewController ()

@property (weak, nonatomic) IBOutlet UILabel *placeHolder;

@end

@implementation PAFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Emepo");
    
    NSDate *date = [NSDate date];
    
    for (int i  = 0; i<365; i++) {
        NSLog(@"C%i: %@", i, [[PAPasswordOfTheDaySI sharedInstance] generatePasswordForDay:[date dateByAddingTimeInterval:60*60*24*i]]);
    }
    
    NSLog(@"Termino");
    
    NSString *password = [[PAPasswordOfTheDaySI sharedInstance] generatePasswordForToday];
    
    [self.placeHolder setText:password];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
