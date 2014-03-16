//
//  PortraitViewController.m
//  Calculator_1.0
//
//  Copyright (c) 2013 Jon Oh. All rights reserved.
//

#import "PortraitViewController.h"
#import "LandscapeViewController.h"
#import "CalcEngine.h"

@interface PortraitViewController ()

@property (nonatomic, strong) LandscapeViewController *landscapeViewController;

@end

@implementation PortraitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Overlap the status bar.
        self.wantsFullScreenLayout = YES;
		// When presented, display using a cross dissolve
		self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
        calcState = operand1Build;
        periodClicked = NO;
        operatorPressed = NO;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)orientationChanged:(NSNotification *)notification
{
    // A delay must be added here, otherwise the new view will be swapped in
	// too quickly resulting in an animation glitch
    [self performSelector:@selector(updateLandscapeView) withObject:nil afterDelay:0];
}


- (void)updateLandscapeView
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    
    if (UIDeviceOrientationIsLandscape(deviceOrientation) && self.presentedViewController == nil)
	{
        if (!self.landscapeViewController)
            self.landscapeViewController = [[LandscapeViewController alloc] initWithNibName:@"iPhoneLandscapeView" bundle:nil];
        
        [self presentViewController:self.landscapeViewController animated:YES completion:NULL];
    }
	else if (deviceOrientation == UIDeviceOrientationPortrait && self.presentedViewController != nil)
	{
        [self dismissViewControllerAnimated:YES completion:NULL];
    }    
}

#pragma mark - Button Action Handler


- (IBAction)operandClicked:(id)sender //number clicked
{
    
    [super operandClicked:sender resultTextField:resultTextField];
}

- (IBAction)operatorClicked:(id)sender
{
    
    [super operatorClicked:sender resultTextField:resultTextField];
    
}

- (IBAction)finalizerClicked:(id)sender {
    
    [super finalizerClicked:sender resultTextField:resultTextField];
}



#pragma mark - Rotation

// -------------------------------------------------------------------------------
//	supportedInterfaceOrientations
//  Support only portrait orientation (iOS 6).
// -------------------------------------------------------------------------------
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

// -------------------------------------------------------------------------------
//	shouldAutorotateToInterfaceOrientation
//  Support only portrait orientation (IOS 5 and below).
// -------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown));
}

#pragma mark - Memory management

// -------------------------------------------------------------------------------
//	dealloc
// -------------------------------------------------------------------------------
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // Instruct the system to stop generating device orientation notifications.
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    
    [super dealloc];
}


@end
