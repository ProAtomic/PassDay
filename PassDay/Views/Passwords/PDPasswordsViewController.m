//
//  PDPasswordsViewController.m
//  PassDay
//
//  Created by Guillermo Saenz on 1/21/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "PDPasswordsViewController.h"

#import "PDCarousel.h"

#define Debug 0

@interface PDPasswordsViewController () <iCarouselDataSource, iCarouselDelegate>

@property (weak, nonatomic) IBOutlet PDCarousel *carouselView;
@property (nonatomic, strong) NSArray *generatedPasswords;

@end

@implementation PDPasswordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [[PDPasswordOfTheDaySI sharedInstance] generatePasswordFromStartDay:self.startDate toEndDay:self.endDate withCompletion:^(NSArray *passwordsArray) {
        self.generatedPasswords = passwordsArray;
        [self.carouselView reloadData];
    } withFailure:^(PDAlgorithmFailure algorithmFailure) {
        NSLog(@"F %i", (int)algorithmFailure);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(PDCarousel *)carousel{
    ReallyDebug
    
    return [self.generatedPasswords count];
}

- (UIView *)carousel:(PDCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(PDCarouselDateCell *)view{
    ReallyDebug
    
    if (view == nil){
        view = [PDCarouselDateCell loadFromNib];
    }
    
    PDPasswordObject *object = self.generatedPasswords[index];
    
    [view.lblPassword setText:[object.date stringByAppendingFormat:@" %@", object.password]];
    
    return view;
}

#pragma mark - iCarouselDelegate

- (void)carouselCurrentItemIndexDidChange:(PDCarousel *)carousel{
    ReallyDebug
    
    //NSLog(@"Index: %@", @(carousel.currentItemIndex));
}

#pragma mark - Actions

- (IBAction)copyActn:(id)sender {
    ReallyDebug
    
    PDPasswordObject *object = self.generatedPasswords[self.carouselView.currentItemIndex];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:object.password];
}

@end
