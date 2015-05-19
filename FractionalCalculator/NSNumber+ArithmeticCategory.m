//
//  NSNumber+ArithmeticCategory.m
//  FractionalCalculator
//
//  Created by Mikkel Petersen on 4/14/15.
//  Copyright (c) 2015 Mikkel Vester Petersen. All rights reserved.
//
//  Implements ArithmeticCategory for NSNumber

#import "NSNumber+ArithmeticCategory.h"
#import "ArithmeticOperationProtocol.h"

@implementation NSNumber (ArithmeticCategory)

-(id<ArithmeticOperationProtocol>) add:(NSNumber<ArithmeticOperationProtocol>*)other
{
    float x = self.floatValue + other.floatValue;
    return [NSNumber numberWithFloat:x];
}

-(id<ArithmeticOperationProtocol>)subtract:(NSNumber<ArithmeticOperationProtocol>*)other
{
    float x = self.floatValue - other.floatValue;
    return [NSNumber numberWithFloat:x];
}

-(id<ArithmeticOperationProtocol>)multiply:(NSNumber<ArithmeticOperationProtocol>*)other
{
    float x = self.floatValue * other.floatValue;
    return [NSNumber numberWithFloat:x];
}

-(id<ArithmeticOperationProtocol>)divide:(NSNumber<ArithmeticOperationProtocol>*)other
{
    float x = self.floatValue / other.floatValue;
    return [NSNumber numberWithFloat:x];
}

-(id<ArithmeticOperationProtocol>)squareroot
{
    return [NSNumber numberWithFloat:sqrtf(self.floatValue)];
}

-(id<ArithmeticOperationProtocol>)negate
{
    return [NSNumber numberWithBool:![self boolValue]];
}

@end
