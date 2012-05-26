//
//  ClubMapViewController.h
//  ClubIn
//
//  Created by Cameron Bradley on 9/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ClubMapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
    
    //declare mapView
    MKMapView *mapView;
    //declare location manager
    CLLocationManager *locationManager;

    //string that contains the club selected (id)
    NSString *selectedClubId;
    //string that contains the club selected (name)
    NSString *selectedClubName; 
    //string that contains the club selected (longitude)
    NSString *selectedClubLongitude;
    //string that contains the club selected (latitude)
    NSString *selectedClubLatitude;
    //string that contains the club selected (address)
    NSString *selectedClubAddress;
}

//generate the accessors for selectedClub
@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) NSString *selectedClubId;
@property (nonatomic, retain) NSString *selectedClubName;
@property (nonatomic, retain) NSString *selectedClubLongitude;
@property (nonatomic, retain) NSString *selectedClubLatitude;
@property (nonatomic, retain) NSString *selectedClubAddress;

@end