//
//  UIView+NibLoading.m
//  PassDay
//
//  Created by Guillermo Saenz on 1/9/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "UIView+NibLoading.h"

@implementation UIView (NibLoading)

+ (id) loadFromNib {
    NSString* nibName = NSStringFromClass([self class]);
    NSArray* elements = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    for (NSObject* anObject in elements) {
        if ([anObject isKindOfClass:[self class]]) {
            return anObject;
        }
    }
    return nil;
}

@end
