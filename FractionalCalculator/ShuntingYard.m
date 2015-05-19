//
//  ShuntingYard.m
//  FractionalCalculator
//
//  Created by Mikkel Petersen on 4/16/15.
//  Copyright (c) 2015 Mikkel Vester Petersen. All rights reserved.
//

#import "ShuntingYard.h"
#import "Operator.h"
#import "FractionalNumber.h"
#import "NSMutableArray+QueueStack.h"

static ShuntingYard* _sharedSingletonInstance;

@implementation ShuntingYard

@synthesize stack = _stack, queue = _queue;

-(ShuntingYard*)init
{
    self = [super init];
    if( self ){
        _stack = [[NSMutableArray alloc] init];
        _queue = [[NSMutableArray alloc] init];
    }
    return self;
}

+(void)initialize
{
    if ( [ShuntingYard class] == self) {
        _sharedSingletonInstance = [self new];
    }
}

+(ShuntingYard*)sharedInstance
{
    return _sharedSingletonInstance;
}

-(NSMutableArray*)shuntingYardWithTokens:(NSMutableArray*)tokens
{
    // clear stack and queue
    [_stack removeAllObjects];
    [_queue removeAllObjects];
    
    for (id token in tokens) {
        // if token is Fraction, put it in the queue
        if ([token isKindOfClass:[FractionalNumber class]]) {
            [_queue enqueue:token];
        }
        // if token is Operator, put it on the stack
        else if ([token isKindOfClass:[Operator class]]) {
            Operator* o1 = (Operator*)token;
            Operator* o2 = (Operator*)[_stack peek];
            while ( [[_stack peek] isKindOfClass:[Operator class]] && o1.precedence <= o2.precedence ) {
                [_queue enqueue:[_stack pop]];
            }
            [_stack push:o1];
        }
    }
    // While there are still operator tokens in the stack, pop them to queue
    while ([_stack count] > 0) {
        [_queue enqueue:[_stack pop]];
    }
    
    return _queue;
}


@end
