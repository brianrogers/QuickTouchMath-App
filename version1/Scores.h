//
//  Scores.h
//  MathQuiz
//
//  Created by Brian Rogers on 12/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Users;

@interface Scores :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * mode;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) Users * User;

@end



