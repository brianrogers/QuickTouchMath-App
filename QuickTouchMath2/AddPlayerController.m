//
//  AddPlayerController.m
//  QuickTouchMath2
//
//  Created by Brian Rogers on 3/21/14.
//  Copyright (c) 2014 Brian Rogers. All rights reserved.
//

#import "AddPlayerController.h"

@interface AddPlayerController ()

@end

@implementation AddPlayerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)savePlayer:(id)sender {
    NSLog(@"Creating new user : %@", self.playerName.text);
    User *newUser = [User createEntity];
    newUser.name = self.playerName.text;
    
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
