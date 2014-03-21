//
//  Score.h
//  QuickTouchMath2
//
//  Created by Brian Rogers on 3/20/14.
//  Copyright (c) 2014 Brian Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Score : NSManagedObject

@property (nonatomic, retain) NSString * mode;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) User *user;

@end
