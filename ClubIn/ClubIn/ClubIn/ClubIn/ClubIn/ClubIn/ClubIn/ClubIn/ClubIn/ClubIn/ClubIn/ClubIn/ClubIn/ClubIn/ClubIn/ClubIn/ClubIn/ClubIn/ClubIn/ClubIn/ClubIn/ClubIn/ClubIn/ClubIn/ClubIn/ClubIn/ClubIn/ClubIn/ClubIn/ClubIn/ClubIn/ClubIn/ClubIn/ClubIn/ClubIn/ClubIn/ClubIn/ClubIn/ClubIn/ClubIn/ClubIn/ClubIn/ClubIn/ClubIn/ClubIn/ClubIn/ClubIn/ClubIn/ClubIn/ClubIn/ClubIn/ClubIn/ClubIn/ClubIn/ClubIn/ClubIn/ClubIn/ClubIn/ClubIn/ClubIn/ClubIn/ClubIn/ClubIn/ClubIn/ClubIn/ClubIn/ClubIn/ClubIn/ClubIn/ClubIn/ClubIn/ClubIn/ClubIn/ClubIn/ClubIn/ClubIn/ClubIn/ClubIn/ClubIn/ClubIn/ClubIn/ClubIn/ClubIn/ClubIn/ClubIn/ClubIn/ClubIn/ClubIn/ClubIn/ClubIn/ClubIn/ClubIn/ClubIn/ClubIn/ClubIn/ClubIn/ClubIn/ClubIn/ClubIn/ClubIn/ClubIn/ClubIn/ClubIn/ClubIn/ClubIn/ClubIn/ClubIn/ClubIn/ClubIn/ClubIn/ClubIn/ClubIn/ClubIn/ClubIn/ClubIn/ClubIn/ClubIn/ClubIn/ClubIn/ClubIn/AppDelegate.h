//
//  AppDelegate.h
//  ClubIn
//
//  Created by Cameron Bradley on 26/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, UITabBarDelegate> {
    
    //declare the tabBar controller
    UITabBarController *tabBarController;
    
    //declare the navigation controller
    UINavigationController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UINavigationController *navigationController;

@end
