//
//  Operator.h
//  FractionalCalculator
//
//  Created by Mikkel Petersen on 4/14/15.
//  Copyright (c) 2015 Mikkel Vester Petersen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    addSubPrecedence,
    multDivPrecedence
} Precedence_t;

@interface Operator : NSObject

@property (assign) NSUInteger precedence;
@property (assign) SEL selector;

-(Operator*) initWithPrecedence:(NSUInteger)thePrecedence
                       selector:(SEL)theSelector;
+(Operator*) sharedAddOperator;
+(Operator*) sharedSubtractOperator;
+(Operator*) sharedMultiplyOperator;
+(Operator*) sharedDivideOperator;

@end
