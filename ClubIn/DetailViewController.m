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

//View did load.
-(void) viewDidLoad {
    
    [self initilizeClubData];
}

//based on the club name selected on the table view, retrieve specific club data.
- (void) initilizeClubData {
    
    //initiate NSUserDefaults, store in defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //load NSUserDefaults, into relevent arrays, by keys.
    listOfClubNames = [defaults objectForKey:@"clubName"];
    NSString *clubName = selectedClubName;
    NSLog(@"club name %@", clubName);
    
    //return the index of the selectedClubId within userDefaults
    NSUInteger index = [listOfClubNames indexOfObject:clubName];
    
    //store the club data in strings, retrieved via the index within the defaults array.
    selectedClubId = [[defaults objectForKey:@"clubId"] objectAtIndex:index]; 
    selectedClubName = [[defaults objectForKey:@"clubName"] objectAtIndex:index];
    selectedClubAddress = [[defaults objectForKey:@"clubAddresses"] objectAtIndex:index];
    selectedClubLatitude = [[defaults objectForKey:@"clubLatitudes"] objectAtIndex:index];
    selectedClubLongitude = [[defaults objectForKey:@"clubLongitudes"] objectAtIndex:index];
    
}

//initiate view programmatically.
- (void) loadView {
    
    //create a view.
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen
                                                  mainScreen].applicationFrame];
    
    //set background image.
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default.png"]];
    
    self.title = @"Club Details";
    
    //set self view as view.
    self.view = view;
    
    //release view.
    [view release];
    
    //allocate headerBar at top of view.
    headBar = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 50.0)];
    headBar.image=[UIImage imageNamed:@"headerBar.png"];
    
    //add headerView to subview.
    [view addSubview:headBar];
    
    //allocate club label.
    lblClubLabel = [[UILabel alloc]
                    initWithFrame:CGRectMake(0, 2.5, 320.0, 40.0)];
    lblClubLabel.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    lblClubLabel.textAlignment = UITextAlignmentCenter;
    lblClubLabel.textColor = [UIColor whiteColor];
    lblClubLabel.backgroundColor = [UIColor clearColor];
    //set text as selected club.
    lblClubLabel.text = selectedClubName;
    //add lblClubLabel to headbar subview.
    [headBar addSubview:lblClubLabel];
   
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
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
