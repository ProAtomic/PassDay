//
//  PDProgressHUD.m
//  PassDay
//
//  Created by Guillermo Saenz on 1/22/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "PDProgressHUD.h"

#import "JGProgressHUDFadeZoomAnimation.h"

@implementation PDProgressHUD

+ (PDProgressHUD*)newWithText:(NSString *)text{
    PDProgressHUD *progressHUD = [PDProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    
    [progressHUD setInteractionType:JGProgressHUDInteractionTypeBlockAllTouches];
    [progressHUD setIndicatorView:nil];
    [progressHUD setSquare:YES];
    [progressHUD.textLabel setText:text];
    [progressHUD setAnimation:[JGProgressHUDFadeZoomAnimation animation]];
    [progressHUD setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.4f]];
    [progressHUD dismissAfterDelay:3.0];
    
    return progressHUD;
}

@end
