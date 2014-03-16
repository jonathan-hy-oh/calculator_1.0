//
//  ViewController.m
//  Calculator_1.0
//
//  Created by Jon Oh on 6/30/13.
//  Copyright (c) 2013 Jon Oh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize portraitView, landscapeView;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    if ((self = [super initWithNibName:(NSString *)nibBundleOrNil bundle:nibBundleOrNil]) != nil)
//    {
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(orientationChanged:)
//                                                     name:UIDeviceOrientationDidChangeNotification
//                                                   object:nil];
//        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 548)];
//    }
//    
//    return self;
//}

//- (void)loadView
//{
//    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 548)];
//   [self.view addSubview:self.portraitView];
//    [self.view addSubview:self.landscapeView];
//    
//}

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];

    NSLog(@"view class:%@", NSStringFromClass([self.portraitView class]));
    [self.view addSubview:self.portraitView];
//    [self.view addSubview:self.landscapeView];
//    
//    [self.view bringSubviewToFront:self.portraitView];
    
}
// -------------------------------------------------------------------------------
//	orientationChanged:
//  Handler for the UIDeviceOrientationDidChangeNotification.
//  See also: awakeFromNib
// -------------------------------------------------------------------------------
- (void)orientationChanged:(NSNotification *)notification
{
    // A delay must be added here, otherwise the new view will be swapped in
	// too quickly resulting in an animation glitch
    [self performSelector:@selector(updateViewOrientation) withObject:nil afterDelay:0];
}

// -------------------------------------------------------------------------------
//	updateViewOrientation
// -------------------------------------------------------------------------------
- (void)updateViewOrientation
{
    // Get the device's current orientation.  By the time the
    // UIDeviceOrientationDidChangeNotification has been posted, this value reflects
    // the new orientation of the device.
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
        
    if (UIDeviceOrientationIsLandscape(deviceOrientation))
	{
        [self.portraitView removeFromSuperview];
        [self.view addSubview:self.landscapeView];
//        [self.view bringSubviewToFront:self.landscapeView];
	}
	else if (UIDeviceOrientationIsPortrait(deviceOrientation))
	{
        [self.landscapeView removeFromSuperview];
        [self.view addSubview:self.portraitView];
//        [self.view bringSubviewToFront:self.portraitView];
	}
    else
    {
        NSLog(@"deviceOrientation %d", deviceOrientation);
    }
}

#pragma mark - Rotation

// -------------------------------------------------------------------------------
//	supportedInterfaceOrientations
//  Support only portrait orientation (iOS 6).
// -------------------------------------------------------------------------------
- (NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [self.view release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//sets what appears in the output box of the calculator
- (IBAction)setInt:(id)sender{

    UIDeviceOrientation orientation = [[UIDevice currentDevice]orientation];
    
    //instance variable of the button pressed (so that I can get its text later)
    UIButton *resultButton = (UIButton*)sender;
    
    //if you pressed an operator, it will assign whatever is in the output box at this time to secondEntry
    if (pressed){
        
        if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
            firstEntry = [[p_resultOutTF text] floatValue];
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight)
            firstEntry = [[l_resultOutTF text] floatValue];
        [p_resultOutTF setText:@""]; //it then resets the p_resultOutTF box so that you can put what you want to multiply, add, etc.
        [l_resultOutTF setText:@""];
        pressed = NO; //after this, you make pressed = NO so that it doesn't infinitely loop and the operator is not pressed again at this point in time.
    }
    
    
    //if equals is pressed, and then you pressed whatever this button is, it will reset the text and await input.
    if (done){
        if (orientation == UIDeviceOrientationPortraitUpsideDown || orientation == UIDeviceOrientationPortrait)
            [p_resultOutTF setText:@""];
        
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight)
            [l_resultOutTF setText:@""];
    }
    
    if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown){
    //if there is a zero initially
        if ([[p_resultOutTF text] floatValue] == 0 && decimal == NO){
            [p_resultOutTF setText:@""]; //it will get rid of it so that it doesn't look ugly
        }
        }
    
    if (orientation == UIDeviceOrientationLandscapeLeft || UIDeviceOrientationLandscapeRight == orientation){
        
        //
        if ([[l_resultOutTF text] floatValue] == 0 && decimal == NO){
            [l_resultOutTF setText:@""];
        }
        
    }
    

    
    NSString *tempString1 = [resultButton currentTitle]; //tempString
    NSString *tempString2 = @"";
    NSString *final = @"";
    
    if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown){
        tempString2 = [p_resultOutTF text]; //tempString
        final = [tempString2 stringByAppendingString:tempString1];
        [p_resultOutTF setText:final];
    }
    
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight){
        tempString2 = [l_resultOutTF text]; //tempString 2
        final = [tempString2 stringByAppendingString:tempString1];
        [l_resultOutTF setText:final];
    }
    
    done = NO; //done = NO to prevent an infinite loop and equals isn't pressed again at this point in time.
    equalsPressed = 0;
    
}

