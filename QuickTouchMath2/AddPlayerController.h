//
//  AddPlayerController.h
//  QuickTouchMath2
//
//  Created by Brian Rogers on 3/21/14.
//  Copyright (c) 2014 Brian Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Score.h"
#import "User.h"

@interface AddPlayerController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *playerName;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

- (IBAction) savePlayer:(id)sender;

@end
