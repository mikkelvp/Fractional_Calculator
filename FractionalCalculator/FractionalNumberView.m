//
//  FractionalNumberView.m
//  FractionalCalculator
//
//  Created by Mikkel Petersen on 4/19/15.
//  Copyright (c) 2015 Mikkel Vester Petersen. All rights reserved.
//

#import "FractionalNumberView.h"
#import "FractionalNumber.h"

@implementation FractionalNumberView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
        self.opaque = NO;
        self.hidden = NO;
        self.alpha = 1.0;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andFractionalNumber:(FractionalNumber *)aFractionalNumber
{
    self = [super initWithFrame:frame];
    if (self) {
        _fraction = aFractionalNumber;
        self.backgroundColor = [UIColor darkGrayColor];
        self.opaque = NO;
        self.hidden = NO;
        self.alpha = 1.0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1,1,1,1);
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, 0, self.bounds.size.height/2);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height/2);
    CGContextStrokePath(context);
    if (_fraction) {
        [self drawNumerator:[NSString stringWithFormat:@"%d", _fraction.numerator]];
        [self drawDenominator:[NSString stringWithFormat:@"%d", _fraction.denominator]];
    }
}

- (void)drawNumerator:(NSString*)aNumerator
{
    _numerator = [NSString stringWithString:aNumerator];
    UILabel *numerator = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  self.bounds.size.width,
                                                                  self.bounds.size.height/2-5)];
    [numerator setBackgroundColor:[UIColor clearColor]];
    [numerator setText:aNumerator];
    [numerator setTextAlignment: NSTextAlignmentCenter];
    [numerator setTextColor:[UIColor whiteColor]];
    [numerator setFont:[UIFont systemFontOfSize:20]];
    [self addSubview:numerator];
}

- (void)drawDenominator:(NSString*)aDenominator
{
    _denominator = [NSString stringWithString:aDenominator];
    UILabel *denominator = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                                    self.bounds.size.height/2,
                                                                    self.bounds.size.width,
                                                                    self.bounds.size.height/2-5)];
    [denominator setBackgroundColor:[UIColor clearColor]];
    [denominator setText:aDenominator];
    [denominator setTextColor:[UIColor whiteColor]];
    [denominator setFont:[UIFont systemFontOfSize:20]];
    [denominator setTextAlignment: NSTextAlignmentCenter];
    [self addSubview:denominator];
}

@end
