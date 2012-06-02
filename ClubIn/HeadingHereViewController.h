//
//  HeadingHereViewController.h
//  ClubIn
//
//  Created by Cameron Bradley on 2/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadingHereViewController : UIViewController {
    
    //declare closebutton.
    UIButton *closeButton;
    //declare heading label
    UILabel *clubNameLabel;
    
    //decalre clubName as string.
    NSString *viewClubName;
    
}

@property (nonatomic, retain) NSString *viewClubName;

@end