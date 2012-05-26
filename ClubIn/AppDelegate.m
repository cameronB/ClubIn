//
//  AppDelegate.m
//  ClubIn
//
//  Created by Cameron Bradley on 26/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ClubsViewController.h"
#import "ProfileViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController;
@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //create TabBar controller
	tabBarController = [[UITabBarController alloc] init];
    
    //tabBarController delegate
    tabBarController.delegate = self;
    
    //create the array that will contain all the View controllers
	NSMutableArray *localControllersArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    //Night Clubs Tab Bar Controller / Navigation Controller / View.
	ClubsViewController *viewController1;
	viewController1 = [[ClubsViewController alloc] init];
	navigationController = [[UINavigationController alloc] initWithRootViewController:viewController1];
	navigationController.tabBarItem.image = [UIImage imageNamed:@"24_info.png"];
    viewController1.title = @"Clubs";
    [navigationController.navigationBar setTintColor:[UIColor blackColor]];
	[localControllersArray addObject:navigationController];
    
    //Profile Tab Bar Controller / Navigation Controller / View
    ProfileViewController *viewController2;
	viewController2 = [[ProfileViewController alloc] init];
	navigationController = [[UINavigationController alloc] initWithRootViewController:viewController2];
	navigationController.tabBarItem.image = [UIImage imageNamed:@"24_info.png"];
    viewController2.title = @"My Profile";
    [navigationController.navigationBar setTintColor:[UIColor blackColor]];
	[localControllersArray addObject:navigationController]; 
    
    //load up our tab bar controller with the view controllers
	tabBarController.viewControllers = localControllersArray;
    
    //self.window.rootViewController = self.tabBarController;
    [self.window addSubview:tabBarController.view];    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
