//
//  FractionalNumber.m
//  FractionalCalculator
//
//  Created by Mikkel Petersen on 4/14/15.
//  Copyright (c) 2015 Mikkel Vester Petersen. All rights reserved.
//

#import "FractionalNumber.h"

@implementation FractionalNumber

@synthesize numerator = _numerator, denominator = _denominator;


-(FractionalNumber*)initWithNumerator:(int)aNumerator denominator:(int)aDenominator
{
    self = [super init];
    if (self) {
        _numerator = aNumerator;
        _denominator = aDenominator;
    }
    return self;
        
}

-(FractionalNumber*)add:(FractionalNumber*)other
{
    int n, d;
    
    if (self.denominator == other.denominator) {
        n = self.numerator + other.numerator;
        d = self.denominator;
    }
    else {
        int lcm = leastCommonMultiple(self.denominator, other.denominator);
        int sm = lcm / self.denominator;
        int om = lcm / other.denominator;
        n = (self.numerator * sm) + (other.numerator * om);
        d = lcm;
    }
    return [self simplifyWithNumerator:n denominator:d];
}

-(FractionalNumber*)subtract:(FractionalNumber*)other
{
    int n, d;
    
    if (self.denominator == other.denominator) {
        n = self.numerator - other.numerator;
        d = self.denominator;
    }
    else {
        int lcm = leastCommonMultiple(self.denominator, other.denominator);
        int sm = lcm / self.denominator;
        int om = lcm / other.denominator;
        n = (self.numerator * sm) - (other.numerator * om);
        d = lcm;
    }
    return [self simplifyWithNumerator:n denominator:d];
}

-(FractionalNumber*)multiply:(FractionalNumber*)other
{
    int n, d;    

    n = self.numerator * other.numerator;
    d = self.denominator * other.denominator;
    
    return [self simplifyWithNumerator:n denominator:d];
}

-(FractionalNumber*)divide:(FractionalNumber*)other
{
    int n, d;
    
    n = self.numerator * other.denominator;
    d = self.denominator * other.numerator;
    
    return [self simplifyWithNumerator:n denominator:d];
}

-(FractionalNumber*)squareroot
{
    int n = self.numerator;
    int d = self.denominator;
    
    if ([self isPerfectSquare:n] && [self isPerfectSquare:d]) {
        n = (int)sqrt(n);
        d = (int)sqrt(d);
    }
    
    return [self simplifyWithNumerator:n denominator:d];
}
    

-(FractionalNumber*)squareroot:(BOOL*)squared
{
    int n = self.numerator;
    int d = self.denominator;
    BOOL perfectSquare = [self isPerfectSquare:n] && [self isPerfectSquare:d];
    
    if (perfectSquare) {
        n = (int)sqrt(n);
        d = (int)sqrt(d);
    }
    
    *squared = perfectSquare;
    
    return [self simplifyWithNumerator:n denominator:d];
}

-(FractionalNumber*)negate
{
    return [self simplifyWithNumerator:-self.numerator denominator:self.denominator];
}

-(FractionalNumber*)simplifyWithNumerator:(int)n denominator:(int)d
{
    if (d < 0) {
        n = -n;
        d = +d;
    }
    
    int _gcd = gcd(n, d);
    if (_gcd > 0) {
        n = n / _gcd;
        d = d / _gcd;
    }
        
    return [[FractionalNumber alloc] initWithNumerator:n denominator:d];
}

-(BOOL)isPerfectSquare:(double)n
{
    unsigned int uintRoot = (int)sqrt(n);
    return n == uintRoot * uintRoot;
}

int gcd(int a, int b);
int _gcd(int a, int b);
unsigned int uint_abs(int v);
int leastCommonMultiple(int a, int b);

int gcd(int a, int b) {
    int rv;
    if (a == b) {
        rv = a;
    }
    else if (a == 0 && b != 0) {
        rv = b;
    }
    else if (a != 0 && b == 0) {
        rv = a;
    }
    else if (a > b) {
        rv = _gcd(a - b, b);
    }
    else if (a < b) {
        rv = _gcd(a, b - a);
    }
    return rv;
}

int _gcd(int a, int b) {
    int q, r, rv;
    while (1) {
        q = a/b;
        r = a % b;
        if (r == 0) {
            rv = b;
            break;
        }
        a = b;
        b = r;
    }
    return rv;
}

unsigned int uint_abs(int v) {
    unsigned int r;
    int const mask = v >> (sizeof(int) * CHAR_BIT -1);
    r = (v ^ mask) - mask;
    return r;
}

int leastCommonMultiple(int a, int b) {
    int _gcd = gcd(a, b);
    int prod = a * b;
    prod = uint_abs(prod);
    int lcm = prod / _gcd;
    return lcm;
}


@end
