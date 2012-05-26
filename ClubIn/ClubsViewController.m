//
//  ClubsViewController.m
//  ClubIn
//
//  Created by Cameron Bradley on 26/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ClubsViewController.h"
#import "AppDelegate.h"

@implementation ClubsViewController

//generate getters and setters.
@synthesize menuTableView;
@synthesize mainMenuItems;
@synthesize listOfClubIds;
@synthesize listOfClubNames;
@synthesize listOfClubAddresses;
@synthesize listOfClubLongitudes;
@synthesize listOfClubLatitudes;

//release
- (void)dealloc
{
    [listOfClubIds release];
    [listOfClubNames release];
    [listOfClubAddresses release];
    [listOfClubLongitudes release];
    [listOfClubLatitudes release];
    [xmlParser release];
    [menuTableView release];
    [mainMenuItems release];
    [super dealloc];
}

//view loaded
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set the navigation bar item.
    self.navigationItem.title = @"Night Clubs";
    
    //create a button on the top bar to navigate to the map (for all clubs)
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] 
                                  initWithTitle:@"Map"                                            
                                  style:UIBarButtonItemStyleBordered 
                                  target:self 
                                  action:@selector(loadNearbyClubsView)];
    self.navigationItem.rightBarButtonItem = mapButton;
    //release mapButton
    [mapButton release]; 
    
    //load clubing related data into arrays, determine if stored or getting XML is required.
    [self loadClubData];   
}

//method to load the club data.
//if NSUserDefaults is filled - load from NSUserDefaults, otherwise get from XML
-(void) loadClubData {
    
    //initiate NSUserDefaults, store in defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [defaults objectForKey:@"clubName"];
    
    //store xmlParser XML output into relevent NSMutableArrays
    listOfClubIds = [[NSMutableArray alloc] init];
    listOfClubNames = [[NSMutableArray alloc] init];
    listOfClubAddresses = [[NSMutableArray alloc] init];
    listOfClubLatitudes = [[NSMutableArray alloc] init];
    listOfClubLongitudes = [[NSMutableArray alloc] init];
    
    //if data exists in NSUserDefaults
    if (dataRepresentingSavedArray != nil) {
        
        NSLog(@"NSUserDefaults loaded");
        
        //load NSUserDefaults, into relevent arrays, by keys.
        listOfClubIds = [defaults objectForKey:@"clubId"];
        listOfClubNames = [defaults objectForKey:@"clubName"];
        listOfClubAddresses = [defaults objectForKey:@"clubAddresses"];
        listOfClubLatitudes = [defaults objectForKey:@"clubLatitudes"];
        listOfClubLongitudes = [defaults objectForKey:@"clubLongitudes"];
        
        //if no data exists in NSUserDefaults    
    } else if (dataRepresentingSavedArray == nil) {   
        
        NSLog(@"NSUserDefaults dont exist, load data via XML");
        
        //send URL to xmlParser
        xmlParser = [[XMLParser alloc] loadXMLByURL:@"http://www.complr.com/ClubIn/includes/xml/clubs.php"];
        
        //integer for while loop = 0
        int i = 0;
        
        //count number of clubs from the XMLParser
        int count = [[xmlParser clubs ] count];
        
        //do while (number of clubs)
        do {
            
            //assign xml to each array
            clubDetailsInterface *currentClub = [[xmlParser clubs] objectAtIndex:i];
            
            //store relevent xml data into specific array lists
            [listOfClubIds addObject:[currentClub clubId]];
            [listOfClubNames addObject:[currentClub clubName]];
            [listOfClubAddresses addObject:[currentClub clubAddress]];
            [listOfClubLatitudes addObject:[currentClub clubLatitude]];
            [listOfClubLongitudes addObject:[currentClub clubLongitude]];
            
            //store arrayList in NSUserDefaults (for data persistance) accessible via key.
            [defaults setObject:listOfClubIds forKey:@"clubId"];
            [defaults setObject:listOfClubNames forKey:@"clubName"];
            [defaults setObject:listOfClubAddresses forKey:@"clubAddresses"];
            [defaults setObject:listOfClubLatitudes forKey:@"clubLatitudes"];
            [defaults setObject:listOfClubLongitudes forKey:@"clubLongitudes"];
            
            //+add 1 to the counter
            i++;
            
        } while (i < count);
        
        //sync defaults
        [defaults synchronize];
        
        NSLog(@"NSUserDefaults set data as it does not exist.");
    }      
}

//load map containing all the annotiations of club locations
-(void) loadNearbyClubsView {
    
    //Initialize the detail view controller and display it.
	NearbyClubsViewController *nbController = [[NearbyClubsViewController alloc] init];
    
    nbController.selectedClubId = listOfClubIds;
    nbController.selectedClubName = listOfClubNames;   
    nbController.selectedClubAddress = listOfClubAddresses;
    nbController.selectedClubLatitude = listOfClubLatitudes;
    nbController.selectedClubLongitude = listOfClubLongitudes;
    
    //push the details view controller.
	[self.navigationController pushViewController:nbController animated:YES];
    
    //release details view controller.
    [nbController release];
	nbController = nil;      
    
}

- (void)refresh {
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
}

- (void)addItem {
    NSLog(@"Pull down refresh added");
    
    [self.tableView reloadData];
    
    [self stopLoading];}

@end

