//
//  LandscapeViewController.m
//  Calculator_1.0
//
//  Copyright (c) 2013 Jon Oh. All rights reserved.
//

#import "LandscapeViewController.h"
#import "CalcEngine.h"

@interface LandscapeViewController ()

@end

@implementation LandscapeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Overlap the status bar.
        self.wantsFullScreenLayout = YES;
        
		// When presented, display using a cross dissolve
		self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    
    radianSwitch = NO;
    operatorPressed = NO;
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



- (IBAction)operandClicked:(id)sender //number clicked
{
    [super operandClicked:sender resultTextField:resultTextField2];
    
}

- (IBAction)operatorClicked:(id)sender
{
    [super operatorClicked:sender resultTextField:resultTextField2];
}

- (IBAction)modifierClicked:(id)sender{
    
    
    float tempOp = operatorNum;
    float temp1;
    float tag = [((UIButton*)sender) tag];
    operatorNum = tag;
    float currentTitle = [[resultTextField2 text]floatValue];
    
    if ((modifierTypes)tag < MOD_POW || (modifierTypes)tag == MOD_SQUARE){
        
        temp1 = [self equals:currentTitle passer2:0];
        
        if ((modifierTypes)tag < MOD_SQRT){
            if (radianSwitch == NO){
                temp1 = (float) (currentTitle / 180 * M_PI);
                temp1 = [self equals:temp1 passer2:0];
            
            }
        }
        
        
        [resultTextField2 setText:[@(temp1)description]];
        
    }
    
    if ((modifierTypes)operatorNum == MOD_POW){
        
        outputHolder = [[resultTextField2 text]floatValue];
        
    }
    
    if ((modifierTypes)operatorNum == MOD_RAD){
     
        radianSwitch = !radianSwitch;
        if (radianSwitch == YES)
            [((UIButton*)sender) setTitle:@"deg" forState:UIControlStateNormal];
        if (radianSwitch == NO)
            [((UIButton*)sender) setTitle:@"rad" forState:UIControlStateNormal];

        
    }
    
    operatorNum = tempOp;
    calcState = finalBuild;
}

- (IBAction)finalizerClicked:(id)sender {
    
    [super finalizerClicked:sender resultTextField:resultTextField2];
}




// -------------------------------------------------------------------------------
//	supportedInterfaceOrientations
//  Support either landscape orientation (iOS 6).
// -------------------------------------------------------------------------------
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

// -------------------------------------------------------------------------------
//	shouldAutorotateToInterfaceOrientation
//  Support either landscape orientation (IOS 5 and below).
// -------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


@end
