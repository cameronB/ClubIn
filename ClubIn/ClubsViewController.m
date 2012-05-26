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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Night Clubs";
}

- (void)refresh {
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
}

- (void)addItem {
    NSLog(@"Pull down refresh added");
    
    [self.tableView reloadData];
    
    [self stopLoading];}

@end

