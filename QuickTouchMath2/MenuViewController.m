//
//  MenuViewController.m
//  QuickTouchMath2
//
//  Created by Brian Rogers on 3/23/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize nameLabel = _nameLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
	self.navigationItem.hidesBackButton = NO;
	self.title = @" ";
    
	//nameLabel.text = [[currentUserObject valueForKey:@"name"] description];
    
	//[self loadScores];
    
	UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
	self.navigationItem.rightBarButtonItem = shareButton;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	//[self loadScores];
}

//- (void)loadScores {
//	NSLog(@"loading scores");
//	//load the scores
//	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Scores"
//											  inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:entity];
//    
//    NSError *error;
//    NSArray *items = [self.managedObjectContext
//					  executeFetchRequest:fetchRequest error:&error];
//
//	NSLog(@"got items");
//    
//    // Step 2: Update Object
//    for (Scores *u in items) {
//		if ([u.User.name isEqual:[currentUserObject name]]) {
//			if ([u.mode isEqual:@"ADD"] )
//			{
//				NSLog(@"showing add score");
//				addHighScore.text = [NSString stringWithFormat:@"%@",u.score];
//			}
//			if ([u.mode isEqual:@"SUB"] )
//			{
//				NSLog(@"showing sub score");
//				subHighScore.text = [NSString stringWithFormat:@"%@",u.score];
//			}
//			if ([u.mode isEqual:@"MUL"] )
//			{
//				NSLog(@"showing mul score");
//				mulHighScore.text = [NSString stringWithFormat:@"%@",u.score];
//			}
//			if ([u.mode isEqual:@"DIV"] )
//			{
//				NSLog(@"showing div score");
//				divHighScore.text = [NSString stringWithFormat:@"%@",u.score];
//			}
//		}
//        
//    }	
//}

- (void)startGame:(NSString *)quizType {
//	GameViewController *mainViewController;
//	if ([[UIScreen mainScreen] bounds].size.width > 700) {
//		mainViewController = [[GameViewController alloc] initWithNibName:@"GameView-iPad" bundle:nil];
//		self.navigationController.navigationBarHidden = YES;
//		nameLabel.text = [[self.currentUserObject valueForKey:@"name"] description];
//	}
//	else
//	{
//		mainViewController = [[MainViewController alloc] initWithNibName:@"GameView" bundle:nil];
//	}
//	[mainViewController setDetailItem:currentUserObject];
//	mainViewController.managedObjectContext = self.managedObjectContext;
//	mainViewController.quizType = quizType;
//    
//	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Stop"
//																			 style: UIBarButtonItemStyleBordered
//																			target:nil
//																			action:nil];
//	// Pass the selected object to the new view controller.
//	[self.navigationController pushViewController:mainViewController animated:YES];
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"identifier : %@", segue.identifier);
    [(GameViewController *)segue.destinationViewController setQuizType:segue.identifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
