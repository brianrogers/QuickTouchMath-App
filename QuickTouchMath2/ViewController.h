//
//  ViewController.h
//  QuickTouchMath2
//
//  Created by Brian Rogers on 2/10/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Score.h"
#import "AppDelegate.h"
#import "PlayerCell.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tableView;
}
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

