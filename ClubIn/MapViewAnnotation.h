//  MapViewAnnotation.h
//  ClubIn
//
//  Created by Cameron Bradley on 6/04/12.
//  Copyright (c) 2012 CameronBradley All rights reserved.


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapViewAnnotation : NSObject <MKAnnotation> {
    
	NSString *title;
    NSString *subtitle;
    NSString *clubId;
	CLLocationCoordinate2D coordinate;
    
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, retain) NSString *clubId;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

//method to hold new annotation data.
- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d andSubTitle:(NSString *)stl andClubId:(NSString *)cId;

@end
