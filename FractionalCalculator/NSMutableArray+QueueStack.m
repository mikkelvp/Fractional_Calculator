//
//  NSMutableArray+Queue.m
//  FractionalCalculator
//
//  Created by Mikkel Petersen on 4/16/15.
//  Copyright (c) 2015 Mikkel Vester Petersen. All rights reserved.
//

#import "NSMutableArray+QueueStack.h"

@implementation NSMutableArray (QueueStack)

// queue

-(void)enqueue:(id)obj
{
    [self addObject:obj];
}

-(id)dequeue
{
    id obj = [self firstObject];
    if (obj != nil) {
        [self removeObjectAtIndex:0];
    }
    return obj;
}

// stack

-(void)push:(id)obj
{
    [self addObject:obj];
}

-(id)pop
{
    id obj = [self lastObject];
    if (obj != nil) {
        [self removeLastObject];
    }
    return obj;
}

-(id)peek
{
    return [self lastObject];
}

@end
