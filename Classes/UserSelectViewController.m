//
//  RootViewController.m
//  MathQuiz
//
//  Created by Brian Rogers on 3/26/10.
//  Copyright Creature Teachers 2010. All rights reserved.
//

#import "UserSelectViewController.h"
#import "AddNewUser.h"
#import "CustomCell.h"
#import "ViewFactory.h"
#import "InfoViewController.h"

@interface UserSelectViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end


@implementation UserSelectViewController

@synthesize fetchedResultsController, managedObjectContext, infoButton;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	[[UIApplication sharedApplication] setStatusBarHidden:NO];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
	
    // Set up the edit and add buttons.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationController.navigationBarHidden = NO;
	self.title = @" ";
	self.navigationItem.titleView.hidden = YES;
	
	self.tableView.separatorColor = [UIColor clearColor];
    
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style: UIBarButtonItemStyleBordered target:nil action:nil];	
	
	startInstructions = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qtm-blankPopup"]];
	
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

}

- (void) createAddUserButton
{
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewUser)];
	self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];	
}

- (void) createInfoButton
{
    //UIBarButtonItem *infoButton = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithType:UIButtonTypeInfoLight] target:self action:@selector(showInfoScreen)];
	infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	[infoButton addTarget:self action:@selector(showInfoPanel) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *infoButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
	self.navigationItem.leftBarButtonItem = infoButtonItem;
	
    [infoButton release];	
}

- (void) showInfoPanel
{
	//NSLog(@"showInfoPanel");
	//Init Animation
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: 0.50];
	
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:YES];
	
	InfoViewController *infoViewController = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
	[self.navigationController pushViewController:infoViewController animated:NO];
	[infoViewController release];
	
	//Start Animation
	[UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	if ([fetchedResultsController.fetchedObjects count] < 1) {
		[self showStartInstructions];
	}else {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		BOOL reset = [defaults boolForKey:@"resetdata"];
		//NSLog(@"reset : %d",reset);
		if (reset == YES) {
			[self deleteAllObjects:@"Scores"];
			[self deleteAllObjects:@"Users"];
			[defaults setBool:NO forKey:@"resetdata"];
			//[self showStartInstructions];
		}
		
		
	}

	//[self createInfoButton];
	[self createAddUserButton];
	self.navigationController.navigationBarHidden = NO;
	//self.title = @"Quick Touch Math";
	self.view.backgroundColor = [UIColor clearColor];
	[self.tableView reloadData];
	
}

- (void)showStartInstructions {
	if ([fetchedResultsController.fetchedObjects count] < 1) {
		//NSLog(@"empty startup");
		
		//UIImage *popupImage = [[UIImage alloc] initWithContentsOfFile:[@"qtm-blankPopup.png"];

		CGRect rect;
		// Get screen dimensions
		rect = [[UIScreen mainScreen] applicationFrame];
		int imageWidth = [UIImage imageNamed:@"qtm-blankPopup"].size.width;
		int imageHeight = [UIImage imageNamed:@"qtm-blankPopup"].size.height;
		//NSLog(@"%d, %d", imageWidth, imageHeight);
		[startInstructions setFrame:CGRectMake(rect.origin.x + 10, rect.origin.y + 10, imageWidth, imageHeight)];
		
		UILabel *startText = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + 25, rect.origin.y + 10, imageWidth-50, imageHeight-50)];
		[startText setFont:[UIFont fontWithName:@"Helvetica" size:24]];
		[startText setText:@"To get started, touch the + button to add the first player."];
		[startText setBackgroundColor:[UIColor clearColor]];
		[startText setLineBreakMode:UILineBreakModeWordWrap];
		[startText setTextAlignment:UITextAlignmentCenter];
		[startText setNumberOfLines:10];
		
		[self.view addSubview:startInstructions];
		[startInstructions addSubview:startText];
		[startInstructions release];
		[startText release];
	}
}
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/


 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"configureCell");
	
	[[cell contentView] setBackgroundColor:[UIColor clearColor]];
	[[cell backgroundView] setBackgroundColor:[UIColor clearColor]];
	[cell setBackgroundColor:[UIColor clearColor]];
	//cell.imageView.image = [UIImage imageNamed:@"user-cell-bg.png"];
	cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qtm-usercell.png"]];
	//[cell.backgroundView.layer setBorderColor:[UIColor clearColor]];
	[cell.contentView setOpaque:NO];
    NSManagedObject *managedObject = [fetchedResultsController objectAtIndexPath:indexPath];

	UILabel *lblTitle = (UILabel *)[cell viewWithTag:1];
	UILabel *lblAddScore = (UILabel *)[cell viewWithTag:2];
	UILabel *lblSubScore = (UILabel *)[cell viewWithTag:3];
	UILabel *lblMulScore = (UILabel *)[cell viewWithTag:4];
	UILabel *lblDivScore = (UILabel *)[cell viewWithTag:5];

	// texts for the row
	lblTitle.text = [NSString stringWithFormat:@"%@",[[managedObject valueForKey:@"name"] description]];
	
	
	//cell.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell-bg.png"]]; 
	 NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Scores" 
											  inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
	
    NSError *error;
    NSArray *items = [self.managedObjectContext
					  executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
	//NSLog(@"got items");
    //NSString *scoreText = @"";
    for (Scores *u in items) {
		if ([u.User.name isEqual:[managedObject valueForKey:@"name"]]) {
			if ([u.mode isEqual:@"ADD"] ) 
			{
				//NSLog(@"showing add score");
				lblAddScore.text = [NSString stringWithFormat:@"%@",u.score];
			}
			if ([u.mode isEqual:@"SUB"] ) 
			{
				//NSLog(@"showing sub score");
				lblSubScore.text = [NSString stringWithFormat:@"%@",u.score];
			}
			if ([u.mode isEqual:@"MUL"] ) 
			{
				//NSLog(@"showing mul score");
				lblMulScore.text = [NSString stringWithFormat:@"%@",u.score];
			}
			if ([u.mode isEqual:@"DIV"] ) 
			{
				//NSLog(@"showing div score");
				lblDivScore.text = [NSString stringWithFormat:@"%@",u.score];
			}
		}
        
    }	
	//lblSubTitle.text = scoreText;
	
	//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 98;
}

