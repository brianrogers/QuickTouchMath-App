//
//  User.h
//  QuickTouchMath2
//
//  Created by Brian Rogers on 3/20/14.
//  Copyright (c) 2014 Brian Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Score.h"


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * updated;
@property (nonatomic, retain) Score *score;

@end
