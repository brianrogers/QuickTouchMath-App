//
//  AppDelegate.h
//  QuickTouchMath2
//
//  Created by Brian Rogers on 2/10/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainNavController.h"
#import "User.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainNavController *navigationController;

@property (strong, nonatomic) User *currentUser;

@end