#pragma mark -
#pragma mark Add a new object
/*
- (void)newUserAlert {
	NSLog(@"adding User");
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter Name Here" message:@"this gets covered!"
												   delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"OK!", nil];
	
	[alert setBackgroundColor:[UIColor blackColor]];
	
	//myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12, 45, 260, 25)];
	//[myTextField setBackgroundColor:[UIColor whiteColor]];
	
	//CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0, 60);
	//[alert setTransform:myTransform];
	
	//[alert addSubview:myTextField];
	[alert show];
	[alert release];
	//[myTextField release];	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSLog(@"alert button clicked %d",buttonIndex);
	switch (buttonIndex) {
		case 0:
			NSLog(@"cancel...");
			
			break;
		case 1:
			NSLog(@"name:%@",myTextField.text);
			[self insertNewObject];
			break;
		default:
			break;
	}
}
*/
- (void)insertNewObject {
    
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
	//TODO: check to see if this is a unique name or not!!
	
	
    // If appropriate, configure the new managed object.
	[newManagedObject setValue:myTextField.text forKey:@"name"];
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

-(void)addNewUser{
	//NSLog(@"adding New User");
	//if ([[UIScreen mainScreen] bounds].size.width > 700) {

//		AddNewUser *newUserController = [[AddNewUser alloc] initWithNibName:@"AddNewUser-iPad" bundle:nil];
//		newUserController.managedObjectContext = self.managedObjectContext;
//		newUserController.fetchedResultsController = self.fetchedResultsController;
		//newUserController.modalInPopover = YES;
//		newUserController.modalPresentationStyle = UIModalPresentationFormSheet;
//		[self.navigationController presentModalViewController:newUserController animated:YES];
//		[newUserController release];
//	}else{
		AddNewUser *newUserController = [[AddNewUser alloc] initWithNibName:@"AddNewUser" bundle:nil];
		newUserController.managedObjectContext = self.managedObjectContext;
		newUserController.fetchedResultsController = self.fetchedResultsController;
		
		[self.navigationController presentModalViewController:newUserController animated:YES];
		[newUserController release];
	
	[startInstructions setHidden:YES];
//	}
	
	
}

- (void) deleteAllObjects: (NSString *) entityDescription  {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
	
    NSError *error;
    NSArray *items = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
	
	
    for (NSManagedObject *managedObject in items) {
        [managedObjectContext deleteObject:managedObject];
        NSLog(@"%@ object deleted",entityDescription);
    }
    if (![managedObjectContext save:&error]) {
        NSLog(@"Error deleting %@ - error:%@",entityDescription,error);
    }
	
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSLog(@"creating viewFactory");
	ViewFactory *viewFactory = [[[ViewFactory alloc] initWithNib:@"ViewTemplates"] autorelease];
	NSLog(@"creating cell");
	UITableViewCell * cell = [viewFactory cellOfKind:@"user" forTable:tableView];
	
	[self configureCell:cell atIndexPath:indexPath];
	
	UIView *backView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
	backView.backgroundColor = [UIColor clearColor];
	cell.backgroundView = backView;
	
	return cell;
	
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

	if ([fetchedResultsController.fetchedObjects count] < 1) {
		return @"";
	}else{
		return @"Touch your name to start\ror touch the + button to add a new player";
	}
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
        [context deleteObject:[fetchedResultsController objectAtIndexPath:indexPath]];
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}
*/

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here -- for example, create and push another view controller.
	MainMenuView *mainMenuViewController;
    if ([[UIScreen mainScreen] bounds].size.width > 700) {
		mainMenuViewController = [[MainMenuView alloc] initWithNibName:@"MainMenuView-iPad" bundle:nil];
	}else {
		mainMenuViewController = [[MainMenuView alloc] initWithNibName:@"MainMenuView" bundle:nil];
	}

     
	NSManagedObject *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
	[mainMenuViewController setDetailItem:selectedObject];
	mainMenuViewController.managedObjectContext = self.managedObjectContext;
     // Pass the selected object to the new view controller.
	//[UIView beginAnimations:nil context:NULL];
	//[UIView setAnimationDuration: 0.50];
	
	//[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:YES];
	
	[self.navigationController pushViewController:mainMenuViewController animated:NO];
	[mainMenuViewController release];
	
	//Start Animation
	//[UIView commitAnimations];
    
}


#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    /*
     Set up the fetched results controller.
    */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] 
							  initWithKey:@"name" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	[sort release];
    [aFetchedResultsController release];
    [fetchRequest release];
    
    return fetchedResultsController;
}    


#pragma mark -
#pragma mark Fetched results controller delegate


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableView setSeparatorColor:[UIColor clearColor]];
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [fetchedResultsController release];
    [managedObjectContext release];
    [super dealloc];
}


@end

