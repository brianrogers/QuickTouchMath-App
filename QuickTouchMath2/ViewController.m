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
    //[_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"UserCell"];

    if (cell == nil) {
        
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UserCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    User *item = (User *)[self.users objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;

    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    User *user = (User *)[self.users objectAtIndex:indexPath.row];
//    appDelegate.currentUser = user;
//    NSLog(@"%@", appDelegate.currentUser.name);
//    
//}

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

- (void)configureCell:(UITableViewCell*)cell atIndex:(NSIndexPath*)indexPath {
    // Get current User
    User *user = self.users[indexPath.row];
    cell.textLabel.text = user.name;
    // Setup AMRatingControl
    //AMRatingControl *ratingControl;
    if (![cell viewWithTag:20]) {
        //ratingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(190, 10) emptyImage:[UIImage imageNamed:@"beermug-empty"] solidImage:[UIImage imageNamed:@"beermug-full"] andMaxRating:5];
        //ratingControl.tag = 20;
        //ratingControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        //ratingControl.userInteractionEnabled = NO;
        //[cell addSubview:ratingControl];
    } else {
        //ratingControl = (AMRatingControl*)[cell viewWithTag:20];
    }
    // Put beer rating in cell
    //ratingControl.rating = [beer.beerDetails.rating integerValue];
}

- (void)fetchAllUsers {
    // 1. Get the sort key
    //NSString *sortKey = [[NSUserDefaults standardUserDefaults] objectForKey:WB_SORT_KEY];
    // 2. Determine if it is ascending
    //BOOL ascending = [sortKey isEqualToString:SORT_KEY_RATING] ? NO : YES;
    // 3. Fetch entities with MagicalRecord
    self.users = [User findAll];
    NSLog(@"%@",self.users);
    if (self.users.count < 1) {
        User *newUser = [User createEntity];
        newUser.name = @"Brian";
        
        [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            if (success) {
                NSLog(@"You successfully saved your context.");
            } else if (error) {
                NSLog(@"Error saving context: %@", error.description);
            }
        }];
        
        Score *addScore = [Score createEntity];
        addScore.user = newUser;
        addScore.mode = @"ADD";
        addScore.score = [NSNumber numberWithInt:0];
        
        Score *subScore = [Score createEntity];
        subScore.user = newUser;
        subScore.mode = @"SUB";
        subScore.score = [NSNumber numberWithInt:0];
        
        Score *mulScore = [Score createEntity];
        mulScore.user = newUser;
        mulScore.mode = @"MUL";
        mulScore.score = [NSNumber numberWithInt:0];
        
        Score *divScore = [Score createEntity];
        divScore.user = newUser;
        divScore.mode = @"DIV";
        divScore.score = [NSNumber numberWithInt:0];
        
        [self fetchAllUsers];
    }
    NSArray *allScores = [Score findAll];
    
    NSLog(@"%@", allScores);
}
@end



