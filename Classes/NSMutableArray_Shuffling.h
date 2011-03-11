//
//  NSMutableArray_Shuffling.h
//  MathQuiz
//
//  Created by Brian Rogers on 11/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#include <Cocoa/Cocoa.h>
#endif

// This category enhances NSMutableArray by providing
// methods to randomly shuffle the elements.
@interface NSMutableArray (Shuffling)
- (void)shuffle;
@end
