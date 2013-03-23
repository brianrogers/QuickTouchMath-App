//
//  MainMenuView.m
//  MathQuiz
//
//  Created by Brian Rogers on 4/22/10.
//  Copyright 2010 Creature Teachers. All rights reserved.
//

#import "MainMenuView.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@implementation MainMenuView

@synthesize managedObjectContext,currentUserObject, nameLabel;

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
	self.navigationController.navigationBarHidden = NO;
	self.navigationItem.hidesBackButton = NO;
	self.title = @" ";

	nameLabel.text = [[currentUserObject valueForKey:@"name"] description];
	
	[self loadScores];
	
	UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
	self.navigationItem.rightBarButtonItem = shareButton;
    [shareButton release];	
		
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self loadScores];
}

- (void)loadScores {
	NSLog(@"loading scores");
	//load the scores
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Scores" 
											  inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
	
    NSError *error;
    NSArray *items = [self.managedObjectContext
					  executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
	NSLog(@"got items");
	
    // Step 2: Update Object
    for (Scores *u in items) {
		if ([u.User.name isEqual:[currentUserObject name]]) {
			if ([u.mode isEqual:@"ADD"] ) 
			{
				NSLog(@"showing add score");
				addHighScore.text = [NSString stringWithFormat:@"%@",u.score];
			}
			if ([u.mode isEqual:@"SUB"] ) 
			{
				NSLog(@"showing sub score");
				subHighScore.text = [NSString stringWithFormat:@"%@",u.score];
			}
			if ([u.mode isEqual:@"MUL"] ) 
			{
				NSLog(@"showing mul score");
				mulHighScore.text = [NSString stringWithFormat:@"%@",u.score];
			}
			if ([u.mode isEqual:@"DIV"] ) 
			{
				NSLog(@"showing div score");
				divHighScore.text = [NSString stringWithFormat:@"%@",u.score];
			}
		}
        
    }	
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)setDetailItem:(NSManagedObject *)managedObject {
	if(currentUserObject != managedObject) {
		[currentUserObject release];
		currentUserObject = [managedObject retain];
		
		self.title = [[currentUserObject valueForKey:@"name"] description];
		nameLabel.text = [[currentUserObject valueForKey:@"name"] description];
	}
}

- (void)startGame:(NSString *)quizType {
	MainViewController *mainViewController;
	if ([[UIScreen mainScreen] bounds].size.width > 700) {
		mainViewController = [[MainViewController alloc] initWithNibName:@"GameView-iPad" bundle:nil];
		self.navigationController.navigationBarHidden = YES;
		nameLabel.text = [[self.currentUserObject valueForKey:@"name"] description];
	}
	else
	{
		mainViewController = [[MainViewController alloc] initWithNibName:@"GameView" bundle:nil];
	}
	[mainViewController setDetailItem:currentUserObject];
	mainViewController.managedObjectContext = self.managedObjectContext;
	mainViewController.quizType = quizType;
	
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Stop"
																			 style: UIBarButtonItemStyleBordered
																			target:nil
																			action:nil];
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:mainViewController animated:YES];
	[mainViewController release];
}

- (IBAction)startAdd {
	[self startGame:@"ADD"];
}

- (IBAction)startSub {
	[self startGame:@"SUB"];
}

- (IBAction)startMul {
	[self startGame:@"MUL"];
}

- (IBAction)startDiv {
	[self startGame:@"DIV"];
}

- (IBAction)changeUser {
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)share {
	//NSLog(@"share called");
    //CGRect mainScreenRect = [[UIScreen mainScreen] bounds];
	CGRect screenRect = CGRectMake(0, 0, 320, 390);
		
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    [self.view.layer renderInContext:ctx];
    
    UIImage *image1 = UIGraphicsGetImageFromCurrentImageContext();
    //UIImageWriteToSavedPhotosAlbum(image1, nil, nil, nil);
	
	if ([MFMailComposeViewController canSendMail]) {
		[self emailImage:image1];
    }else{
		UIImageWriteToSavedPhotosAlbum(image1, nil, nil, nil);
	}
    UIGraphicsEndImageContext(); 
	//NSLog(@"finished sharing");
}

- (void)emailImage:(UIImage*)image
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@" "];
	
	NSString *emailBody = @"Check out my scores on Quick Touch Math!";
	
	NSData *imageData = UIImageJPEGRepresentation(image, 1);
	[picker addAttachmentData:imageData mimeType:@"image/jpg" fileName:@"my_QuickTouchMath_scores.jpg"];
	
	[picker setMessageBody:emailBody isHTML:YES];
	[picker.view setBackgroundColor:[UIColor whiteColor]];
	
	[self presentModalViewController:picker animated:YES];
	[[picker navigationBar] setBarStyle:UIBarStyleBlack];
	[picker release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	//NSLog(@"mailComposrController : %@", result);
	[controller dismissModalViewControllerAnimated:YES];
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
