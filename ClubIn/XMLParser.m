//  XMLParser.m
//  ClubInApp
//
//  Created by Cameron Bradley on 25/03/12.
//  Copyright (c) 2012 CameronBradley All rights reserved.

//import XMLParser header file
#import "XMLParser.h"

//import ClubNames header file
#import "ClubDetailsInterface.h"

@implementation XMLParser

//generate the getters and setters for clubs.
@synthesize clubs;

- (void) dealloc
{
    //release the parser
	[parser release];
	[super dealloc];
}

//implement the loadXMLByURL action
-(id) loadXMLByURL:(NSString *)urlString
{
	clubs			= [[NSMutableArray alloc] init];
	NSURL *url		= [NSURL URLWithString:urlString];
	NSData	*data   = [[NSData alloc] initWithContentsOfURL:url];
	parser			= [[NSXMLParser alloc] initWithData:data];
	parser.delegate = self;
	[parser parse];
	return self;
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //determine if the elemenent name is equal to the specified element name. 
	if ([elementname isEqualToString:@"ClubIn_Club"]) 
	{
		currentClub = [clubDetailsInterface alloc];
	}
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    //if element name is the club name
	if ([elementname isEqualToString:@"ClubIn_Clubs_Id"]) 
	{
        //currentClub = the current node content
		currentClub.clubId = currentNameContent;
        //NSLog(@"Name %@", currentClub.clubName);
	}
    
    //if element name is the club name
	if ([elementname isEqualToString:@"ClubIn_Clubs_Name"]) 
	{
        //currentClub = the current node content
		currentClub.clubName = currentNameContent;
        //NSLog(@"Name %@", currentClub.clubName);
	}
    
    //if element name is the club Longitude
	if ([elementname isEqualToString:@"ClubIn_Clubs_Longitude"]) 
	{
        //currentClub = the current node content
		currentClub.clubLongitude = currentNameContent;
        //NSLog(@"Longitude %@", currentClub.clubLongitude);
	}
    
    //if element name is the club Latitude
	if ([elementname isEqualToString:@"ClubIn_Clubs_Latitude"]) 
	{
        //currentClub = the current node content
		currentClub.clubLatitude = currentNameContent;
	}
    
    //if element name is the club address
	if ([elementname isEqualToString:@"ClubIn_Clubs_Address"]) 
	{
        //currentClub = the current node content
		currentClub.clubAddress = currentNameContent;
	}
    
    //if element is club checkIns.
    if ([elementname isEqualToString:@"ClubIn_Clubs_CheckedIn"])
    {
        //currentClub = the current node content
        currentClub.clubCheckIns = currentNameContent;
    }
    
    //if next element name is ClubIn_Club / if there is another record
	if ([elementname isEqualToString:@"ClubIn_Club"]) 
	{
        //release current Clubss
		[clubs addObject:currentClub];
		[currentClub release];
		currentClub = nil;
        [currentNameContent release];
		currentNameContent = nil;
	}
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	currentNameContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end