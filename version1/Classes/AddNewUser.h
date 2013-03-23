//
//  AddNewUser.h
//  MathQuiz
//
//  Created by Brian Rogers on 3/30/10.
//  Copyright 2010 Creature Teachers. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddNewUser : UIViewController {
	IBOutlet UITextField *userName;
	IBOutlet UILabel *messageLabel;
	NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;

}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) IBOutlet UITextField *userName;
@property (nonatomic, retain) IBOutlet UILabel *messageLabel;

-(IBAction)addUser;
-(IBAction)cancelAdd;

@end
