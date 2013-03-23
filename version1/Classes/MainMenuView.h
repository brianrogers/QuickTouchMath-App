//
//  MainMenuView.h
//  MathQuiz
//
//  Created by Brian Rogers on 4/22/10.
//  Copyright 2010 Creature Teachers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MainMenuView : UIViewController <MFMailComposeViewControllerDelegate>{
	
	NSManagedObjectContext *managedObjectContext;	
	Users *currentUserObject;
	
	IBOutlet UILabel *nameLabel;
	IBOutlet UILabel *addHighScore;
	IBOutlet UILabel *subHighScore;
	IBOutlet UILabel *mulHighScore;
	IBOutlet UILabel *divHighScore;
}

@property (nonatomic, retain) NSManagedObject *currentUserObject;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;

- (IBAction)startAdd;
- (IBAction)startSub;
- (IBAction)startMul;
- (IBAction)startDiv;
- (IBAction)changeUser;
- (IBAction)share;

- (void)loadScores;
- (void)setDetailItem:(NSManagedObject *)managedObject;
- (void)emailImage:(UIImage*)image;

@end
