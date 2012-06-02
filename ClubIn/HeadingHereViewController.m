//
//  HeadingHereViewController.m
//  ClubIn
//
//  Created by Cameron Bradley on 2/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeadingHereViewController.h"

@implementation HeadingHereViewController

-(void)dealloc {
    [super dealloc];
}


//initiate view programmatically.
- (void) loadView {
    
    //create a view.
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen
                                              mainScreen].applicationFrame];

    //set background image.
    view.backgroundColor = [UIColor whiteColor];

    //set self view as view.
    self.view = view;
    
    //add close button to view.
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitle:@"X" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    closeButton.backgroundColor = [UIColor whiteColor];
    closeButton.frame = CGRectMake(285.0, 00.0, 35.0, 35.0);
    //add btnHeadingHere to the view subview.
    [view addSubview:closeButton];        
    

    //release view.
    [view release];
}

- (void) close {
    NSLog(@"close view");
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
