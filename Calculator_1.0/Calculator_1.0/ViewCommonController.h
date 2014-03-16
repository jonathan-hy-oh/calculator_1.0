//
//  ViewCommonController.h
//  Calculator_1.0
//
//  Created by Jon Oh on 8/4/13.
//  Copyright (c) 2013 Jon Oh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    operand1Build,
    operandHBuild,
    operand2Build,
    finalBuild
} calculatorStates;

typedef enum {
    SPEC_PERIOD = 10,
    SPEC_SIGNCHANGE
    
} specialOperands;

typedef enum {
    
    FINAL_ALLCLEAR = 1,
    FINAL_EQUALS
    
} finalizerTypes;

@interface ViewCommonController : UIViewController{
    
    float firstNum;
    float secondNum;
    float _evaluated;
    int   decimalDigit;
    BOOL  periodClicked;
    BOOL  operatorPressed;
    BOOL  equalsPressed;
    calculatorStates calcState;
    NSInteger operatorNum;
  
    
}


//basic functions
- (void)operandClicked:(id)sender resultTextField:(UITextField*)resultTextField;

- (void)operatorClicked:(id)sender resultTextField:(UITextField*)resultTextField; //operator

- (void)finalizerClicked:(id)sender resultTextField:(UITextField*)resultTextField; //equals, AC

- (float)equals:(float)passer1 passer2:(float)passer2;



@end
