//
//  ViewController.h
//  Calculator_1.0
//
//  Created by Jon Oh on 6/30/13.
//  Copyright (c) 2013 Jon Oh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    
    IBOutlet UIView *portraitView;
    IBOutlet UIView *landscapeView;
    
    IBOutlet UITextField *p_resultOutTF;
    IBOutlet UITextField *l_resultOutTF;
    
    int operation;
    bool pressed;
    bool done;
    bool decimal;
    float firstEntry;
    float secondEntry;
    int timesPressed;
    int equalsPressed;
    bool radian;
    
}

@property (nonatomic, retain) IBOutlet UIView *portraitView;
@property (nonatomic, retain) IBOutlet UIView *landscapeView;

- (IBAction)setInt:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)multiply:(id)sender;
- (IBAction)divide:(id)sender;
- (IBAction)add:(id)sender;
- (IBAction)subtract:(id)sender;
- (IBAction)equals:(id)sender;
- (IBAction)change:(id)sender;
- (IBAction)decimalize:(id)sender;
- (void) equal;


- (IBAction)buttonClicked:(id)sender;
- (IBAction)sin:(id)sender;
- (IBAction)square:(id)sender;
- (IBAction)log:(id)sender;
- (IBAction)tan:(id)sender;
- (IBAction)cos:(id)sender;
- (IBAction)radianSwitch:(id)sender;
- (IBAction)factorial:(id)sender;
- (IBAction)squareRoot:(id)sender;
- (IBAction)power:(id)sender;
- (IBAction)pi:(id)sender;
- (double)factorialFunction:(double)operand;


@end
