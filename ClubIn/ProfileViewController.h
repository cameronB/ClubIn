//  ProfileViewController.h
//  ClubInApp
//
//  Created by Cameron Bradley on 1/04/12.
//  Copyright (c) 2012 CameronBradley All rights reserved.

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface ProfileViewController : UIViewController <FBRequestDelegate, FBDialogDelegate> {
    
    //header view
    UIView *headerView;
    
    //facebook user name label
    UILabel *nameLabel;
    
    //facebook user profile photo image
    UIImageView *profilePhotoImageView; 
    
    //uiactivityindicator 
    UIActivityIndicatorView *activityIndicator;
}

//set up accessors..
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIImageView *profilePhotoImageView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@end
