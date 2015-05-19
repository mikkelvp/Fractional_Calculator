//
//  CalcEngine.m
//  FractionalCalculator
//
//  Created by Mikkel Petersen on 4/18/15.
//  Copyright (c) 2015 Mikkel Vester Petersen. All rights reserved.
//

#import "CalcEngine.h"
#import "ShuntingYard.h"
#import "Operator.h"
#import "FractionalNumber.h"
#import "NSMutableArray+QueueStack.h"

static CalcEngine* _sharedSingletonInstance;

@implementation CalcEngine

@synthesize shuntingYard = _shuntingYard;

-(CalcEngine*)init
{
    self = [super init];
    if( self ){
        _shuntingYard = [ShuntingYard sharedInstance];
    }
    return self;
}

+(void)initialize
{
    if ( [CalcEngine class] == self) {
        _sharedSingletonInstance = [self new];
    }
}

+(CalcEngine*)sharedInstance
{
    return _sharedSingletonInstance;
}

/* Calculates result from postfix */
-(FractionalNumber *)CalculateWithTokens:(NSMutableArray *)tokens
{
    NSArray* postfix = [_shuntingYard shuntingYardWithTokens:tokens];
    NSMutableArray* stack = [[NSMutableArray alloc] initWithCapacity:postfix.count];
    FractionalNumber* x;
    FractionalNumber* y;
    Operator* operator;
    
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
    for (id token in postfix) {
        if ( [token isKindOfClass:[FractionalNumber class]] ) {
            
            [stack push:token];
        }
        else if ( [token isKindOfClass:[Operator class]] ) {
            operator = (Operator*)token;
            x = [stack pop];
            y = [stack pop];
            [stack push:[y performSelector:operator.selector withObject:x]];
        }
    }
#pragma clang diagnostic pop
    
    if (stack.count > 1) {
        NSLog(@"Stack count is > 1. Something failed");
    }
    
    FractionalNumber* result = [stack pop];
    
    return result;
}

@end
