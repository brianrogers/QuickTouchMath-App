//
//  ViewFactory.h
//  MathQuiz
//
//  Created by Brian Rogers on 12/20/10.
//  Copyright 2010 CreatureTeachers. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ViewFactory : NSObject {
    NSMutableDictionary * viewTemplateStore;
}

- (id) initWithNib: (NSString*)aNibName;

- (UITableViewCell*)cellOfKind: (NSString*)theCellKind forTable: (UITableView*)aTableView;

@end

