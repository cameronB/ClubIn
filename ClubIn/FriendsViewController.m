//
//  FriendsViewController.m
//  ClubIn
//
//  Created by Cameron Bradley on 11/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendsViewController.h"

@implementation FriendsViewController

@synthesize friendIds;
@synthesize friendNames;
@synthesize items;
@synthesize loadingLabel;
@synthesize activityIndicator;
@synthesize menuTableView;

-(void)dealloc {
    [friendIds release];
    [friendNames release];
    [items release];
    [loadingLabel release];
    [activityIndicator release];
    [menuTableView release];
    [super dealloc];
}

//initilize view programmatically
- (void) loadView {
    
    //allocate view
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen
                                                  mainScreen].applicationFrame];
    
    //add background default_bg image to view
    view.backgroundColor = [UIColor whiteColor];
    
    self.view = view;
    [view release];
    
    //allocate Table View to view and hide it on load.
    menuTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                 style:UITableViewStylePlain];
    [menuTableView setBackgroundColor:[UIColor whiteColor]];
    menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    menuTableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    menuTableView.dataSource = self;
    menuTableView.delegate = self;
    menuTableView.hidden = YES;
    [self.view addSubview:menuTableView];
    
    // loading label display on load
    loadingLabel = [[UILabel alloc]
                    initWithFrame:CGRectMake(7.0, 2.5, 85.0, 40.0)];
    loadingLabel.textAlignment = UITextAlignmentCenter;
    loadingLabel.textColor = [UIColor blueColor];
    loadingLabel.backgroundColor = [UIColor clearColor];
    //set text as selected club.
    loadingLabel.text = @"Loading....";
    //add lblClubLabel to headbar subview.
    [self.view addSubview:loadingLabel];
    
    // Activity Indicator display on load.
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(92.0, 3.5, 30, 30)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    //add activity indicator to subview
    [self.view addSubview:activityIndicator];
    //call method to show the activity indicator on load.
    [self showActivityIndicator];
}

-(void)viewDidLoad {

    //set the navigation bar item title.
    self.navigationItem.title = @"Friends";
    
    //graph the logged in users friends.
    [self apiGraphFriends];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

//This method hides the table view (for showing loading)
- (void)showLoadingView {
    
    //hide the UITableView.
    menuTableView.hidden = YES;
    
    //show the loading label.
    loadingLabel.hidden = NO;
    
    //show the activity indicator.
    [self showActivityIndicator];
    
    //reload the table view.
    [self.menuTableView reloadData];
    
}

//This method shows the table view (when data is loaded)
- (void)hideLoadingView {
    
    //show the UITableView
    menuTableView.hidden = NO;
    
    //hide the loading label.
    loadingLabel.hidden = YES;
    
    //hide the activity indicator.
    [self hideActivityIndicator];
    
    //reload the table view.
    [self.menuTableView reloadData];
}

//This method shows the activity indicator
- (void)showActivityIndicator {
    if (![activityIndicator isAnimating]) {
        [activityIndicator startAnimating];
    }
}

//This method hides the activity indicator
- (void)hideActivityIndicator {
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
    
}

#pragma mark - Facebook API Calls
/*
 * Graph API: Method to get the user's friends.
 */
- (void)apiGraphFriends {
    NSLog(@"Graph user friends");
    // Do not set current API as this is commonly called by other methods
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me/friends" andDelegate:self];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    /*https://graph.facebook.com/me/friends?limit=5000&offset=0&format=json&access_token=BAADAMvDi7X0BAK2SErYztSTsvKjuQqMkWbdk364Xib4WNPAZAJceZCwIoeMM6ZCZAwQNnEpszCokHsStJKtlpO56jULLoyFAcBrn4zvQi1iaIdF4YZBtxIcjEmx6jyKoZD*/

    //allocate NSMutableArrays
    friendIds = [[NSMutableArray alloc] init];
    friendNames = [[NSMutableArray alloc] init];
    
    items = [[(NSDictionary *)result objectForKey:@"data"]retain];
    for (int i=0; i<[items count]; i++) {
        NSDictionary *friend = [items objectAtIndex:i];
        [friendIds addObject:[friend objectForKey:@"id"]];
        [friendNames addObject:[friend objectForKey:@"name"]];
    }

    //hide the activity indicator
    [self hideLoadingView];    
}

//adjust height for table cell.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //height of cell
    return 80.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [friendIds count];
}

//table view cell styles.
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //set the background image for the cell.
    cell.backgroundColor = [UIColor whiteColor];
    
    //textLabel styles.
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.textLabel.textColor = [UIColor blueColor];
    
    //detailTextLabel styles.
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10.0];
    cell.detailTextLabel.textColor = [UIColor blueColor];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"] autorelease];
        //set Selection style (when button is pressed).
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //set the accessory type (the button on the cell) to none.
        cell.accessoryType = UITableViewCellSelectionStyleNone;
        
    }
    
    //set the textLabel as the clubName.
    cell.textLabel.text =  [friendNames objectAtIndex:indexPath.row];
    
    return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //only allow portrait orientation.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
