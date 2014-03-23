//
//  PlayerCell.h
//  QuickTouchMath2
//
//  Created by Brian Rogers on 3/21/14.
//  Copyright (c) 2014 Brian Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *playerName;
@property (strong, nonatomic) IBOutlet UILabel *addScore;
@property (strong, nonatomic) IBOutlet UILabel *subScore;
@property (strong, nonatomic) IBOutlet UILabel *mulScore;
@property (strong, nonatomic) IBOutlet UILabel *divScore;


@end
