//
//  GameViewController.h
//  QuickTouchMath2
//
//  Created by Brian Rogers on 3/22/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>

@interface GameViewController : UIViewController
{
    
	NSManagedObjectContext *managedObjectContext;
	IBOutlet UILabel *questionLabel;
	IBOutlet UIButton *answerButton1;
	IBOutlet UIButton *answerButton2;
	IBOutlet UIButton *answerButton3;
	IBOutlet UIButton *answerButton4;
	IBOutlet UILabel *responseLabel;
	IBOutlet UILabel *countdownLabel;
	IBOutlet UILabel *numCorrectLabel;
	IBOutlet UIProgressView *countdownBar;
	IBOutlet UIButton *startButton;
    
	NSTimer *timer;
	NSString *correctAnswer;
	NSString *currentQuestionId;
	NSArray *allQuestions;
	NSString *quizType;
    
	int currentQuestionIndex;
    
	bool timerRunning;
	bool questionAnswered;
    
	int numCorrect;
	int numQuestions;
	int timerCounter;
	float timerProgress;
	float timerProgressInterval;
    
	//Users *currentUserObject;
    
	AVAudioPlayer *yesPlayer;
	AVAudioPlayer *noPlayer;
}

//@property (nonatomic, retain) NSManagedObject *currentUserObject;
//@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UILabel *questionLabel;
@property (nonatomic, retain) UIButton *answerButton1;
@property (nonatomic, retain) UIButton *answerButton2;
@property (nonatomic, retain) UIButton *answerButton3;
@property (nonatomic, retain) UIButton *answerButton4;
@property (nonatomic, retain) UILabel *responseLabel;
@property (nonatomic, retain) UILabel *countdownLabel;
@property (nonatomic, retain) UILabel *numCorrectLabel;
@property (nonatomic, retain) UIProgressView *countdownBar;
@property (nonatomic, retain) NSString *quizType;
@property (nonatomic, retain) UIButton *startButton;

- (void)onTimer;
- (IBAction)submitAnswer:sender;
- (IBAction)startGameLoop:sender;
- (void)loadQuestionByIndex:(int)index;
- (void)checkAnswer:(NSString *)selectedAnswer;
- (void)resetGame;
- (NSNumber*)getRandomNSNumber;
- (IBAction)quitGame;
- (void)saveScore;
- (void)setQuizType:(NSString *)QuizType;
//- (void)setDetailItem:(NSManagedObject *)managedObject;

@end
