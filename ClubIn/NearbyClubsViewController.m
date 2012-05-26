//  NearbyClubsViewController.m
//  ClubInApp
//
//  Created by Cameron Bradley on 1/04/12.
//  Copyright (c) 2012 CameronBradley All rights reserved.

#import "NearbyClubsViewController.h"
#import "MapViewAnnotation.h"

@implementation NearbyClubsViewController

//generate getters and setters for selected club.
@synthesize selectedClubId;
@synthesize selectedClubName;
@synthesize selectedClubLongitude;
@synthesize selectedClubLatitude;
@synthesize selectedClubAddress;
@synthesize mapView;

-(void)dealloc {
    [mapView release];
    [selectedClubAddress release];
    [selectedClubLatitude release];
    [selectedClubLongitude release];
    [selectedClubName release];
    [selectedClubId release];
    [super dealloc];
}

- (void) loadView {
    
    //allocate the view.
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen
                                                  mainScreen].applicationFrame];
    
    //set background image of view.
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default.png"]];
    self.view = view;
    self.title = @"Nearby Clubs";
    [view release];
    
    //allocate mapView.
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    //set the mapType.
    [mapView setMapType:MKMapTypeStandard];
    //set zoom enabled for user.
    [mapView setZoomEnabled:YES];
    //set the scroll enabled for user.
    [mapView setScrollEnabled:YES];
    
    //create a generate region in the middle of melbourne for the map to zoom to.
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
    region.center.latitude = -37.82782;
    region.center.longitude = 144.97293;
    region.span.longitudeDelta = 0.08f;
    region.span.latitudeDelta = 0.08f;
    
    //set region in mapView.
    [mapView setRegion:region animated:TRUE]; 
    
    //set mapView delegate to self.
    self.mapView.delegate = self;  
    
    //allocate the locationManager and setDelegate.
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    
    //show the userLocation.
    [self.mapView setShowsUserLocation:YES];
    
    [locationManager setDistanceFilter:kCLDistanceFilterNone];

    [self.view insertSubview:mapView atIndex:0];
    
}

-(void)viewDidLoad {

    //loop through each item in the xmlParser.
    for(int i = 0; i<= [selectedClubId count] - 1;i++)
    {
        //assign clubId to NSString.
        NSString *clubId = [selectedClubId objectAtIndex:i];
        
        //assign clubName to NSString.
        NSString *clubName = [selectedClubName objectAtIndex:i];
        
        //assign lat to NSString then convert to double.
        NSString *lat = [selectedClubLatitude objectAtIndex:i];
        double latitude = [lat doubleValue];
        
        //assign lon to NSString then convert to double.
        NSString *lon = [selectedClubLongitude objectAtIndex:i];
        double longitude = [lon doubleValue];
        
        //assign address to NSString.
        NSString *address = [selectedClubAddress objectAtIndex:i];
        
        //Set some coordinates for our position (Buckingham Palace!)
        CLLocationCoordinate2D location;
        location.latitude = latitude;
        location.longitude = longitude;
        
        //create new annotation.
        MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithTitle:clubName andCoordinate:location andSubTitle:address andClubId:clubId];
        [self.mapView addAnnotation:newAnnotation];
        [newAnnotation release];
    }
}

//Returns the view associated with the specified annotation object.
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"MyLocation";   
    if ([annotation isKindOfClass:[MapViewAnnotation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        //enable the annotationView.
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        //assign new user pin to annotationView.
        annotationView.image=[UIImage imageNamed:@"pin.png"];//here we use a nice image instead of the default pins
        
        return annotationView;
    }
    
    return nil;    
}

//called when an accessory on the annotation view is clicked.
- (void)mapView:(MKMapView *)mapView 
 annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control { 
        
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //allow only portrait viewing.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
