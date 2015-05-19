//
//  FractionalNumber.h
//  FractionalCalculator
//
//  Created by Mikkel Petersen on 4/14/15.
//  Copyright (c) 2015 Mikkel Vester Petersen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArithmeticOperationProtocol.h"

@interface FractionalNumber : NSObject <ArithmeticOperationProtocol>

@property (nonatomic, readonly, assign) int numerator;
@property (nonatomic, readonly, assign) int denominator;

-(FractionalNumber*)initWithNumerator:(int)aNumerator denominator:(int)aDenominator;
-(FractionalNumber*)simplifyWithNumerator:(int)n denominator:(int)d;
@end
