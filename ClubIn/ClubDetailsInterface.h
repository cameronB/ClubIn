//  clubDetailsInterface.h
//  ClubInApp
//
//  Created by Cameron Bradley on 25/03/12.
//  Copyright (c) 2012 CameronBradley All rights reserved.


#import <Foundation/Foundation.h>

@interface clubDetailsInterface : NSObject {
    
    //club Id
    NSString *clubId;
    //Club Name
    NSString *clubName;
    //club longitude
    NSString *clubLongitude;
    //club latitude
    NSString *clubLatitude;
    //club address
    NSString *clubAddress;
    //club CheckIns
    NSString *clubCheckIns;
    
}

//generate accessors
@property (nonatomic, retain) NSString *clubId;
@property (nonatomic, retain) NSString *clubName;
@property (nonatomic, retain) NSString *clubLongitude;
@property (nonatomic, retain) NSString *clubLatitude;
@property (nonatomic, retain) NSString *clubAddress;
@property (nonatomic, retain) NSString *clubCheckIns;

@end