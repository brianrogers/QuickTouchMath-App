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
    addHighScore.text = @"";
    subHighScore.text = @"";
    mulHighScore.text = @"";
    divHighScore.text = @"";
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _nameLabel.text = [appDelegate.currentUser valueForKey:@"name"];
    
	UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
	self.navigationItem.rightBarButtonItem = shareButton;
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self loadScores];
}

- (void) share {
    NSLog(@"sharing");
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSArray *activityItems = nil;
    activityItems = @[theImage];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}

- (void)loadScores {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"user : %@",[appDelegate.currentUser valueForKey:@"name"]);
    
    NSArray *allScores = [Score findAll];
    
    NSLog(@"%@", allScores);
    
    for (Score *s in allScores) {
        NSLog(@"user : %@", s.user.name);
        if([s.user.name isEqualToString:appDelegate.currentUser.name]) {
            if ([s.mode isEqual:@"ADD"] )
			{
				NSLog(@"showing add score");
				addHighScore.text = [NSString stringWithFormat:@"%@",s.score];
			}
			if ([s.mode isEqual:@"SUB"] )
			{
				NSLog(@"showing sub score");
				subHighScore.text = [NSString stringWithFormat:@"%@",s.score];
			}
			if ([s.mode isEqual:@"MUL"] )
			{
				NSLog(@"showing mul score");
				mulHighScore.text = [NSString stringWithFormat:@"%@",s.score];
			}
			if ([s.mode isEqual:@"DIV"] )
			{
				NSLog(@"showing div score");
				divHighScore.text = [NSString stringWithFormat:@"%@",s.score];
			}
        }
    }

}

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
