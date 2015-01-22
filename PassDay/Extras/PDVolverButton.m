//
//  PDVolverButton.m
//  PassDay
//
//  Created by Guillermo Saenz on 1/21/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "PDVolverButton.h"

#define Debug 0

@implementation PDVolverButton

- (id)init {
    self = [super init];
    if (self) {
        [self setupPDVB];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupPDVB];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupPDVB];
    }
    return self;
}

- (void)setupPDVB{
    ReallyDebug
    
    [self addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismissViewController{
    ReallyDebug
    
    [self.viewController resignFirstResponder];
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

@end
