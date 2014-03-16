//
//  RootViewController.m
//  Calculator_1.0
//
//  Copyright (c) 2013 Jon Oh. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (NSUInteger)supportedInterfaceOrientations
{
    return [self.presentedViewController supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotate
{
    return [self.presentedViewController shouldAutorotate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
