//
//  Operator.m
//  FractionalCalculator
//
//  Created by Mikkel Petersen on 4/14/15.
//  Copyright (c) 2015 Mikkel Vester Petersen. All rights reserved.
//

#import "Operator.h"

static Operator* _sharedAddInstance;
static Operator* _sharedSubtractInstance;
static Operator* _sharedMultiplyInstance;
static Operator* _sharedDivideInstance;

@implementation Operator

@synthesize precedence, selector;

-(Operator *)initWithPrecedence:(NSUInteger)thePrecedence selector:(SEL)theSelector
{
    self = [super init];
    if (self) {
        precedence = thePrecedence;
        selector = theSelector;
    }
    return self;
}

+(Operator *)sharedAddOperator
{
    if (_sharedAddInstance == nil) {
        SEL addSelector = sel_registerName("add:");
        _sharedAddInstance = [[Operator alloc] initWithPrecedence: addSubPrecedence
                                                         selector: addSelector];
    }
    return _sharedAddInstance;
}

+(Operator *)sharedSubtractOperator
{
    if (_sharedSubtractInstance == nil) {
        SEL subtractSelector = sel_registerName("subtract:");
        _sharedSubtractInstance = [[Operator alloc] initWithPrecedence: addSubPrecedence
                                                         selector: subtractSelector];
    }
    return _sharedSubtractInstance;
}

+(Operator *)sharedMultiplyOperator
{
    if (_sharedMultiplyInstance == nil) {
        SEL multiplySelector = sel_registerName("multiply:");
        _sharedMultiplyInstance = [[Operator alloc] initWithPrecedence: multDivPrecedence
                                                              selector: multiplySelector];
    }
    return _sharedMultiplyInstance;
}

+(Operator *)sharedDivideOperator
{
    if (_sharedDivideInstance == nil) {
        SEL divideSelector = sel_registerName("divide:");
        _sharedDivideInstance = [[Operator alloc] initWithPrecedence: multDivPrecedence
                                                              selector: divideSelector];
    }
    return _sharedDivideInstance;
}

@end
