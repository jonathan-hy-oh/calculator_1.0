//
//  LandscapeViewController.h
//  Calculator_1.0
//
//  Created by Jon Oh on 7/13/13.
//  Copyright (c) 2013 Jon Oh. All rights reserved.
//

#import "ViewCommonController.h"
#import "CalcEngine.h"

typedef enum {
    
    MOD_SIN = 5,
    MOD_COS,
    MOD_TAN,
    MOD_SQRT,
    MOD_PI,
    MOD_LOG,
    MOD_FACT,
    MOD_POW,
    MOD_SQUARE,
    MOD_RAD
    
} modifierTypes;


@interface LandscapeViewController : ViewCommonController
{
    IBOutlet UITextField *resultTextField2;
    BOOL radianSwitch;
    float outputHolder;

}



@end
