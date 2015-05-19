//
//  ShuntingYard.h
//  FractionalCalculator
//
//  Created by Mikkel Petersen on 4/16/15.
//  Copyright (c) 2015 Mikkel Vester Petersen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShuntingYard : NSObject

@property NSMutableArray* stack;
@property NSMutableArray* queue;

+(ShuntingYard*)sharedInstance;
-(NSMutableArray*)shuntingYardWithTokens:(NSMutableArray*)tokens;

@end
