//
//  AppDelegate.m
//  ClubIn
//
//  Created by Cameron Bradley on 29/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

//Tab Bar Classes
#import "ClubsViewController.h"
#import "ProfileViewController.h"
#import "FriendsViewController.h"

//static string for app (facebook) id
static NSString* kAppId = @"211325022301565";

@implementation AppDelegate

@synthesize window;

@synthesize tabBarController;

@synthesize navigationController;

@synthesize facebook;

@synthesize userPermissions;

- (void)dealloc
{
    [window release];
    [tabBarController release];
    [navigationController release];
    [facebook release];
    [userPermissions release];
    [super dealloc];
}

//application did finished launching..
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //allocate window.
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    //set window background to white
    [self.window setBackgroundColor:[UIColor blackColor]];
    
    //create navigation Controller
	UINavigationController *localNavigationController;
    
    //create TabBar controller
	tabBarController = [[UITabBarController alloc] init];
    
    //color for navigation bar
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:90/255.0
                                                                          green:10.0/255.0
                                                                           blue:90.0/255.0
                                                                          alpha:1.0]];      
    //tabBarController delegate
    tabBarController.delegate = self;
    
    //create the array that will contain all the View controllers
	NSMutableArray *localControllersArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    //Night Clubs Tab Bar Controller / Navigation Controller / View.
	ClubsViewController *viewController1;
	viewController1 = [[ClubsViewController alloc] init];
	localNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController1];
	localNavigationController.tabBarItem.image = [UIImage imageNamed:@"24_info.png"];
    viewController1.title = @"Clubs";
    
    //color for navigation bar
    [localNavigationController.navigationBar setTintColor:[UIColor colorWithRed:90/255.0
                                                              green:10.0/255.0
                                                               blue:90.0/255.0
                                                              alpha:1.0]];
    [localNavigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];    
    
	[localControllersArray addObject:localNavigationController];
	[localNavigationController release];
	[viewController1 release];
    
    //Profile Tab Bar Controller / Navigation Controller / View
    ProfileViewController *viewController2;
	viewController2 = [[ProfileViewController alloc] init];
	localNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController2];
	localNavigationController.tabBarItem.image = [UIImage imageNamed:@"24_info.png"];
    viewController2.title = @"My Profile";
    
    //color for navigation bar
    [localNavigationController.navigationBar setTintColor:[UIColor colorWithRed:90/255.0
                                                                          green:10.0/255.0
                                                                           blue:90.0/255.0
                                                                          alpha:1.0]];
    [localNavigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];    
    
	[localControllersArray addObject:localNavigationController];
	[localNavigationController release];
	[viewController2 release];  
    
    //Friends Tab Bar Controller / Navigation Controller / View
    FriendsViewController *viewController3;
	viewController3 = [[FriendsViewController alloc] init];
	localNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController3];
	localNavigationController.tabBarItem.image = [UIImage imageNamed:@"24_info.png"];
    viewController3.title = @"Friends";
    
    //color for navigation bar
    [localNavigationController.navigationBar setTintColor:[UIColor colorWithRed:90/255.0
                                                                          green:10.0/255.0
                                                                           blue:90.0/255.0
                                                                          alpha:1.0]];
    [localNavigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];    
    
	[localControllersArray addObject:localNavigationController];
	[localNavigationController release];
	[viewController3 release]; 
    
    //load up our tab bar controller with the view controllers
	tabBarController.viewControllers = localControllersArray;
    
    //release the array because the tab bar controller now has it
	[localControllersArray release];
    
    //self.window.rootViewController = self.tabBarController;
    [self.window addSubview:tabBarController.view];
    
    //Do any additional setup after loading the view, typically from a nib.
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    
    //Initialize Facebook
    facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:loginViewController];
    
    //Check and retrieve authorization information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    //Initialize user permissions
    userPermissions = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    //if the facebook session is not valid..
    if (![[self facebook] isSessionValid]) {
        
        NSLog(@"facebook session is not valid");
        
        //add LoginViewControllern to front of TabBarControllerView
        [self.window addSubview:loginViewController.view]; 
        
    }
    
    //make visisble.
    [self.window makeKeyAndVisible];
    
    //allocate splashView
    splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
    
    //set image backgrouind for splashview
    splashView.image = [UIImage imageNamed:@"Default.png"];
    
    //add splashView to subview
    [window addSubview:splashView];
    
    //bring the splashView subview to front
    [window bringSubviewToFront:splashView];
    
    //begin the animation
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:window cache:YES];
    [UIView setAnimationDelegate:self]; 
    [UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
    splashView.alpha = 0.0;
    splashView.frame = CGRectMake(-60, -60, 440, 600);
    
    //commit the animation to the UIView
    [UIView commitAnimations];     
    
    return YES;
}

//start up animation done.
- (void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    //[splashView removeFromSuperview];
    [splashView release];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //refresh / extend access token if required on application activation / launch
    [[self facebook] extendAccessTokenIfNeeded];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self.facebook handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self.facebook handleOpenURL:url];
}

#pragma mark - UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // Quit the app
    exit(1);
}

@end