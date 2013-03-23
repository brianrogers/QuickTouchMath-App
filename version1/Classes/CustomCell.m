//
//  CustomCell.m
//  MathQuiz
//
//  Created by Brian Rogers on 12/20/10.
//  Copyright 2010 CreatureTeachers. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize cellTitle;

-(id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString*)reuseIdentifier 
{
	if(self =[super initWithFrame:frame reuseIdentifier:reuseIdentifier])
	{
		// Cells are transparent
		[self.contentView setBackgroundColor:[UIColor clearColor]];
	}
	return self;
}




/*---------------------------------------------------------------------------
 * 
 *--------------------------------------------------------------------------*/
-(void) setTheImage:(UIImage *) icon
{
	// Alloc and set the frame
	image =[[UIImageView alloc] initWithImage:icon];
	image.frame = CGRectMake(0, 0, 286, 68);
	
	// Add subview
	[self.contentView addSubview:image];    
}

/*---------------------------------------------------------------------------
 *
 *--------------------------------------------------------------------------*/
-(void)setSelected:(BOOL)selected animated:(BOOL)animated 
{
	[super setSelected:selected animated:animated];   
	if(selected ==YES)
		image.alpha = .5;
	else
		image.alpha =1;
}

/*---------------------------------------------------------------------------
 * 
 *--------------------------------------------------------------------------*/
-(void)dealloc 
{
	[image release];
	[super dealloc];
}

@end
