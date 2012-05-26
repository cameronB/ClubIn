//  NearbyClubsViewController.h
//  ClubInApp
//
//  Created by Cameron Bradley on 1/04/12.
//  Copyright (c) 2012 CameronBradley All rights reserved.

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "XMLParser.h"
#import <CoreLocation/CoreLocation.h>

@interface NearbyClubsViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {

    MKMapView *mapView;
    UIButton *navButton;
    CLLocationManager *locationManager;
    
    NSMutableArray *selectedClubId;
    NSMutableArray *selectedClubName; 
    NSMutableArray *selectedClubLongitude;
    NSMutableArray *selectedClubLatitude;
    NSMutableArray *selectedClubAddress;
}

//generate the accessors for selectedClub
@property (nonatomic, retain) NSMutableArray *selectedClubId;
@property (nonatomic, retain) NSMutableArray *selectedClubName;
@property (nonatomic, retain) NSMutableArray *selectedClubLongitude;
@property (nonatomic, retain) NSMutableArray *selectedClubLatitude;
@property (nonatomic, retain) NSMutableArray *selectedClubAddress;
@property (nonatomic, retain) MKMapView *mapView;


@end

