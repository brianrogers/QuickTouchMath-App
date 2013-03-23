//
//  AppConfig.m
//  MathQuiz
//
//  Created by Brian Rogers on 1/15/11.
//  Copyright 2011 CreatureTeachers. All rights reserved.
//

#import "AppConfig.h"


@implementation AppConfig

@synthesize appConfigDict;

+(NSDictionary *) getCurrentConfig
{
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *finalPath = [path stringByAppendingPathComponent:@"config.plist"];
	NSDictionary *plistData = [[[NSDictionary dictionaryWithContentsOfFile:finalPath] retain] autorelease];
	return plistData;
}

@end
