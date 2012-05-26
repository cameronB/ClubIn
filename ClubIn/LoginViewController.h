//  LoginViewController.h
//  ClubInApp
//
//  Created by Cameron Bradley on 29/03/12.
//  Copyright (c) 2012 CameronBradley All rights reserved.

#import <UIKit/UIKit.h>
#import "ClubsViewController.h"
#import "AppDelegate.h"
#import "FBConnect.h"

@interface LoginViewController : UIViewController <FBSessionDelegate, FBDialogDelegate, FBRequestDelegate>{
    
    //facebook login button
    UIButton *loginButton;  
    
    //array to determine permissions the user of the app will accept to.
    NSArray *permissions;   
    
    //activity indication while login is occuring (database related processing)
    UIActivityIndicatorView *activityIndicator;
    
}

//generate accessors for permissions
@property (nonatomic, retain) UIButton *loginButton;
@property (nonatomic, retain) NSArray *permissions;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@end
