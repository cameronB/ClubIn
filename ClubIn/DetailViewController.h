//
//  DetailViewController.h
//  ClubIn
//
//  Created by Cameron Bradley on 26/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController {

    NSMutableArray *listOfClubNames;
    
    NSString *selectedClubId;
    NSString *selectedClubName; 
    NSString *selectedClubLongitude;
    NSString *selectedClubLatitude;
    NSString *selectedClubAddress; 
    
    UIButton *btnHeadingHere;
    UILabel *lblClubLabel;
    UIImageView *headBar; 
}

@property (nonatomic, retain) NSMutableArray *listOfClubNames;
@property (nonatomic, retain) NSString *selectedClubId;
@property (nonatomic, retain) NSString *selectedClubName;
@property (nonatomic, retain) NSString *selectedClubLongitude;
@property (nonatomic, retain) NSString *selectedClubLatitude;
@property (nonatomic, retain) NSString *selectedClubAddress;

@end

