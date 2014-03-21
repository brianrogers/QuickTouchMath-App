//
//  GameViewController.m
//  QuickTouchMath2
//
//  Created by Brian Rogers on 3/22/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "GameViewController.h"
#import "NSMutableArray_Shuffling.h"
#import "AppConfig.h"
#import "QuizData.h"

@interface GameViewController ()

@end

@implementation GameViewController

@synthesize questionLabel,answerButton1,answerButton2,answerButton3,answerButton4,responseLabel,numCorrectLabel,countdownBar, countdownLabel, quizType, startButton;


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
    NSDictionary *currentConfig = [AppConfig getCurrentConfig];
	NSLog(@"%@",[currentConfig valueForKey:@"splash_image"]);
    
	//NSArray *contentArray;
	//NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"];
    
	//allQuestions = [[NSMutableArray alloc] init];
	//allQuestions = [NSArray arrayWithContentsOfFile:plistPath];
    
	self.navigationItem.hidesBackButton = NO;
	self.navigationController.navigationBarHidden = NO;
	self.title = @" ";
    
    //self.quizType = @"ADD";
    
	//seed the randomization
	srandom(time(NULL));
    
	//setup the audio stuff
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"math-correct" ofType:@"wav"];
    
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundPath];
    
	yesPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
	yesPlayer.volume = 0.7;
    
	soundPath = [[NSBundle mainBundle] pathForResource:@"math-wrong" ofType:@"wav"];
    
	fileURL = [[NSURL alloc] initFileURLWithPath:soundPath];
	noPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
	noPlayer.volume = 0.7;
    
	[self.questionLabel setText:@" "];
    [self.answerButton1 setTitle:@"" forState:UIControlStateNormal];
    [self.answerButton2 setTitle:@"" forState:UIControlStateNormal];
    [self.answerButton3 setTitle:@"" forState:UIControlStateNormal];
    [self.answerButton4 setTitle:@"" forState:UIControlStateNormal];
    [self.numCorrectLabel setText:@""];
    
	[self.startButton setAlpha:1];
	[self.startButton setEnabled:YES];
	//[self resetGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
	//NSLog(@"username - %@",[currentUserObject valueForKey:@"name"]);
	NSLog(@"mode - %@", quizType);
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"user : %@",[appDelegate.currentUser valueForKey:@"name"]);
    
    NSArray *allScores = [Score findAll];
    
    NSLog(@"%@", allScores);
    
    for (Score *s in allScores) {
        NSLog(@"user : %@", s.user.name);
        if([s.user.name isEqualToString:appDelegate.currentUser.name]) {
            NSLog(@"mode : %@", s.mode);
            if([s.mode isEqualToString:quizType]) {
                NSLog(@"score : %@ numCorrect %d", s.score, numCorrect);
                if ([s.score intValue] < numCorrect) {
                    [s setScore:[NSNumber numberWithInt:numCorrect]];
                }
            }
        }
    }
    
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
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



//- (void)setDetailItem:(NSManagedObject *)managedObject {
//	if(currentUserObject != managedObject) {
//		[currentUserObject release];
//		currentUserObject = [managedObject retain];
//        
//		self.title = [[currentUserObject valueForKey:@"name"] description];
//        
//	}
//}

- (void)setQuizType:(NSString *)QuizType {
	quizType = QuizType;
}



@end
