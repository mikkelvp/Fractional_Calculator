//
//  ArithmeticOperationProtocol.h
//  FractionalCalculator
//
//  Created by Mikkel Petersen on 4/14/15.
//  Copyright (c) 2015 Mikkel Vester Petersen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ArithmeticOperationProtocol <NSObject>

-(id<ArithmeticOperationProtocol>) add: (id<ArithmeticOperationProtocol>) other;
-(id<ArithmeticOperationProtocol>) subtract: (id<ArithmeticOperationProtocol>) other;
-(id<ArithmeticOperationProtocol>) multiply: (id<ArithmeticOperationProtocol>) other;
-(id<ArithmeticOperationProtocol>) divide: (id<ArithmeticOperationProtocol>) other;
-(id<ArithmeticOperationProtocol>) squareroot;
-(id<ArithmeticOperationProtocol>) negate;

@optional
-(id<ArithmeticOperationProtocol>) squareroot:(BOOL*)squared;

@end
