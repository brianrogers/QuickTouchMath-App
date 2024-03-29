//
//  ViewFactory.m
//  MathQuiz
//
//  Created by Brian Rogers on 12/20/10.
//  Copyright 2010 CreatureTeachers. All rights reserved.
//

#import "ViewFactory.h"

@implementation ViewFactory

- (id) initWithNib: (NSString*)aNibName
{
    if (self == [super init]) {
        viewTemplateStore = [[NSMutableDictionary alloc] init];
        NSArray * templates = [[NSBundle mainBundle] loadNibNamed:aNibName owner:self options:nil];
        for (id template in templates) {
            if ([template isKindOfClass:[UITableViewCell class]]) {
                UITableViewCell * cellTemplate = (UITableViewCell *)template;
                NSString * key = cellTemplate.reuseIdentifier;
				NSLog(@"key:%@",key);
                if (key) {
                    [viewTemplateStore setObject:[NSKeyedArchiver
                                                  archivedDataWithRootObject:template]
                                          forKey:key];
                } else {
                    @throw [NSException exceptionWithName:@"Unknown cell"
                                                   reason:@"Cell has no reuseIdentifier"
                                                 userInfo:nil];
                }
            }
        }
    }
	
    return self;
}

- (void) dealloc
{
    [viewTemplateStore release];
    [super dealloc];
}

- (UITableViewCell*)cellOfKind: (NSString*)theCellKind forTable: (UITableView*)aTableView
{
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:theCellKind];
	
    if (!cell) {
        NSData * cellData = [viewTemplateStore objectForKey:theCellKind];
        if (cellData) {
            cell = [NSKeyedUnarchiver unarchiveObjectWithData:cellData];
        } else {
            NSLog(@"Don't know nothing about cell of kind %@", theCellKind);
        }
    }
	
    return cell;
}

@end

