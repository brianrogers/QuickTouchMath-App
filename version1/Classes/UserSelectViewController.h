//
//  RootViewController.h
//  MathQuiz
//
//  Created by Brian Rogers on 3/26/10.
//  Copyright CreatureTeachers 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MainMenuView.h"

@interface UserSelectViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
	UITextField *myTextField;
	UIButton *infoButton;
	UIImageView *startInstructions;
	}
@property (nonatomic, retain) UIButton *infoButton;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)insertNewObject;
- (void)showStartInstructions;
- (void)deleteAllObjects:(NSString *)entityDescription;

@end
