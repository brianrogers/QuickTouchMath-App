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

+(NSArray *) getAdditionQuestionsEasyLevel
{
    NSArray *includeList = @[@"0",@"1",@"2",@"3"];
    NSArray *allQuestions = [[self getAdditionQuestions] copy];
    NSMutableArray *questionsToReturn = [[NSMutableArray alloc] init];
    
    for (NSArray *item in allQuestions) {
        for (NSString *num in includeList) {
            if ([[item objectAtIndex:0] hasPrefix:[NSString stringWithFormat:@"%@+",num]] || [[item objectAtIndex:0] hasSuffix:[NSString stringWithFormat:@"+%@",num]]) {
                NSLog(@"%@", [item objectAtIndex:0]);
                [questionsToReturn addObject:item];
            }
        }
        
    }
    return [questionsToReturn copy];
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
	if ([type isEqualToString:@"ADD"]) {
		return [self getAdditionQuestions];
	}else if ([type isEqualToString:@"SUB"]) {
		return [self getSubtractionQuestions];
	}else if ([type isEqualToString:@"MUL"]) {
		return [self getMultiplicationQuestions];
	}else if ([type isEqualToString:@"DIV"]) {
		return [self getDivisionQuestions];
	}else{
		return [self getAdditionQuestions];
	}

}

@end
