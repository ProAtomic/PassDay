//
//  UIView+Hierarchy.h
//
//  Created by Guillermo Sáenz on 26/02/2013.
//
//


#import "UIView+Hierarchy.h"

@implementation UIView(Hierarchy)

- (UIViewController*)viewController{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
