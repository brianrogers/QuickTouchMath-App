//
//  AppDelegate.m
//  QuickTouchMath2
//
//  Created by Brian Rogers on 2/10/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "AppDelegate.h"
#import "MainNavController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize currentUser = _currentUser;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Setup CoreData with MagicalRecord
    // Step 1. Setup Core Data Stack with Magical Record
    // Step 2. Relax. Why not have a beer? Surely all this talk of beer is making you thirsty…
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"QTMModel"];
    
    MainNavController *viewController = (MainNavController *)[_navigationController topViewController];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame: _navigationController.topViewController.view.frame];
	backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qtm-blankbg.png"]];
	//backgroundView.frame = newFrame;
	
	[_window addSubview:backgroundView];
	
	viewController.view.backgroundColor = [UIColor clearColor];
	
//    [_navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"qtm-navbar.png"]
//                                             forBarMetrics:UIBarMetricsDefault];
    [_navigationController.navigationBar setTintColor:[UIColor magentaColor]];
    
    [_window addSubview:[_navigationController view]];
    [_window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
