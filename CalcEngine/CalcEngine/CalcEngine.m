//
//  CalcEngine.m
//  CalcEngine
//
//  Created by Jon Oh on 7/13/13.
//  Copyright (c) 2013 Jonathan Oh. All rights reserved.
//

#import "CalcEngine.h"

@implementation CalcEngine

- (id)init
{
    if ((self = [super init]) != nil)
    {
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

+ (NSDictionary *)evaluate:(NSDictionary *)parameter
{
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            [NSNumber numberWithFloat:firstNum], @"operand1",
//                            [NSNumber numberWithFloat:secondNum], @"operand2",
//                            operatorNum, @"operator", nil];

    
    NSNumber *operand1 = [parameter objectForKey:@"operand1"];
    NSNumber *operand2 = [parameter objectForKey:@"operand2"];
    NSNumber *operator = [parameter objectForKey:@"operator"];

    float value = MAXFLOAT;

    float temp1 = [operand1 floatValue];
    float temp2 = [operand2 floatValue];
    
    CE_OPERATOR opValue = (CE_OPERATOR)[operator integerValue];
    
    if (opValue == CE_OPERATOR_ADD)
    {
        value = [operand1 floatValue] + [operand2 floatValue];
    }
    
    else if (opValue == CE_OPERATOR_SUB)
        value = [operand1 floatValue] - [operand2 floatValue];
    
    else if (opValue == CE_OPERATOR_MUL)
        value = [operand1 floatValue] * [operand2 floatValue];
    
    else if (opValue == CE_OPERATOR_DIV)
        value = [operand1 floatValue] / [operand2 floatValue];
    
    else if (opValue == CE_OPERATOR_SIN){
        value = sinf([operand1 floatValue]);
    }
    else if (opValue == CE_OPERATOR_COS)
        value = cosf([operand1 floatValue]);
    
    else if (opValue == CE_OPERATOR_TAN)
        value = tanf([operand1 floatValue]);
    
    else if (opValue == CE_OPERATOR_SQRT)
        value = sqrtf([operand1 floatValue]);
    
    else if (opValue == CE_OPERATOR_PI)
        value = M_PI;
    
    else if (opValue == CE_OPERATOR_LOG)
        value = log10f([operand1 floatValue]);
    
    else if (opValue == CE_OPERATOR_FAC){
        
        if      (temp1 == 0) temp1 = 1; // factorial of 0 is 1
        else if (temp1 < 0)  temp1 = NAN;
        else if (temp1 > 0)
        {
            if (fmod(temp1, floor(temp1)) == 0) // integer
                temp1 = round(exp(lgamma(temp1 + 1)));
            else // natural number
                temp1 = exp(lgamma(temp1 + 1));
        }
        
        value = temp1;
        
    }
    
    else if (opValue == CE_OPERATOR_POW){
        
        value = powf(temp1, temp2); 
    }
    
    else if (opValue == CE_OPERATOR_SQUAR){
        
        value = powf(temp1, 2);
        
    }
    
    NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [NSNumber numberWithFloat:value], @"result", nil];
        
    return result;
}




@end
