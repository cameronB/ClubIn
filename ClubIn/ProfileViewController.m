//  ProfileViewController.m
//  ClubInApp
//
//  Created by Cameron Bradley on 1/04/12.
//  Copyright (c) 2012 CameronBradley All rights reserved.

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "FBConnect.h"

@implementation ProfileViewController

@synthesize nameLabel;
@synthesize headerView;
@synthesize profilePhotoImageView;
@synthesize activityIndicator;

- (void)dealloc
{
    [headerView release];
    [nameLabel release];
    [profilePhotoImageView release];
    [activityIndicator release];
    [super dealloc];
}

-(void)viewDidLoad {
    
    //set the navigation bar item title.
    self.navigationItem.title = @"My Profile";
    
}

//initilize view programmatically
- (void) loadView {
    
    //allocate view
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen
                                                  mainScreen].applicationFrame];
    
    //add background default_bg image to view
    view.backgroundColor = [UIColor whiteColor];
    
    self.view = view;
    [view release];
    
    //allocate the headerView.
    headerView = [[UIView alloc]
                  initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    headerView.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    CGFloat xProfilePhotoOffset = self.view.center.x - 25.0;
    
    //profile photo image
    profilePhotoImageView = [[UIImageView alloc]
                             initWithFrame:CGRectMake(xProfilePhotoOffset, 20, 50, 50)];
    profilePhotoImageView.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //add profile photo image to headerview
    [headerView addSubview:profilePhotoImageView];
    
    //allocate the name label
    nameLabel = [[UILabel alloc]
                 initWithFrame:CGRectMake(0, 75, self.view.bounds.size.width, 20.0)];
    nameLabel.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    nameLabel.textAlignment = UITextAlignmentCenter;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor blueColor];
    nameLabel.text = @"";
    
    // Get the profile image
    //UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[result objectForKey:@"pic"]]]];
    
    //add namelabel to headerview
    [headerView addSubview:nameLabel];    
    
    //add headerview (with photo and name) to subview.
	[self.view addSubview:headerView];
    
    // Activity Indicator
    int xPosition = (self.view.bounds.size.width / 2.0) - 15.0;
    int yPosition = (self.view.bounds.size.height / 2.0) - 15.0;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 30, 30)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    //add activity indicator to subview
    [self.view addSubview:activityIndicator];
    
    //call method to start the activity indicator 
    [self showActivityIndicator];  
    
    [self loadProfileDetails];
    
}

//load profile details from NSUserDefaults into interface.
-(void)loadProfileDetails {
    
    //initiate NSUserDefaults, store in defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    
    nameLabel.text = [defaults objectForKey:@"Facebook-Username"];
    
    // Get the profile image
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[defaults objectForKey:@"Facebook-Picture"]]]];
    
    // Resize, crop the image to make sure it is square and renders
    // well on Retina display
    float ratio;
    float delta;
    float px = 100; // Double the pixels of the UIImageView (to render on Retina)
    CGPoint offset;
    CGSize size = image.size;
    if (size.width > size.height) {
        ratio = px / size.width;
        delta = (ratio*size.width - ratio*size.height);
        offset = CGPointMake(delta/2, 0);
    } else {
        ratio = px / size.height;
        delta = (ratio*size.height - ratio*size.width);
        offset = CGPointMake(0, delta/2);
    }
    CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                 (ratio * size.width) + delta,
                                 (ratio * size.height) + delta);
    UIGraphicsBeginImageContext(CGSizeMake(px, px));
    UIRectClip(clipRect);
    [image drawInRect:clipRect];
    UIImage *imgThumb = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [profilePhotoImageView setImage:imgThumb]; 
    
    //hide the activity indicator
    [self hideActivityIndicator];
}


//This method shows the activity indicator
- (void)showActivityIndicator {
    if (![activityIndicator isAnimating]) {
        [activityIndicator startAnimating];
    }
}

//This method hides the activity indicator
- (void)hideActivityIndicator {
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //portrait view
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end