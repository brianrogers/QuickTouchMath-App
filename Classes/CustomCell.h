//
//  CustomCell.h
//  MathQuiz
//
//  Created by Brian Rogers on 12/20/10.
//  Copyright 2010 CreatureTeachers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell {

	UIImageView *image; 
	NSString *cellTitle;
}

@property(nonatomic,copy)NSString *cellTitle;

-(void) setTheImage:(UIImage *)icon;


@end
