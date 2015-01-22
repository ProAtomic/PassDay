//
//  PDCarousel.m
//  PassDay
//
//  Created by Guillermo Saenz on 1/21/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "PDCarousel.h"

#define Debug 0

@interface PDCarousel () <iCarouselDelegate> {
    __weak id<iCarouselDelegate> _myDelegate;
}

@end

@implementation PDCarousel

- (id)init {
    self = [super init];
    if (self) {
        [self setupWQC];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupWQC];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupWQC];
    }
    return self;
}

- (void)setupWQC{
    ReallyDebug
    
    [self setDelegate:self];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setVertical:YES];
    [self setType:iCarouselTypeLinear];
    [self setClipsToBounds:YES];
}

- (id<iCarouselDelegate>)delegate{
    return _myDelegate;
}

- (void)setDelegate:(id<iCarouselDelegate>)aDelegate{
    
    [super setDelegate:self];
    
    if (aDelegate != _myDelegate){
        _myDelegate = aDelegate;
    }
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    
    if (_myDelegate != (id<iCarouselDelegate>)self && [_myDelegate respondsToSelector:@selector(carousel:valueForOption:withDefault:)]){
        [_myDelegate carousel:carousel valueForOption:option withDefault:value];
    }
    
    switch (option)
    {
        case iCarouselOptionWrap:
            return NO;
        case iCarouselOptionSpacing:
            return value;
        case iCarouselOptionFadeMin:
            return -0.3;
        case iCarouselOptionFadeMax:
            return 0.3;
        case iCarouselOptionFadeRange:
            return (int)(carousel.frame.size.height / 30);
        default:
            return value;
    }
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    if (_myDelegate != (id<iCarouselDelegate>)self && [_myDelegate respondsToSelector:@selector(carouselCurrentItemIndexDidChange:)]){
        [_myDelegate carouselCurrentItemIndexDidChange:carousel];
    }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if (_myDelegate != (id<iCarouselDelegate>)self && [_myDelegate respondsToSelector:@selector(carousel:didSelectItemAtIndex:)]){
        [_myDelegate carousel:carousel didSelectItemAtIndex:index];
    }
}

@end
