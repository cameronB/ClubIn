//  LoginViewController.m
//  ClubInApp
//
//  Created by Cameron Bradley on 29/03/12.
//  Copyright (c) 2012 CameronBradley All rights reserved.

#import "LoginViewController.h"

@implementation LoginViewController

@synthesize permissions;
@synthesize loginButton;
@synthesize activityIndicator;

- (void)dealloc {
    [loginButton release];
    [permissions release];
    [activityIndicator release];
    [super dealloc];
}

//Make a Graph API Call to get information about the current logged in user.
- (void)apiFQLIMe {
    NSLog(@"graph api call");
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid, name, email, pic FROM user WHERE uid=me()", @"query",
                                   nil];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithMethodName:@"fql.query"
                                     andParams:params
                                 andHttpMethod:@"POST"
                                   andDelegate:self];
}

//Graph the user permissions
- (void)apiGraphUserPermissions {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me/permissions" andDelegate:self];
}

//called when user selects login
-(void)login {

    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //determine if session is not valid (really just added security)
    if (![[delegate facebook] isSessionValid]) {
        
        //authorize and the call the facebook UI login.
        [[delegate facebook] authorize:permissions];
    }  
    
    //call method to start the activity indicator 
    [self showActivityIndicator]; 
    
    loginButton.hidden = YES;    
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {

}

//initilize view programmatically
- (void) loadView {
    
    //allocate view
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen
                                                  mainScreen].applicationFrame];
    
    //set up view background
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default.png"]];
    self.view = view;
    [view release];    
      
    //Initialize permissions
    permissions = [[NSArray alloc] initWithObjects:@"offline_access", @"email", nil];
    
    // Activity Indicator
    int xPosition = (self.view.bounds.size.width / 2.0) - 15.0;
    int yPosition = (self.view.bounds.size.height / 2.0) - 15.0;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 10, 10)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;

    //add activity indicator to subview
    [self.view addSubview:activityIndicator];
    
    //Initialize login Button
    loginButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    CGFloat xLoginButtonOffset = self.view.center.x - (160/2);
    CGFloat yLoginButtonOffset = self.view.bounds.size.height - (258 + -60);
    loginButton.frame = CGRectMake(xLoginButtonOffset,yLoginButtonOffset,100,10);
    
    //add target and action for button (call login function)
    [loginButton addTarget:self
                    action:@selector(login)
          forControlEvents:UIControlEventTouchUpInside];
    [loginButton setImage: //use default facebook button from FBConnect.
     [UIImage imageNamed:@"FBConnect.bundle/images/LoginWithFacebookNormal.png"]
                 forState:UIControlStateNormal];
    [loginButton setImage:
     [UIImage imageNamed:@"FBConnect.bundle/images/LoginWithFacebookPressed.png"]
                 forState:UIControlStateHighlighted];
    [loginButton sizeToFit];
    
    //add login button to subview.
    [self.view addSubview:loginButton];
    
    
}



//store the authorisation data, set accesstoken and expiry.
- (void)storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

//extend the facebook token (each time the application is laoded)
-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSLog(@"Facebook User Login Token Extended");
    [self storeAuthData:accessToken expiresAt:expiresAt];
}

#pragma mark - FBSessionDelegate Methods
//Called when the user has logged in successfully.

- (void)fbDidLogin {
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self storeAuthData:[[delegate facebook] accessToken] expiresAt:[[delegate facebook] expirationDate]];
    
    //call method to graph API
    [self apiFQLIMe];

}

//Called when the user canceled the authorization dialog.
-(void)fbDidNotLogin:(BOOL)cancelled {

}

//Called when the request logout has succeeded.
- (void)fbDidLogout {
    
    
}

//Called when the session has expired.
- (void)fbSessionInvalidated {

}

//called to store facebook user information in database.
- (void)addUserInformationToDatabase {
    //initiate NSUserDefaults, store logindetails in defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];      
    
    //get users facebook email from NSUserDefaults
    NSString *facebookEmail = [defaults objectForKey:@"Facebook-Email"];    
    //encode for url.
    facebookEmail = [facebookEmail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //get the facebook name from NSUserDefaults
    NSString *facebookName = [defaults objectForKey:@"Facebook-Username"];
    
    //encode for url
    facebookName = [facebookName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //get the facebook picture url from NSUserDefaults
    NSString *facebookPictureURL = [defaults objectForKey:@"Facebook-Picture"];
    
    NSLog(@"email %@", facebookEmail);
    
    //encode for url.
    facebookPictureURL = [facebookPictureURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //remove htt:// from url for host security reasons..
    facebookPictureURL = [facebookPictureURL stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    
    //create post string (containing all the required fields, values)
    NSString *post = [NSString stringWithFormat:@"email=%@&name=%@&picture=%@", facebookEmail, facebookName, facebookPictureURL];
    
    //create host string (where PHP script is located)
    NSString *hostStr = @"http://complr.com/ClubIn/includes/scripts/users.php?";
    
    //append the post to the host string.
    hostStr = [hostStr stringByAppendingString:post];
    
    NSLog(@"%@", hostStr);
    
    //returns a data object containing the data from the location specified by a given url.
    NSData *dataURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:hostStr]];
    
    //output echo statement from php (dataURL) to string to allow for manipulation.
    NSString *strResult = [[NSString alloc] initWithData:dataURL encoding:NSUTF8StringEncoding];
    
    if([strResult isEqualToString:@"success"]) {
        
        NSLog(@"Facebook User sucessfully added to database");
        
        //when user has logged in succesfully remove the superview (the login view)
        [self.view removeFromSuperview];
        
        //call method to start the activity indicator 
        [self hideActivityIndicator]; 
        
    } else if ([strResult isEqualToString:@"user exists"]) {
        
        NSLog(@"Facebook user already exists in database");
        
        //when user has logged in succesfully remove the superview (the login view)
        [self.view removeFromSuperview];
        
        //call method to start the activity indicator 
        [self hideActivityIndicator]; 
        
        
    } else if ([strResult isEqualToString:@"query failed"]) {
        
        NSLog(@"Facebook user login query failed");
    }
    
    [strResult release];
    
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

//sent to the delegate when a request returns and its response has been parsed into an object.
- (void)request:(FBRequest *)request didLoad:(id)result {
    
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    // This callback can be a result of getting the user's basic
    // information or getting the user's permissions.
    if ([result objectForKey:@"name"]) {

        //initiate NSUserDefaults, store logindetails in defaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];        
             
        //store facebook name in userDefaults
        [defaults setObject:[result objectForKey:@"name"] forKey:@"Facebook-Username"];
        
        //store facebook email in the userDefaults
        [defaults setObject:[result objectForKey:@"email"] forKey:@"Facebook-Email"];
        
        //store the facebook pic in userDefaults
        [defaults setObject:[result objectForKey:@"pic"] forKey:@"Facebook-Picture"];
        
        //graph the apiUserPermissions
        [self apiGraphUserPermissions];
        
        //call method to add user information to datbase.
        [self addUserInformationToDatabase];
        
    } else {
        // Processing permissions information
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [delegate setUserPermissions:[[result objectForKey:@"data"] objectAtIndex:0]];
    }
}

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    //NSLog(@"Err message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    NSLog(@"Err code: %d", [error code]);
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    //only allow portrait view.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