//clears the output box
- (IBAction)clear:(id)sender{
    
    //literally clears the p_resultOutTF box to a single zero
    [p_resultOutTF setText:@"0"];
    [l_resultOutTF setText:@"0"];
    firstEntry = 0;
    secondEntry = 0;
    timesPressed = 0;
    decimal = NO; //clears, so whatever input is is not a decimal
    pressed = NO; //clears, so no operation is pressed
    done = YES;
    equalsPressed = 0;
    operation = 0;
    
}

- (IBAction)multiply:(id)sender{
    if (pressed == NO){
        if (timesPressed >= 1) //if you press an operator more than once it will equalize and then await for furthur input
            [self equal];
        pressed = YES;
        decimal = NO;
        timesPressed++;
    }
    operation = 3;
} //if you press an operator, it will set the operator representer accordingly

- (IBAction)divide:(id)sender{
    if (pressed == NO){
        if (timesPressed >= 1) //if you press an operator more than once it will equalize and then await for furthur input
            [self equal];
        pressed = YES;
        decimal = NO;
        timesPressed++;
    }
    operation = 4;
} //if you press an operator, it will set the operator representer accordingly

- (IBAction)add:(id)sender{
    if (pressed == NO){
        if (timesPressed >= 1) //if you press an operator more than once it will equalize and then await for furthur input
            [self equal];
        pressed = YES;
        decimal = NO;
        timesPressed++;
    }
    operation = 1;
} //if you press an operator, it will set the operator representer accordingly

- (IBAction)subtract:(id)sender{
    if (pressed == NO){
        if (timesPressed >= 1) //if you press an operator more than once it will equalize and then await for furthur input
            [self equal];
        pressed = YES;
        decimal = NO;
        timesPressed++;
    }
    operation = 2;
} //if you press an operator, it will set the operator representer accordingly

- (IBAction)power:(id)sender{
    
    if (pressed == NO){
        if (timesPressed >= 1) //if you press an operator more than once it will equalize and then await for furthur input
            [self equal];
        pressed = YES;
        decimal = NO;
        timesPressed++;
    }
    operation = 5;
    
}

//if you press the equals button
- (IBAction)equals:(id)sender{
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice]orientation];
    
    if (equalsPressed == 0){
        
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight)
            secondEntry = [[l_resultOutTF text]floatValue];
        //assigns secondEntry to whatevs on the screen
    
        if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
            secondEntry = [[p_resultOutTF text]floatValue];
    }
    
    if (equalsPressed > 0){
        
    
        if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
            firstEntry = [[p_resultOutTF text]floatValue];
    
        if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft)
            firstEntry = [[l_resultOutTF text]floatValue];
    }
    
    //if you pressed "+" as the operator
    if (operation == 1){
        
        //adds the first entry and second entry together
        float result = (float)firstEntry + secondEntry;
        
        if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
            [p_resultOutTF setText:[@(result) description]];
        
        if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft)
            [l_resultOutTF setText:[@(result)description]];
        
    }
    
    //if you pressed "-" as the operator
    if (operation == 2){
        
        //subtracts the first entry and second entry
        float result = (float) firstEntry - secondEntry;
        if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
            [p_resultOutTF setText:[@(result) description]]; //outputs it
        
        if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft)
            [l_resultOutTF setText:[@(result)description]];
        
    }
    
    //if you pressed "*" as the operator
    if (operation == 3){
        
        //multiplies the first entry and second entry
        float result = (float) firstEntry * secondEntry;
        if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
            [p_resultOutTF setText:[@(result) description]]; //p_resultOutTFs it
        
        if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft)
            [l_resultOutTF setText:[@(result)description]];
        
    }
    
    //if you pressed "/" as the operator
    if (operation == 4){
        
        //divides the first entry and second entry
        float result = (float) firstEntry/secondEntry;
        if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
            [p_resultOutTF setText:[@(result) description]]; //outputs it
        
        if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft)
            [l_resultOutTF setText:[@(result)description]];
        
    }
    
    if (operation == 5){
        
        
        //powers the first entry and second entry
        float result = powf(firstEntry, secondEntry);
        [l_resultOutTF setText:[@(result)description]];
        
    }
    
    
    //you're done, and you want the p_resultOutTF box to be reset when you input another number button
    done = YES;
    timesPressed = 0;
    equalsPressed++;
    //operation = 0;
    
    
}

