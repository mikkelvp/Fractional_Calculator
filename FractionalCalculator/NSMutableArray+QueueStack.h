//
//  NSMutableArray+QueueStack.h
//  FractionalCalculator
//
//  Created by Mikkel Petersen on 4/16/15.
//  Copyright (c) 2015 Mikkel Vester Petersen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (QueueStack)
// queue methods
-(id)dequeue;
-(void)enqueue:(id)obj;
// stack methods
-(void)push:(id)obj;
-(id)pop;
-(id)peek;

@end
