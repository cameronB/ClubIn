//
//  ClubMapViewController.m
//  ClubIn
//
//  Created by Cameron Bradley on 9/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ClubMapViewController.h"
#import "DetailViewController.h"
#import "MapViewAnnotation.h"

@implementation ClubMapViewController

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
    
    //set title of navigation bar item to club name
    self.title = selectedClubName;
    
    //release view.
    [view release];
    
    //allocate mapView.
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    //set the mapType.
    [mapView setMapType:MKMapTypeStandard];
    //set zoom enabled for user.
    [mapView setZoomEnabled:YES];
    //set the scroll enabled for user.
    [mapView setScrollEnabled:YES];
    
    //assign lat to NSString then convert to double.
    NSString *lat = selectedClubLatitude;
    double latitude = [lat doubleValue];
    
    //assign lon to NSString then convert to double.
    NSString *lon = selectedClubLongitude;
    double longitude = [lon doubleValue];    
    
    //create a generate region in the middle of melbourne for the map to zoom to.
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
    region.center.latitude = latitude;
    region.center.longitude = longitude;
    region.span.longitudeDelta = 0.0051f;
    region.span.latitudeDelta = 0.005f;
    
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

//method to go to user location.
-(void)userLocation {
    
    //determine the users long,lat and assign it to the region.
    CLLocationCoordinate2D location = [[[mapView userLocation] location] coordinate];  
    NSLog(@"Location of user found from Map: %f %f",location.latitude,location.longitude);
    
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
    region.center.latitude = location.latitude;
    region.center.longitude = location.longitude;
    region.span.longitudeDelta = 0.08f;
    region.span.latitudeDelta = 0.08f;
    
    //set region to mapView.
    [mapView setRegion:region animated:TRUE]; 
    
}

-(void)viewDidLoad {
        
    //assign clubId to NSString.
    NSString *clubId = selectedClubId;
        
    //assign clubName to NSString.
    NSString *clubName = selectedClubName;
        
    //assign lat to NSString then convert to double.
    NSString *lat = selectedClubLatitude;
    double latitude = [lat doubleValue];
        
    //assign lon to NSString then convert to double.
    NSString *lon = selectedClubLongitude;
    double longitude = [lon doubleValue];
    
    //assign address to NSString.
    NSString *address = selectedClubAddress;
        
    //Set some coordinates for our position (Buckingham Palace!)
    CLLocationCoordinate2D location;
    location.latitude = latitude;
    location.longitude = longitude;
        
    //create new annotation.
    MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithTitle:clubName andCoordinate:location andSubTitle:address andClubId:clubId];
    [self.mapView addAnnotation:newAnnotation];
    [newAnnotation release];
        
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

//display annotation automatically.
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    //declare myAnnotation as annotations from Mapview at index 0
    id<MKAnnotation> myAnnotation = [self.mapView.annotations objectAtIndex:0];
    
    //select the annotation, and display.
    [self.mapView selectAnnotation:myAnnotation animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
