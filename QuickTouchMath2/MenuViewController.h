//
//  MenuViewController.h
//  QuickTouchMath2
//
//  Created by Brian Rogers on 3/23/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"

@interface MenuViewController : UIViewController
{
//NSManagedObjectContext *managedObjectContext;
//Users *currentUserObject;

IBOutlet UILabel *nameLabel;
IBOutlet UILabel *addHighScore;
IBOutlet UILabel *subHighScore;
IBOutlet UILabel *mulHighScore;
IBOutlet UILabel *divHighScore;
}

//@property (nonatomic, retain) NSManagedObject *currentUserObject;
//@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;

- (IBAction)startAdd;
- (IBAction)startSub;
- (IBAction)startMul;
- (IBAction)startDiv;
- (IBAction)changeUser;
- (IBAction)share;

- (void)loadScores;
//- (void)setDetailItem:(NSManagedObject *)managedObject;
//- (void)emailImage:(UIImage*)image;
@end