- (void) equal{
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice]orientation];
    
    //grabs the value in the p_resultOutTF box
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight)
        secondEntry = [[l_resultOutTF text]floatValue];
    
    if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
        secondEntry = [[p_resultOutTF text] floatValue];
    
    //if you pressed "+" as the operator
    if (operation == 1){
        
        //adds the first entry and second entry together
        float result = (float)firstEntry + secondEntry;
        if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
            [p_resultOutTF setText:[@(result) description]]; //outputs it
        
        if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft)
            [l_resultOutTF setText:[@(result)description]];
        
    }
    
    //if you pressed "-" as the operator
    if (operation == 2){
        
        //subtracts the first entry and second entry
        float result = (float) firstEntry - secondEntry;
        if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
            [p_resultOutTF setText:[@(result) description]]; //outputs it
        
        if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft)
            [l_resultOutTF setText:[@(result)description]];
        
    }
    
    //if you pressed "*" as the operator
    if (operation == 3){
        
        //multiplies the first entry and second entry
        float result = (float) firstEntry * secondEntry;
        if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
            [p_resultOutTF setText:[@(result) description]]; //outputs it
        
        if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft)
            [l_resultOutTF setText:[@(result)description]];
        
    }
    
    //if you pressed "/" as the operator
    if (operation == 4){
        
        //divides the first entry and second entry
        float result = (float) firstEntry/secondEntry;
        if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
            [p_resultOutTF setText:[@(result) description]]; //outputs it
        
        if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft)
            [l_resultOutTF setText:[@(result)description]];
        
    }
    
    if (operation == 5){
        
        
        //powers the first entry and second entry
        float result = powf(firstEntry, secondEntry);
        [l_resultOutTF setText:[@(result)description]];
        
    }
    
    //you're not done yet; this is simply putting output into the output box
    done = NO;
    
    
}

- (IBAction)change:(id)sender{
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice]orientation];
    
    float temp = 0;
    
    if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown){
        temp = [[p_resultOutTF text] floatValue]; //gets the output box value
        temp = (float) -1 * temp; //multiplies by -1, changing the sign
        [p_resultOutTF setText:[@(temp)description]]; //outputs it
    }
    
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight){
        temp = [[l_resultOutTF text] floatValue];
        temp = (float)-1 * temp; //multiplies by -1, changing the sign
        [l_resultOutTF setText:[@(temp)description]]; //outputs it
    }
}

- (IBAction)decimalize:(id)sender {
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice]orientation];
    
    if (pressed == NO){
        
        if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft){
            //gets what's in the output box
            NSString *temp = [l_resultOutTF text];
            NSString *period = @".";
            //concatenates the period and the output
            NSString *combined = [temp stringByAppendingString:period];
            [l_resultOutTF setText:combined]; //outputs it
        }
        
        if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown){
            //gets what's in the output box
            NSString *temp = [p_resultOutTF text];
            NSString *period = @".";
            //concatenates the period and the output
            NSString *combined = [temp stringByAppendingString:period];
            [p_resultOutTF setText:combined]; //outputs it
        }
        
        
    }
    
    if (pressed == YES){
        
        if (orientation == UIDeviceOrientationPortraitUpsideDown || orientation == UIDeviceOrientationPortrait){
            firstEntry = [[p_resultOutTF text] floatValue];
            [p_resultOutTF setText:@"0."];
        }
        
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight){
            firstEntry = [[l_resultOutTF text] floatValue];
            [l_resultOutTF setText:@"0."];
        }
        
    }
    
    if (done == YES){
     
        if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft)
            [l_resultOutTF setText:@"0."];
        
        if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
            [p_resultOutTF setText:@"0."];
    
    }
    decimal = YES;
    done = NO;
    pressed = NO;
    
}

- (IBAction)sin:(id)sender{
    
    float temp = [[l_resultOutTF text]floatValue];
    if (radian == YES)
        temp = sinf(temp);
    
    if (radian == NO){
        temp = (temp * M_PI)/180;
        temp = sinf(temp);
    }
    
    [l_resultOutTF setText:[@(temp)description]];
    done = YES;
    
}

