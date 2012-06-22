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

@interface FriendsViewController : UIViewController <FBRequestDelegate, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate> {
    
    //array to store the API graph results for me/friends.
    NSArray *items;
    BOOL friendUsesApp;
    
    //store facebook friends Id in NSMutableArrays
    NSMutableArray *friendIds;
    NSMutableArray *friendNames;
    NSMutableArray *friendInstalled;
    NSMutableArray *friendPicture;
    
    //UIObjects
    UILabel *loadingLabel;
    UITableView *menuTableView;
    UIActivityIndicatorView *activityIndicator; 
    UITabBar *loadingTabBar;
    UITabBar *friendsTabBar;
    UITabBarItem *friendsUsingTabBarItem;
    UITabBarItem *friendsNotUsingTabBarItem;
    
}

@property (nonatomic, retain) NSArray *items;
@property (nonatomic) BOOL friendUsesApp;
@property (nonatomic, retain) NSMutableArray *friendIds;
@property (nonatomic, retain) NSMutableArray *friendNames;
@property (nonatomic, retain) NSMutableArray *friendInstalled;
@property (nonatomic, retain) NSMutableArray *friendPicture;
@property (nonatomic, retain) UILabel *loadingLabel;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) UITableView *menuTableView;
@property (nonatomic, retain) UITabBar *loadingTabBar;
@property (nonatomic, retain) UITabBar *friendsTabBar;
@property (nonatomic, retain) UITabBarItem *friendsUsingTabBarItem;
@property (nonatomic, retain) UITabBarItem *friendsNotUsingTabBarItem;

@end
