//  XMLParser.h
//  ClubInApp
//
//  Created by Cameron Bradley on 25/03/12.
//  Copyright (c) 2012 CameronBradley All rights reserved.

#import <Foundation/Foundation.h>
#import "ClubDetailsInterface.h"

//decleration of the XMLParser 
@interface XMLParser : NSObject <NSXMLParserDelegate>

{
    //declare a Mutable String for name
    NSMutableString	*currentNameContent;
    //declare a Mutable Array - Array with a content that can be edited
    NSMutableArray  *clubs;
    //declare NSXMLParser to notify its delegates about relevent items (eg. elements, attributes)
    NSXMLParser	*parser;
    //declare ClubNames
    clubDetailsInterface *currentClub;
}


//declare the url string 
-(id) loadXMLByURL:(NSString *)urlString;

//set up accessors for the clubs array
@property (readonly, retain) NSMutableArray	*clubs;

@end
