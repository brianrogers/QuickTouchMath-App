//
//  QuizData.m
//  MathQuiz
//
//  Created by Brian Rogers on 1/16/11.
//  Copyright 2011 CreatureTeachers. All rights reserved.
//

#import "QuizData.h"


@implementation QuizData

+(NSArray *) getAdditionQuestions
{
	NSLog(@"getAdditionQuestions");
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"QuickTouchMathQuestions"] ofType:@"plist"];
	NSDictionary *allQuestionsDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
	return [allQuestionsDict valueForKey:@"add"];
}

+(NSArray *) getSubtractionQuestions
{
	NSLog(@"getSubtractionQuestions");
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"QuickTouchMathQuestions"] ofType:@"plist"];
	NSDictionary *allQuestionsDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
	return [allQuestionsDict valueForKey:@"sub"];
}

+(NSArray *) getMultiplicationQuestions
{
	NSLog(@"getMultiplicationQuestions");
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"QuickTouchMathQuestions"] ofType:@"plist"];
	NSDictionary *allQuestionsDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
	return [allQuestionsDict valueForKey:@"mul"];
}

+(NSArray *) getDivisionQuestions
{
	NSLog(@"getDivisionQuestions");
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"QuickTouchMathQuestions"] ofType:@"plist"];
	NSDictionary *allQuestionsDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
	return [allQuestionsDict valueForKey:@"div"];
}

+(NSArray *) getQuestionsFromType:(NSString *)type
{
	if (type == @"ADD") {
		return [self getAdditionQuestions];
	}else if (type == @"SUB") {
		return [self getSubtractionQuestions];
	}else if (type == @"MUL") {
		return [self getMultiplicationQuestions];
	}else if (type == @"DIV") {
		return [self getDivisionQuestions];
	}else{
		return [self getAdditionQuestions];
	}

}

@end
