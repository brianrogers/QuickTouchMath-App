//
//  AddNewUser.m
//  MathQuiz
//
//  Created by Brian Rogers on 3/30/10.
//  Copyright 2010 Creature Teachers. All rights reserved.
//

#import "AddNewUser.h"


@implementation AddNewUser

@synthesize fetchedResultsController, managedObjectContext, userName, messageLabel;

- (IBAction)cancelAdd {
	[self dismissModalViewControllerAnimated:YES];
	//[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addUser {
	//NSLog(@"adding new user");
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[fetchedResultsController fetchRequest] entity];
	
	
	//*****************
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	[request setEntity:[NSEntityDescription entityForName:@"Users" 
								   inManagedObjectContext:[self managedObjectContext]]];
	
	NSError *error = nil;                                           
	NSPredicate *predicate;
	NSArray *fetchResults;
	predicate = [NSPredicate predicateWithFormat:@"(name = %@)", userName.text];            
	[request setPredicate:predicate];
	fetchResults = [managedObjectContext executeFetchRequest:request error:&error];
	
	if (!fetchResults) {
        NSLog(@"no fetch results error %@", error);
	}
	
	NSMutableArray *theResults = [NSMutableArray arrayWithArray:fetchResults];
	[request release];
	//NSLog(@"****count : %d", [theResults count]);
	//***************************
	if ([theResults count] > 0) {
		[messageLabel setText:@"That User Already Exists."];
		[userName setText:@""];
		return;
	}
	
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    //NSLog(@"setting properties");
    
	[newManagedObject setValue:userName.text forKey:@"name"];
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];

	//NSLog(@"saving the context");
    // Save the context.
    //NSError *error = nil;
    if (![context save:&error]) {
        //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }	

	NSManagedObject *moScoresAdd = [NSEntityDescription insertNewObjectForEntityForName:@"Scores" inManagedObjectContext:context];
    //NSLog(@"setting  scores - add");
	[moScoresAdd setValue:newManagedObject forKey:@"User"];
	[moScoresAdd setValue:@"ADD" forKey:@"mode"];
	
	NSManagedObject *moScoresSub = [NSEntityDescription insertNewObjectForEntityForName:@"Scores" inManagedObjectContext:context];
    //NSLog(@"setting  scores - sub");
	[moScoresSub setValue:newManagedObject forKey:@"User"];
	[moScoresSub setValue:@"SUB" forKey:@"mode"];
	
	NSManagedObject *moScoresMul = [NSEntityDescription insertNewObjectForEntityForName:@"Scores" inManagedObjectContext:context];
    //NSLog(@"setting  scores - mul");
	[moScoresMul setValue:newManagedObject forKey:@"User"];
	[moScoresMul setValue:@"MUL" forKey:@"mode"];
	
	NSManagedObject *moScoresDiv = [NSEntityDescription insertNewObjectForEntityForName:@"Scores" inManagedObjectContext:context];
    //NSLog(@"setting  scores - div");
	[moScoresDiv setValue:newManagedObject forKey:@"User"];
	[moScoresDiv setValue:@"DIV" forKey:@"mode"];
	
    //NSLog(@"saving the context");
    // Save the context.
    error = nil;
    if (![context save:&error]) {
        //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }	
	
	[self dismissModalViewControllerAnimated:YES];
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[userName becomeFirstResponder];
	[messageLabel setText:@""];
	[self.view	setBackgroundColor:[UIColor blackColor]];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
