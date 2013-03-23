//
//  MainNavController.m
//  QuickTouchMath2
//
//  Created by Brian Rogers on 2/11/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "MainNavController.h"

@interface MainNavController ()

@end

@implementation MainNavController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{

    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"MainNavController viewDidLoad");
    [self.navigationBar setBackgroundImage:[UIImage imageNamed: @"qtm-navbar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTintColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
