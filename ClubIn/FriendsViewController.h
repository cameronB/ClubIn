//
//  FriendsViewController.h
//  ClubIn
//
//  Created by Cameron Bradley on 11/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "AppDelegate.h"
#import "PullRefreshTableViewController.h"

@interface FriendsViewController : UIViewController <FBSessionDelegate, FBDialogDelegate, FBRequestDelegate, UITableViewDataSource, UITableViewDelegate> {
    
    //array to store the API graph results for me/friends.
    NSArray *items;
    
    //store facebook friends Id in NSMutableArrays
    NSMutableArray *friendIds;
    NSMutableArray *friendNames;
    
    //UIElements for..
    UILabel *loadingLabel;
    UITableView *menuTableView;
    UIActivityIndicatorView *activityIndicator;    
}

@property (nonatomic, retain) NSArray *items;
@property (nonatomic, retain) NSMutableArray *friendIds;
@property (nonatomic, retain) NSMutableArray *friendNames;
@property (nonatomic, retain) UILabel *loadingLabel;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) UITableView *menuTableView;

@end
