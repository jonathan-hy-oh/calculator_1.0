//
//  CalcEngine.h
//  CalcEngine
//
//  Created by Jon Oh on 7/13/13.
//  Copyright (c) 2013 Jonathan Oh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    CE_OPERATOR_ADD = 1,
    CE_OPERATOR_SUB,
    CE_OPERATOR_MUL,
    CE_OPERATOR_DIV,
    CE_OPERATOR_SIN,
    CE_OPERATOR_COS,
    CE_OPERATOR_TAN,
    CE_OPERATOR_SQRT,
    CE_OPERATOR_PI,
    CE_OPERATOR_LOG,
    CE_OPERATOR_FAC,
    CE_OPERATOR_POW,
    CE_OPERATOR_SQUAR,
    CE_OPERATOR_RAD
    
} CE_OPERATOR;

@interface CalcEngine : NSObject
{
    
}


+ (NSDictionary *)evaluate:(NSDictionary *)parameter;

@end
