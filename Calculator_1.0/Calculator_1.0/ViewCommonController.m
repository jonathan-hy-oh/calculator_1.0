//
//  ViewCommonController.m
//  Calculator_1.0
//
//  Created by Jon Oh on 8/4/13.
//  Copyright (c) 2013 Jon Oh. All rights reserved.
//

#import "ViewCommonController.h"
#import "CalcEngine.h"

@interface ViewCommonController ()

@end

@implementation ViewCommonController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)operandClicked:(id)sender resultTextField:(UITextField*)resultTextField //number clicked
{

    int operandTag = [((UIButton*)sender) tag];
    _evaluated = [[resultTextField text]floatValue];
    
    switch (calcState) {
        case operand1Build: //started
            
            if ((specialOperands)operandTag < SPEC_PERIOD){
                
                if (periodClicked == NO){
                    
                    float output = _evaluated * 10 + operandTag;
                    [resultTextField setText:[@(output)description]];
                }
                
                if (periodClicked == YES) {
                    
                    float output = _evaluated + (operandTag / (pow(10, decimalDigit)));
                    [resultTextField setText:[@(output)description]];
                    decimalDigit++;
                }
            }
            
            if ((specialOperands)operandTag == SPEC_SIGNCHANGE){
                
                float temp = -1 * [[resultTextField text]floatValue];
                [resultTextField setText:[@(temp)description]];
                
            }
            
            if ((specialOperands)operandTag == SPEC_PERIOD){
                
                if (periodClicked == NO){
                    periodClicked = YES;
                    decimalDigit = 1;
                    //here
                    NSString* temp = [resultTextField text];
                    temp = [temp stringByAppendingString:@(".")];
                    [resultTextField setText:temp];

                }
                
//                NSString* temp = [resultTextField text];
//                temp = [temp stringByAppendingString:@(".")];
//                [resultTextField setText:temp];

            }
            firstNum = [[resultTextField text]floatValue];
            
            break;

        case operandHBuild:
            
            firstNum = [[resultTextField text]floatValue];
            [resultTextField setText:@"0"];
            _evaluated = [[resultTextField text]floatValue];
            calcState = operand2Build;
            operatorPressed = YES;
            
        case operand2Build:
            
            if ((specialOperands)operandTag < SPEC_PERIOD){
                
                if (periodClicked == NO){
                    
                    float output = _evaluated * 10 + operandTag;
                    [resultTextField setText:[@(output)description]];
                }
                
                if (periodClicked == YES) {
                    
                    float output = _evaluated + (operandTag / (pow(10, decimalDigit)));
                    [resultTextField setText:[@(output)description]];
                    decimalDigit++;
                }
            }
            
            if ((specialOperands)operandTag == SPEC_SIGNCHANGE){
                
                //if we see an operand tag: [continue]
                
                float temp = -1 * [[resultTextField text]floatValue];
                [resultTextField setText:[@(temp)description]];
                
            }
            
            if ((specialOperands)operandTag == SPEC_PERIOD){
                
                if (periodClicked == NO){
                    periodClicked = YES;
                    decimalDigit = 1;
                    NSString* temp = [resultTextField text];
                    temp = [temp stringByAppendingString:@(".")];
                    [resultTextField setText:temp];
                }
            }
            secondNum = [[resultTextField text]floatValue];
            break;
            
        case finalBuild:
            if ((specialOperands)operandTag < SPEC_PERIOD)
                [resultTextField setText:[@(operandTag)description]];
            
            if ((specialOperands)operandTag == SPEC_PERIOD){
                [resultTextField setText:@("0.")];
                periodClicked = YES;
                decimalDigit = 1;
            }
            
            calcState = operand1Build;
            break;
            
    }
    
    
}

- (void)operatorClicked:(id)sender resultTextField:(UITextField*)resultTextField
{
    decimalDigit = 0;
    calcState = operandHBuild;
    periodClicked = NO;
    if (operatorPressed == YES){
        firstNum = [self equals:firstNum passer2:secondNum];
        [resultTextField setText:[@(firstNum)description]];
    }
    operatorNum = [((UIButton*)sender)tag];
    
}

- (void)finalizerClicked:(id)sender resultTextField:(UITextField*)resultTextField
{
    
    int tag = [(UIButton*)sender tag];
    if ((finalizerTypes)tag == FINAL_ALLCLEAR){
        [resultTextField setText:@("0")];
        firstNum = 0;
        secondNum = 0;
        operatorPressed = NO;
        periodClicked = NO;
        operatorNum = 0;
        decimalDigit = 0;
        
    }
    
    
    if ((finalizerTypes)tag == FINAL_EQUALS){
        
        
        if ((CE_OPERATOR)operatorNum < CE_OPERATOR_ADD) {
            return;
        } //if there is no operation specified, it will return out
        
        secondNum = [[resultTextField text]floatValue];
        float outer = [self equals:firstNum passer2:secondNum];
        [resultTextField setText:[@(outer)description]];

        
    }
    decimalDigit = 0;
    periodClicked = NO;
    operatorPressed = NO;
    calcState = finalBuild;
}

- (float) equals:(float)passer1 passer2:(float)passer2{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithFloat:passer1], @"operand1",
                            [NSNumber numberWithFloat:passer2], @"operand2",
                            [NSNumber numberWithInteger:operatorNum], @"operator", nil];
    
    NSDictionary *result = [CalcEngine evaluate:params];
    
    NSNumber *valueReturned = [result objectForKey:@"result"];
    
    return [valueReturned floatValue];
    
}


@end
