//
//  ProfileViewController.m
//  ClubIn
//
//  Created by Cameron Bradley on 26/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"

@implementation ProfileViewController

-(void)viewDidLoad {
    
    //set the navigation bar item title.
    self.navigationItem.title = @"Your Profile";
    
}

//initilize view programmatically
- (void) loadView {
    
    //allocate view
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen
                                                  mainScreen].applicationFrame];
    
    //add background default_bg image to view
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default.png"]];
    
    self.view = view;
    
}

@end
