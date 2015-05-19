//
//  CalcEngine.h
//  FractionalCalculator
//
//  Created by Mikkel Petersen on 4/18/15.
//  Copyright (c) 2015 Mikkel Vester Petersen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FractionalNumber.h"
#import "ShuntingYard.h"

@interface CalcEngine : NSObject

@property (readonly) ShuntingYard* shuntingYard;

+(CalcEngine*)sharedInstance;
-(FractionalNumber*)CalculateWithTokens:(NSMutableArray*)tokens;

@end
