//
//  Users.h
//  MathQuiz
//
//  Created by Brian Rogers on 12/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Scores;

@interface Users :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* Scores;

@end


@interface Users (CoreDataGeneratedAccessors)
- (void)addScoresObject:(Scores *)value;
- (void)removeScoresObject:(Scores *)value;
- (void)addScores:(NSSet *)value;
- (void)removeScores:(NSSet *)value;

@end

