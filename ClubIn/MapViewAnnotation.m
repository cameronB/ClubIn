//
//  MapViewAnnotation.m
//  ClubIn
//
//  Created by Cameron Bradley on 6/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewAnnotation.h"

@implementation MapViewAnnotation

//generate getters and setters.
@synthesize title, coordinate, subtitle, clubId;

- (void)dealloc {
	[title release];
    [subtitle release];
    [clubId release];
	[super dealloc];
}

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d andSubTitle:(NSString *)stl andClubId:(NSString *)cId {
    [super init];
	title = ttl;
    subtitle = stl;
    clubId = cId;
	coordinate = c2d;
	return self;
}

@end