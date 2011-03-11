//
//  InfoViewController.m
//  MathQuiz
//
//  Created by Brian Rogers on 1/15/11.
//  Copyright 2011 CreatureTeachers. All rights reserved.
//

#import "InfoViewController.h"


@implementation InfoViewController

@synthesize webView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *finalPath = [path stringByAppendingPathComponent:@"infoText"];
	//NSLog(@"%@",finalPath);
	NSString *infoString = [NSString stringWithContentsOfFile:finalPath encoding:NSUTF8StringEncoding error:nil];
	//NSLog(@"%@",infoString);
	
	NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"infoText" ofType:@"html"];
	NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
	[webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[webView release];
    [super dealloc];
}


@end
