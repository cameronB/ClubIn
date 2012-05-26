//  AppDelegate.h
//  ClubIn
//
//  Created by Cameron Bradley on 29/03/12.
//  Copyright (c) 2012 CameronBradley All rights reserved.

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "FBConnect.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, UITabBarDelegate> {
    
    //tabbarController
    UITabBarController *tabBarController;
    
    //navigationController
    UINavigationController *navigationController;
    
    //Facebook
    Facebook *facebook;
    
    //userPermissionsDictionary
    NSMutableDictionary *userPermissions;
    
    //ImageView for start up screen
    UIImageView *splashView;
    
}

//method for startupanimations
- (void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;

//generate accesors
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) NSMutableDictionary *userPermissions;

@end
