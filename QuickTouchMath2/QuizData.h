//
//  QuizData.h
//  MathQuiz
//
//  Created by Brian Rogers on 1/16/11.
//  Copyright 2011 CreatureTeachers. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QuizData : NSObject {
	
}

+(NSArray *)getAdditionQuestions;
+(NSArray *) getAdditionQuestionsEasyLevel;
+(NSArray *)getSubtractionQuestions;
+(NSArray *)getMultiplicationQuestions;
+(NSArray *)getDivisionQuestions;

+(NSArray *)getQuestionsFromType:(NSString *)type;
@end
