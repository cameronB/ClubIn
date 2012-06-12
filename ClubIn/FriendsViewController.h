//
//  FriendsViewController.h
//  ClubIn
//
//  Created by Cameron Bradley on 11/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "AppDelegate.h"

@interface FriendsViewController : UITableViewController <FBSessionDelegate, FBDialogDelegate, FBRequestDelegate> {
    
}

@end
