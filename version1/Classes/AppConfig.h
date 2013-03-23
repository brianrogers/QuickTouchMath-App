//
//  AppConfig.h
//  MathQuiz
//
//  Created by Brian Rogers on 1/15/11.
//  Copyright 2011 CreatureTeachers. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppConfig : NSObject {

	NSDictionary *appConfigDict;
	
}

@property (nonatomic, retain) NSDictionary *appConfigDict;

+(NSDictionary *) getCurrentConfig;

@end
