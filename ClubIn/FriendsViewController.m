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
@synthesize friendInstalled;
@synthesize friendPicture;
@synthesize items;
@synthesize friendUsesApp;
@synthesize loadingLabel;
@synthesize menuTableView;
@synthesize activityIndicator;
@synthesize loadingTabBar;
@synthesize friendsTabBar;
@synthesize friendsUsingTabBarItem;
@synthesize friendsNotUsingTabBarItem;

-(void)dealloc {
    [friendIds release];
    [friendNames release];
    [friendInstalled release];
    [friendPicture release];
    [items release];
    [loadingLabel release];
    [menuTableView release];
    [activityIndicator release];
    [loadingTabBar release];
    [friendsTabBar release];
    [friendsUsingTabBarItem release];
    [friendsNotUsingTabBarItem release];
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
    
    //loadingt tab bar while table view is reloading (prob not best way to do this lol)
    loadingTabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 47.0)];
    loadingTabBar.hidden = NO;
    [self.view addSubview:loadingTabBar];
    
    //create top tab bar that will display friends items for table view data.
    friendsTabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 47.0)];
    friendsTabBar.delegate = self;
    friendsTabBar.hidden = YES;
    [self.view addSubview:friendsTabBar];
    
    //add tab bar items to tab bar
    friendsUsingTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Invite Out" image:[UIImage imageNamed:@"24_info.png"] tag:0];
    friendsNotUsingTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Invite to ClubIn"  image:[UIImage imageNamed:@"24_info.png"] tag:1];
    NSArray *arrTabbarItems = [NSArray arrayWithObjects:friendsUsingTabBarItem,friendsNotUsingTabBarItem, nil];
    [friendsTabBar setItems:arrTabbarItems];
    
    //set the default for tab bar items
    [friendsTabBar setSelectedItem:[friendsTabBar.items objectAtIndex:0]];
    
    //allocate Table View to view and hide it on load.
    CGFloat xLoginButtonOffset = self.view.bounds.size.width;
    CGFloat yLoginButtonOffset = self.view.bounds.size.height;
    
    menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 47.0, yLoginButtonOffset, xLoginButtonOffset)
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
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.backgroundColor = [UIColor clearColor];
    //set text as selected club.
    loadingLabel.text = @"Loading....";
    //add lblClubLabel to headbar subview.
    [self.view addSubview:loadingLabel];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    if (item.tag == 0) {
        [self displayFriendsUsingClubIn];
    } else if (item.tag == 1) {
        [self displayFriendsNotUsingClubIn];
    }
    
}

- (void)displayFriendsUsingClubIn {
    NSLog(@"Friends using clubin");
    
    //For now reloading and regraphing friends each time view is loaded.
    [self showLoadingView];
    
    friendUsesApp = TRUE;
    
    //graph facebook friends of logged in user
    [self apiGraphFriends];    
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

- (void)displayFriendsNotUsingClubIn {
    NSLog(@"Friends not using ClubIn");
    
    //For now reloading and regraphing friends each time view is loaded.
    [self showLoadingView];
    
    friendUsesApp = FALSE;
    
    //graph facebook friends of logged in user
    [self apiGraphFriends];
    
}

-(void)viewDidLoad {
    
    //set the navigation bar item title.
    self.navigationItem.title = @"Friends";
    
    //allocate indicator
    activityIndicator = [[UIActivityIndicatorView alloc] 
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    
    //create a button on the top bar to navigate to the map (for all clubs)
    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] 
                                     initWithCustomView:activityIndicator];
    self.navigationItem.rightBarButtonItem = reloadButton;
    

    //release mapButton
    [reloadButton release]; 
    
    //show the activity indicator on load
    [self showActivityIndicator];
    
    //graph facebook friends of logged in user
    [self apiGraphFriends];
    
}

//method to refresh friends
-(void)refreshFriends {

    //For now reloading and regraphing friends each time view is loaded.
    [self showLoadingView];
    
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
    
    [self showActivityIndicator];
    
    //show the loading tabbar
    loadingTabBar.hidden = NO;
    
    //hide the top tabbar.
    friendsTabBar.hidden = YES;
    
    //show the loading label.
    loadingLabel.hidden = NO;
    
    //reload the table view.
    [self.menuTableView reloadData];
    
}

//This method shows the table view (when data is loaded)
- (void)hideLoadingView {
    
    //show the UITableView
    menuTableView.hidden = NO;
    
    [self hideActivityIndicator];
    
    //hide loading tab bar
    loadingTabBar.hidden = YES;
    
    //show the top tab bar
    friendsTabBar.hidden = NO;
    
    //hide the loading label.
    loadingLabel.hidden = YES;
    
    //reload the table view.
    [self.menuTableView reloadData];
}

#pragma mark - Facebook API Calls
/*
 * Graph API: Method to get the user's friends.
 */
- (void)apiGraphFriends {
    NSLog(@"Graph user friends");
    // Do not set current API as this is commonly called by other methods
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me/friends?fields=installed,name,picture" andDelegate:self];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    NSLog(@"%d", friendUsesApp);
    
    //allocate NSMutableArrays
    friendIds = [[NSMutableArray alloc] init];
    friendNames = [[NSMutableArray alloc] init];
    friendInstalled = [[NSMutableArray alloc] init];
    friendPicture = [[NSMutableArray alloc] init];
    
    items = [[(NSDictionary *)result objectForKey:@"data"]retain];
    for (int i=0; i<[items count]; i++) {
        NSDictionary *friend = [items objectAtIndex:i];
        [friendIds addObject:[friend objectForKey:@"id"]];
        [friendNames addObject:[friend objectForKey:@"name"]];
        //check if installed is nil
        if ([friend objectForKey:@"installed"] != nil) {
            //add object 'installed' to NSMutableArray.
            [friendInstalled addObject:[friend objectForKey:@"installed"]];
        }
        [friendPicture addObject:[friend objectForKey:@"picture"]];
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
    
    //Create image object / url of image got from me/friends facebook API.
    UIImage *friendImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[friendPicture objectAtIndex:indexPath.row]]]];

    //set the imageView as the image
    cell.imageView.image = friendImage;
    
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
