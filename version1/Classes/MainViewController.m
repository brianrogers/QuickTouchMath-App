//
//  MainViewController.m
//  iPhoneMathQuiz
//
//  Created by Brian Rogers on 2/12/10.
//  Copyright Creature Teachers 2010. All rights reserved.
//

#import "MainViewController.h"
#import "NSMutableArray_Shuffling.h"
#import "AppConfig.h"
#import "QuizData.h"

@implementation MainViewController

@synthesize managedObjectContext,questionLabel,answerButton1,answerButton2,answerButton3,answerButton4,responseLabel,numCorrectLabel,countdownBar, countdownLabel, currentUserObject, quizType, startButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	NSDictionary *currentConfig = [AppConfig getCurrentConfig];
	NSLog(@"%@",[currentConfig valueForKey:@"splash_image"]);
	
	//NSArray *contentArray;
	//NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"];
	
	//allQuestions = [[NSMutableArray alloc] init];
	//allQuestions = [NSArray arrayWithContentsOfFile:plistPath];
	
	self.navigationItem.hidesBackButton = NO;
	self.navigationController.navigationBarHidden = NO;
	self.title = @" ";
	
	//seed the randomization
	srandom(time(NULL));
	
	//setup the audio stuff
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"math-correct" ofType:@"wav"];
	
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundPath];
	
	yesPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
	yesPlayer.volume = 0.7;
	[fileURL release];
	
	soundPath = [[NSBundle mainBundle] pathForResource:@"math-wrong" ofType:@"wav"];
	
	fileURL = [[NSURL alloc] initFileURLWithPath:soundPath];
	noPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
	noPlayer.volume = 0.7;
	
	[fileURL release];
	
	[self.questionLabel setText:@" "];
	[self.startButton setAlpha:1];
	[self.startButton setEnabled:YES];
	//[self resetGame];
	
	}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	//kill the timer
	[timer invalidate];
	timer = nil;
	
}

- (void) resetGame
{
	NSLog(@"resetting the game...");
	NSDictionary *currentConfig = [AppConfig getCurrentConfig];
	
	numQuestions = 36;
	numCorrect = 0;
	timerCounter = [[currentConfig valueForKey:@"timer_length"] intValue];
	timerRunning = NO;
	timerProgress = 0.0;
	timerProgressInterval = 0.016; //60 seconds
	countdownBar.progress = timerProgress;
	countdownLabel.text = [NSString stringWithFormat:@"%d",timerCounter];
	[numCorrectLabel setText:[NSString stringWithFormat:@"%d",numCorrect]];
	
	currentQuestionIndex = [[self getRandomNSNumber] integerValue];
	NSLog(@"currentQuestionIndex = %d", currentQuestionIndex);
	[self loadQuestionByIndex:currentQuestionIndex];
	
	NSLog(@"starting timer");
	timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
	timerRunning = YES;
	NSLog(@"finished with resetGame");
}

