//
//  ViewController.m
//  FractionalCalculator
//
//  Created by Mikkel Petersen on 4/14/15.
//  Copyright (c) 2015 Mikkel Vester Petersen. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableArray+QueueStack.h"
#import "Operator.h"
#import "CalcEngine.h"
#import "FractionalNumber.h"
#import "CalcDisplayView.h"
#import "FractionalNumberView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel* lblDisplay;
@property NSMutableArray* infix;
@property CalcEngine* engine;
@property FractionalNumber* result;
@property NSMutableString* tempNumber;
@property (weak, nonatomic) IBOutlet CalcDisplayView* displayView;
@property int numerator;
@property float fractionWidth;
@property float currentX;
@property FractionalNumberView* fractionView;
@end

@implementation ViewController

@synthesize infix = _infix, engine = _engine, result = _result, tempNumber = _tempNumber, numerator = _numerator, lblDisplay;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (!_infix) {
        _infix = [[NSMutableArray alloc] init];
    }
    _tempNumber = [[NSMutableString alloc] init];
    _currentX = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)acButtonPressed:(id)sender {
    [_infix removeAllObjects];
    [_displayView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    _currentX = 5;
    _tempNumber = [[NSMutableString alloc] init];
}
- (IBAction)negateButtonPressed:(id)sender {
    // calculate if user has entered something
    if (_infix.count > 0) {
        [self equalsButtonPressed:sender];
        _result = [_result negate];
    }
    else {
        // create fraction if user has not pressed equals button
        if ([self createAndPushFraction]) {
            _result = [_infix pop];
            _result = [_result negate];
        }
        else if (_result) {
            _result = [_result negate];
        }
    }
    [self simplify];
}
- (IBAction)squarerootButtonPressed:(id)sender {
    BOOL squared;
    
    if (_infix.count > 0) {
        if (!_engine) {
            _engine = [CalcEngine sharedInstance];
        }
        _result = [_engine CalculateWithTokens:_infix];
        _result = [_result squareroot:&squared];
    }
    else {
        if ([self createAndPushFraction]) {
            _result = [_infix pop];
            _result = [_result squareroot:&squared];
        }
    }
    if (!squared) {
        // not perfect square, display the original fraction with square root sign
        [self drawFraction:_result DisplayAsResult:YES];
        
        UILabel *squareLabel = [[UILabel alloc]initWithFrame:CGRectMake(_displayView.bounds.size.width - 60, _displayView.bounds.size.height/2 - 75/2, 30, 70)];
        [squareLabel setBackgroundColor:[UIColor clearColor]];
        [squareLabel setText:@"√"];
        [squareLabel setFont:[UIFont systemFontOfSize:50]];
        [squareLabel setTextColor:[UIColor whiteColor]];
        [squareLabel setTextAlignment: NSTextAlignmentCenter];
        [_displayView addSubview:squareLabel];
    }
    else {
        // squared, display result
        [self drawFraction:_result DisplayAsResult:YES];
    }    
}

- (IBAction)divideButtonPressed:(id)sender {
    if ([self createAndPushFraction]) {
        [_infix push:[Operator sharedDivideOperator]];
        [self drawOperatorWithString:@"÷"];
    }
}
- (IBAction)multiplyButtonPressed:(id)sender {
    if ([self createAndPushFraction]) {
        [_infix push:[Operator sharedMultiplyOperator]];
        [self drawOperatorWithString:@"×"];
    }
}
- (IBAction)subtractButtonPressed:(id)sender {
    if ([self createAndPushFraction]) {
        [_infix push:[Operator sharedSubtractOperator]];
        [self drawOperatorWithString:@"-"];
    }
}
- (IBAction)addButtonPressed:(id)sender {
    if ([self createAndPushFraction]) {
        [_infix push:[Operator sharedAddOperator]];
        [self drawOperatorWithString:@"+"];
    }
}
- (IBAction)equalsButtonPressed:(id)sender {
    if ([self createAndPushFraction]) {
        if (!_engine) {
            _engine = [CalcEngine sharedInstance];
        }
        
        _result = [_engine CalculateWithTokens:_infix];
        NSLog(@"Fraction result: %d/%d", _result.numerator, _result.denominator);
        if (_infix.count == 1) {
            _result = [_result simplifyWithNumerator:_result.numerator denominator:_result.denominator];
        }
        
        if (![self simplify]) {
            [self drawFraction:_result DisplayAsResult:YES];
        }
        [_infix removeAllObjects];
    }
}
- (IBAction)overButtonPressed:(id)sender {
    _numerator = [_tempNumber intValue];
    if (_numerator != 0) {
        _fractionWidth = [_tempNumber length];
        [self drawNumerator];
        [_tempNumber setString:@""];
    }
}
- (IBAction)numberButtonPressed:(UIButton*)sender {
    int number = (int)sender.tag;
    NSString* str = [NSString stringWithFormat:@"%d", number];
    [_tempNumber appendString:str];
}

- (void)drawNumerator
{
    float width = 24;
    float height = 60;
    float x = _currentX;
    float y = _displayView.bounds.size.height/2 - height/2;
    if (_fractionWidth > 2) {
        width = _fractionWidth * 12;
    }
    _fractionView = [[FractionalNumberView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [_fractionView drawNumerator: _tempNumber];
    [_displayView addSubview:_fractionView];
}

- (BOOL)drawDenominator
{
    if ([_fractionView.numerator length] == _fractionWidth) {
        [_fractionView drawDenominator:_tempNumber];
        _fractionWidth = 0;
        if ([_fractionView.numerator length] > 2) {
            _currentX += [_fractionView.numerator length] * 12;
        }
        else {
            _currentX += 24;
        }
        return YES;
    }
    else {
        return NO;
    }
    
}

- (void)drawFraction:(FractionalNumber *)fraction DisplayAsResult:(BOOL)isResult {
    float width = 24;
    float height = 60;
    float x = _currentX;
    float y = _displayView.bounds.size.height/2 - height/2;

    if (_fractionWidth > 2) {
        width = _fractionWidth * 12;
    }
    _currentX += width;
    _fractionWidth = 0;
    
    if (isResult) {
        if (_fractionWidth == 0) {
            int numLenght = (int)[[NSString stringWithFormat:@"%d", fraction.numerator] length];
            int denLenght = (int)[[NSString stringWithFormat:@"%d", fraction.denominator] length];
            if (numLenght > denLenght) {
                width = numLenght * 12;
            } else {
                width = denLenght * 12;
            }
            if (width < 20) {
                width = 20;
            }
            
        }
        x = _displayView.bounds.size.width - width - 5;
        
        UILabel *equalsLabel = [[UILabel alloc]initWithFrame:CGRectMake(x-15, y, 10, height)];
        [equalsLabel setBackgroundColor:[UIColor clearColor]];
        [equalsLabel setText:@"="];
        [equalsLabel setTextColor:[UIColor whiteColor]];
        [equalsLabel setTextAlignment: NSTextAlignmentCenter];
        [_displayView addSubview:equalsLabel];
    }
    
    FractionalNumberView* fractionView = [[FractionalNumberView alloc] initWithFrame:CGRectMake(x, y, width, height) andFractionalNumber:fraction];
    [_displayView addSubview:fractionView];
}

- (void)drawOperatorWithString:(NSString*)operatorString
{
    float width = 20;
    float height = 60;
    float x = _currentX;
    float y = _displayView.bounds.size.height/2 - height/2;
    _currentX += width;
    
    UILabel *operatorLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    [operatorLabel setBackgroundColor:[UIColor clearColor]];
    [operatorLabel setText:operatorString];
    [operatorLabel setTextColor:[UIColor whiteColor]];
    [operatorLabel setTextAlignment: NSTextAlignmentCenter];
    [_displayView addSubview:operatorLabel];
}

- (BOOL)createAndPushFraction {
    if (_numerator == 0) {
        NSLog(@"Numerator is 0");
        return NO;
    }
    
    int denominator = [_tempNumber intValue];
    if ([_tempNumber length] > _fractionWidth) {
        _fractionWidth = [_tempNumber length];
    }    
    
    if (denominator == 0) {
        NSLog(@"Denominator is 0");
        return NO;
    }
    else {
        FractionalNumber* fraction = [[FractionalNumber alloc] initWithNumerator:_numerator denominator:denominator];
        if (![self drawDenominator]) {
            [self drawFraction:fraction DisplayAsResult:NO];
        }
        [_tempNumber setString:@""];
        [_infix push:fraction];
        _numerator = 0;

        return YES;
    }
}

/*  Simplifies result and displays it */
- (BOOL)simplify
{
    int n = _result.numerator;
    int d = _result.denominator;
    int number;
    if (n >= d) {
        number = n/d;
        n = _result.numerator - number * d;
        
        float width = 30;
        float height = 60;
        float x = _displayView.bounds.size.width - width - 5;
        float y = _displayView.bounds.size.height/2 - height/2;
        UILabel *resultLabel;
        
        if (n == 0) {
            resultLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
            [resultLabel setText:[NSString stringWithFormat:@"= %d", number]];
        }
        else if (number > 0) {
            FractionalNumber *fraction = [[[FractionalNumber alloc] initWithNumerator:n denominator:d] simplifyWithNumerator:n denominator:d];
            [self drawFraction:fraction DisplayAsResult:YES];
            if (n > 999 || d > 999) {
                width = 30;
                x -= 36;
                if (n > 9999 || d > 9999) {
                    width = 40;
                    x -= 40;
                }
            }
            else {
                x -= 25;
            }
            if (number > 99) {
                width = 56;
                x -= 40;
            }
            resultLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
            [resultLabel setText:[NSString stringWithFormat:@"= %d", number]];
        }
        [resultLabel setBackgroundColor:[UIColor darkGrayColor]];
        [resultLabel setTextAlignment: NSTextAlignmentCenter];
        [resultLabel setTextColor:[UIColor whiteColor]];
        [resultLabel setFont:[UIFont systemFontOfSize:20]];
        [_displayView addSubview:resultLabel];
        return YES;
    }
    return NO;
}
@end