- (IBAction)square:(id)sender{
    
    float temp = [[l_resultOutTF text]floatValue];
    
    temp = (float)temp * temp;
    
    [l_resultOutTF setText:[@(temp)description]];
    done = YES;
    
}

- (IBAction)buttonSwitcher:(id)sender{
    
    
    float temp = [[l_resultOutTF text]floatValue];
    temp = log10f(temp);
    [l_resultOutTF setText:[@(temp)description]];
    if (temp >= 1)
        log10f(temp);
    
    temp = log10f(temp);
    while (temp < 14) {
        [l_resultOutTF setText:[@(temp)description]];
    }
    
    float temp2 = [[p_resultOutTF text]floatValue];
    if (temp > temp2)
        return;
    if (temp > temp2)
        return;
    if (temp > temp2)
        return;
    if (temp > temp2)
        return;
    if (temp < temp2)
        return;
    
    
}

           
- (IBAction)don:(id)sender
{

    int gaston = [[p_resultOutTF text]floatValue];
    if (gaston > [[l_resultOutTF text]floatValue])
        return;
    int manliness = 9000;
    if (gaston != manliness)
        return; //end the world

}



- (IBAction)log:(id)sender{
    
    float temp = [[l_resultOutTF text]floatValue];
    temp = log10f(temp);
    [l_resultOutTF setText:[@(temp)description]];
    
    done = YES;
    
}

- (IBAction)tan:(id)sender{
    
    float temp = [[l_resultOutTF text]floatValue];
    if (radian == YES)
        temp = tanf(temp);
    
    if (radian == NO){
        temp = (temp * M_PI)/180;
        temp = tanf(temp);
    }
    
    [l_resultOutTF setText:[@(temp)description]];
    
    done = YES;
    
}

- (IBAction)cos:(id)sender{
    
    float temp = [[l_resultOutTF text]floatValue];
    if (radian == YES)
        temp = cosf(temp);
    
    if (radian == NO){
        temp = (temp * M_PI)/180;
        temp = cosf(temp);
    }
    
    [l_resultOutTF setText:[@(temp)description]];
    
    done = YES;
    
}






- (IBAction)radianSwitch:(id)sender{
    
    UIButton *resultButton = (UIButton*)sender;
    
    radian = !radian;
    if (radian == NO)
        [resultButton setTitle:@"rad" forState:UIControlStateNormal];
    if (radian == YES)
        [resultButton setTitle:@"deg" forState:UIControlStateNormal];
    
}

- (double)factorialFunction:(double)operand
{    
    if      (operand == 0)
        return 1; // factorial of 0 is 1
    else if (operand < 0)
        return NAN;
    else if (operand > 0)
    {
        if (fmod(operand, floor(operand)) == 0) // integer
            return round(exp(lgamma(operand + 1)));
        else // natural number
            return exp(lgamma(operand + 1));
    }
    
    return operand;
}

////probability
//- (double)n:(double)n chooseR:(double)r
//{
//    return round(exp((lgamma(n+1)) - (lgamma(r+1) + lgamma(n-r+1))));
//}
//
//- (double)n:(double)n pickR:(double)r
//{
//    return round(exp(lgamma(n+1) - lgamma(n-r+1)));
//}


- (IBAction)factorial:(id)sender{
    
    double value = [[l_resultOutTF text]doubleValue];
//    int result = 1;
//    
//    for (int i = (int)temp; i > 1; i--){
//        
//        result *= i;
//        
//    }
//
    double result = [self factorialFunction:value];
    
    [l_resultOutTF setText:[@(result)description]];
    done = YES;
    
}

- (IBAction)squareRoot:(id)sender{
    
    float temp = [[l_resultOutTF text]floatValue];
    temp = sqrtf(temp);
    [l_resultOutTF setText:[@(temp)description]];
    done = YES;
    
}

- (IBAction)pi:(id)sender{
    
    
    if (pressed){
        
        firstEntry = [[l_resultOutTF text] floatValue];
        pressed = NO; //after this, you make pressed = NO so that it doesn't infinitely loop and the operator is not pressed again at this point in time.
    }
    
    [l_resultOutTF setText:[@(M_PI)description]];
    done = NO;
    equalsPressed = 0;
    
}

- (IBAction)buttonClicked:(id)sender{
    

    UIButton *myButton = (UIButton*)sender;
    
    UIImage *buttonImage = [UIImage imageNamed:@"ButtonClicked2.png"];
    
    [myButton setBackgroundImage:buttonImage forState:UIControlStateHighlighted];
    
    
}



@end
