//
//  FractionalNumberView.h
//  FractionalCalculator
//
//  Created by Mikkel Petersen on 4/19/15.
//  Copyright (c) 2015 Mikkel Vester Petersen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FractionalNumber.h"

@interface FractionalNumberView : UIView

@property FractionalNumber* fraction;
@property NSString* numerator;
@property NSString* denominator;

- (void)drawNumerator:(NSString*)aNumerator;
- (void)drawDenominator:(NSString*)aDenominator;
- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame andFractionalNumber:(FractionalNumber *)aFractionalNumber;
@end