- (void)quitGame {
	[timer invalidate];
	timer = nil;
	
	self.navigationItem.hidesBackButton = NO;
	self.navigationController.navigationBarHidden = NO;
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)onTimer {
	//NSLog(@"onTimer : %d",timerRunning);
	if (timerRunning) {
		//NSLog(@"TimerCounter : %d",timerCounter);
		timerCounter--;
		timerProgress = (float) timerProgress + timerProgressInterval;
		if (timerCounter==0) {
			timerRunning = NO;
			[self saveScore];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Great Job!!" 
															message:[NSString stringWithFormat:@"You got %d correct! Would you like to play again or go back to the menu?",numCorrect] 
														   delegate:self cancelButtonTitle:@"Play Again" otherButtonTitles:@"Menu",nil];			
			/*
			UILabel *theTitle = [alert valueForKey:@"_titleLabel"];
			[theTitle setTextColor:[UIColor redColor]];
			
			UILabel *theBody = [alert valueForKey:@"_bodyTextLabel"];
			[theBody setTextColor:[UIColor blueColor]];
			
			UIImage *theImage = [UIImage imageNamed:@"info-bg.png"];    
			theImage = [theImage stretchableImageWithLeftCapWidth:16 topCapHeight:16];
			CGSize theSize = [alert frame].size;
			
			UIGraphicsBeginImageContext(theSize);    
			[theImage drawInRect:CGRectMake(0, 0, theSize.width, theSize.height)];    
			theImage = UIGraphicsGetImageFromCurrentImageContext();    
			UIGraphicsEndImageContext();
			
			[[alert layer] setContents:[theImage CGImage]]; 
			
			//Get the button in the alert 
			NSArray *arr = [alert valueForKey:@"_buttons"]; 
			
			//Set the coordinates, width and height for the button and cast the button ID to INT 
			[[arr objectAtIndex: 0] setFrame:CGRectMake(53, 50, 172, 49)]; 
			
			//Set the image of the button and cast the button ID to INT 
			[[arr objectAtIndex: 0] setImage:[UIImage imageNamed:@"greenbutton.png"] ];  
			*/
			[alert show];
			[alert release];
		}
		countdownLabel.text = [NSString stringWithFormat:@"%d",timerCounter];
		NSLog(@"timerCounter = %d",timerCounter);
		//NSLog(@"1/60 = %d",0.016);
		NSLog(@"progress = %f",timerProgress);
		countdownBar.progress = timerProgress;
		if (countdownBar.progress>0.75) {
			//countdownBar.backgroundColor = [UIColor redColor];
		}
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSLog(@"alert button clicked %d",buttonIndex);
	switch (buttonIndex) {
		case 0:
			NSLog(@"resetting game...");
			//++timesPlayed;
			[timer invalidate];
			timer = nil;
			
			[self.questionLabel setText:@" "];
			[self.startButton setAlpha:1];
			[self.startButton setEnabled:YES];
			
			break;
		case 1:
			NSLog(@"going back to the menu");
			
			[self quitGame];
			break;
		default:
			break;
	}
}

