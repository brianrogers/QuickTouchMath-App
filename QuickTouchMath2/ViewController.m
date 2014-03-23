//
//  ViewController.m
//  QuickTouchMath2
//
//  Created by Brian Rogers on 2/10/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self fetchAllUsers];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView reloadData];
    
    self.title = @"Quick Touch Math";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor yellowColor]};
    self.navigationController.navigationBar.tintColor = [UIColor yellowColor];
    //self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self fetchAllUsers];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        NSLog(@"delete row : %ld", (long)indexPath.row);
        NSLog(@"delete user %@",[[self.users objectAtIndex:indexPath.row] valueForKey:@"name"]);
        
        User *userToDelete = [self.users objectAtIndex:indexPath.row];
        [userToDelete deleteEntity];
        NSArray *allScores = [Score findAll];
        
        for (Score *s in allScores) {
            if([s.user.name isEqualToString:userToDelete.name]) {
                [s deleteEntity];
            }
        }
        
        [self saveContext];
        
        [self fetchAllUsers];
        [_tableView reloadData];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlayerCell *cell = [tableview dequeueReusableCellWithIdentifier:@"PlayerCell"];

    if (cell == nil) {
        cell = [[PlayerCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PlayerCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    User *item = (User *)[self.users objectAtIndex:indexPath.row];
    //cell.textLabel.text = item.name;
    [cell.playerName setText:item.name];
    
    NSArray *allScores = [Score findAll];
    
    for (Score *s in allScores) {
        if([s.user.name isEqualToString:item.name]) {
            if ([s.mode isEqual:@"ADD"] )
			{
				[cell.addScore setText:[NSString stringWithFormat:@"%@",s.score]];
			}
			if ([s.mode isEqual:@"SUB"] )
			{
                [cell.subScore setText:[NSString stringWithFormat:@"%@",s.score]];
			}
			if ([s.mode isEqual:@"MUL"] )
			{
				[cell.mulScore setText:[NSString stringWithFormat:@"%@",s.score]];
			}
			if ([s.mode isEqual:@"DIV"] )
			{
				[cell.divScore setText:[NSString stringWithFormat:@"%@",s.score]];
			}
        }
    }
    
    return cell;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%@", segue.identifier);
    if ([segue.identifier isEqualToString:@"selectUser"]) {
        User *user = (User *)[self.users objectAtIndex:[_tableView indexPathForCell:sender].row];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.currentUser = user;
        NSLog(@"%@", appDelegate.currentUser.name);
    }
}


- (void)fetchAllUsers {
    
    self.users = [User findAll];
    NSLog(@"%@",self.users);
    if (self.users.count < 1) {
        
    }
    NSArray *allScores = [Score findAll];
    
    NSLog(@"%@", allScores);
}

- (void)saveContext {
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}

@end



