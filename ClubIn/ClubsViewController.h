//
//  ClubsViewController.h
//  ClubIn
//
//  Created by Cameron Bradley on 26/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import "PullRefreshTableViewController.h"
#import "XMLParser.h"
#import "NearbyClubsViewController.h"

@interface ClubsViewController : PullRefreshTableViewController {
 
    //xmlParser
    XMLParser *xmlParser;
    
    //declare club details into specific arrays.
    NSMutableArray *listOfClubIds;
    NSMutableArray *listOfClubNames;
    NSMutableArray *listOfClubAddresses;
    NSMutableArray *listOfClubLatitudes;
    NSMutableArray *listOfClubLongitudes;
    
    //The table view to hold each club 
    UITableView *menuTableView;
    
    //Array to contain the menu items.
    NSMutableArray *mainMenuItems;      
}

//generate accesors for menuTableView
@property (readonly, retain) NSMutableArray *listOfClubIds;
@property (readonly, retain) NSMutableArray	*listOfClubNames;
@property (readonly, retain) NSMutableArray	*listOfClubAddresses;
@property (readonly, retain) NSMutableArray *listOfClubLatitudes;
@property (readonly, retain) NSMutableArray	*listOfClubLongitudes;
@property (nonatomic, retain) UITableView *menuTableView;
@property (nonatomic, retain) NSMutableArray *mainMenuItems;

@end