- (void)saveScore {

	NSLog(@"saving the score...");
	NSLog(@"username - %@",[currentUserObject valueForKey:@"name"]);
	NSLog(@"mode - %@", quizType);
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Scores" 
											  inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
	
    NSError *error;
    NSArray *items = [self.managedObjectContext
					  executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
	
    // Step 2: Update Object
    for (Scores *u in items) {
		if ([u.User.name isEqual:[currentUserObject name]]) {
			if ([u.mode isEqual:quizType] ) 
			{
				NSLog(@"Setting Score For %@ - mode %@",u.User.name, quizType);
				if ([u.score intValue] < numCorrect) {
					[u setScore:[NSNumber numberWithInt:numCorrect]];
				}
			}
		}
        
    }
	
    error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
	
}

- (void)loadQuestionByIndex:(int)index 
{
	NSLog(@"quizType : %@",quizType);
	allQuestions = [QuizData getQuestionsFromType:quizType];
	numQuestions = allQuestions.count;
	NSLog(@"Loading Index = %d", index);
	if (index > numQuestions) {
		index = numQuestions-1;
	}
	NSLog(@"count : %d", allQuestions.count);
	NSArray *question = [allQuestions objectAtIndex:index];
	
	NSString *questionId =[question objectAtIndex:0];
	NSLog(@"%@",questionId);
	
	//int r = random() % 5;
	
	NSString *questionText =[question objectAtIndex:1];
	
	NSMutableArray *possibleAnswers = [[NSMutableArray alloc] init];
	[possibleAnswers addObject:[question objectAtIndex:2]];
	[possibleAnswers addObject:[question objectAtIndex:3]];
	[possibleAnswers addObject:[question objectAtIndex:4]];
	[possibleAnswers addObject:[question objectAtIndex:5]];
	
	[possibleAnswers shuffle];
	
	NSString *answer1Text = [possibleAnswers objectAtIndex:0];
	NSString *answer2Text = [possibleAnswers objectAtIndex:1];
	NSString *answer3Text = [possibleAnswers objectAtIndex:2];
	NSString *answer4Text = [possibleAnswers objectAtIndex:3];
	
	[possibleAnswers dealloc];
	
	correctAnswer =[question objectAtIndex:6];
	currentQuestionId = questionId;
	NSLog(@"currentQuestion : %@", currentQuestionId);
	
	[questionLabel setText:questionText];
	[answerButton1 setTitle:answer1Text forState:UIControlStateNormal ];
	[answerButton2 setTitle:answer2Text forState:UIControlStateNormal ];
	[answerButton3 setTitle:answer3Text forState:UIControlStateNormal ];
	[answerButton4 setTitle:answer4Text forState:UIControlStateNormal ];
	
	NSLog(@"finished loadQuestionByIndex");
}

- (void)loadNextQuestion {
	questionAnswered = NO;
	answerButton1.enabled = YES;
	answerButton2.enabled = YES;
	answerButton3.enabled = YES;
	answerButton4.enabled = YES;
	
	NSLog(@"currentQuestionIndex = %d", currentQuestionIndex);
	++currentQuestionIndex;
	NSLog(@"currentQuestionIndex = %d", currentQuestionIndex);
	[self loadQuestionByIndex:[[self getRandomNSNumber] integerValue]];
	NSLog(@"finished loadNextQuestion");
}




- (NSNumber *) getRandomNSNumber
{
	srandom(time(NULL));
	int max = numQuestions-1;
	int min = 0;
	int range = (max - min);
	int r = (arc4random() % (range + 1)) + min;
	//if (r != lastRandom) {
	//	lastRandom = r;
		return [NSNumber numberWithInt:r];
	//}else{
		//same number as before... call this again...
	//	return [self getRandomNSNumber];
	//}
}

- (IBAction)startGameLoop:(UIButton *)sender
{
	UIButton *resultButton = (UIButton *)sender;
	[resultButton setAlpha:0];
	[resultButton setEnabled:NO];
	[self resetGame];
}

- (IBAction)submitAnswer:(UIButton *)sender {
	questionAnswered = YES;
	answerButton1.enabled = NO;
	answerButton2.enabled = NO;
	answerButton3.enabled = NO;
	answerButton4.enabled = NO;
	UIButton *resultButton = (UIButton *)sender;
	NSString *selectedAnswer = resultButton.currentTitle;
	[self checkAnswer:selectedAnswer];
}

- (void)checkAnswer:(NSString *)selectedAnswer {
	NSLog(@"SelectedAnswer = %@",selectedAnswer);
	NSLog(@"CorrectAnswer = %@",correctAnswer);
	if (correctAnswer == selectedAnswer) {
		//[responseLabel setText:@"Correct!"];
		numCorrect++;
		[numCorrectLabel setText:[NSString stringWithFormat:@"%d",numCorrect]];
		//play the correct sound
		[yesPlayer play];
	}else{
		//play the incorrect sound
		[noPlayer play];
		//[responseLabel setText:@"Not Correct!"];
	}
	[self performSelector:@selector(loadNextQuestion) withObject:nil afterDelay:0.5];
}



- (void)setDetailItem:(NSManagedObject *)managedObject {
	if(currentUserObject != managedObject) {
		[currentUserObject release];
		currentUserObject = [managedObject retain];
		
		self.title = [[currentUserObject valueForKey:@"name"] description];
		
	}
}

- (void)setQuizType:(NSString *)QuizType {
	quizType = QuizType;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (void)dealloc {
	[managedObjectContext release];
	[questionLabel release];
	[answerButton1 release];
	[answerButton2 release];
	[answerButton3 release];
	[answerButton4 release];
	[responseLabel release];
    [super dealloc];
}


@end
