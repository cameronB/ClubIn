//
//  DetailViewController.m
//  ClubIn
//
//  Created by Cameron Bradley on 26/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

//generate getters and setters for selected club.
@synthesize selectedClubId;
@synthesize selectedClubName;
@synthesize selectedClubLongitude;
@synthesize selectedClubLatitude;
@synthesize selectedClubAddress;
@synthesize listOfClubNames;

- (void)dealloc {
    [selectedClubAddress release];
    [selectedClubLatitude release];
    [selectedClubLongitude release];
    [selectedClubName release];
    [selectedClubId release];
    [super dealloc];
}

//view did load
-(void) viewDidLoad {
    
    //button for top of navigation bar.
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] 
                                  initWithTitle:@"Map"                                            
                                  style:UIBarButtonItemStyleBordered 
                                  target:self 
                                  action:@selector(loadClubMap:)];
    //add to navigation right bar button item.
    self.navigationItem.rightBarButtonItem = mapButton;
    
    //release mapButton.
    [mapButton release];  
}

//called when map button is selected on detailsView.
- (void)loadClubMap:(id)sender {
   
    //Initialize the detail view controller and display it.
	ClubMapViewController *cmController = [[ClubMapViewController alloc] init];
    
    //pass the club name to the Map View that will display a certain club.
    cmController.selectedClubId = selectedClubId;
    cmController.selectedClubName = selectedClubName;
    cmController.selectedClubAddress = selectedClubAddress;
    cmController.selectedClubLatitude = selectedClubLatitude;
    cmController.selectedClubLongitude = selectedClubLongitude;
    
    //push the details view controller.
	[self.navigationController pushViewController:cmController animated:YES];
    
    //release particular club map view controller.
    [cmController release];
	cmController = nil;  
}

//initiate view programmatically.
- (void) loadView {
    
    //create a view.
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen
                                                  mainScreen].applicationFrame];
    
    //set background image.
    view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Club Details";
    
    //set self view as view.
    self.view = view;
    
    //release view.
    [view release];
    
    //allocate club label.
    lblClubLabel = [[UILabel alloc]
                    initWithFrame:CGRectMake(0, 2.5, 320.0, 40.0)];
    lblClubLabel.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    lblClubLabel.textAlignment = UITextAlignmentCenter;
    lblClubLabel.textColor = [UIColor blueColor];
    lblClubLabel.backgroundColor = [UIColor clearColor];
    //set text as selected club.
    lblClubLabel.text = selectedClubName;
    //add lblClubLabel to headbar subview.
    [view addSubview:lblClubLabel];
   
    //create button to allow user to signal he/she wishes to head to a particular club.
    btnHeadingHere = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnHeadingHere addTarget:self
                       action:@selector(headingHere)
             forControlEvents:UIControlEventTouchUpInside];
    
    [btnHeadingHere setTitle:@"Heading Here" forState:UIControlStateNormal];
    btnHeadingHere.frame = CGRectMake(90.0, 80.0, 140.0, 35.0);
    //add btnHeadingHere to the view subview.
    [view addSubview:btnHeadingHere];      
    
}

//method to handle signalling that a user will be heading to a particular club.
-(void)headingHere {
    
    NSLog(@"Heading Here Button Clicked");
    HeadingHereViewController *headingHereViewController = [[HeadingHereViewController alloc] init];
    
    headingHereViewController.viewClubName = selectedClubName;
    
    [self.navigationController presentModalViewController:headingHereViewController animated:YES];
    
    //release details view controller
    [headingHereViewController release];
	headingHereViewController = nil;      
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
