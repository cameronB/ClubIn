//
//  HeadingHereViewController.m
//  ClubIn
//
//  Created by Cameron Bradley on 2/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeadingHereViewController.h"

@implementation HeadingHereViewController

@synthesize datePicker;
@synthesize dateButton;
@synthesize viewClubName;

-(void)dealloc {
    [super dealloc];
    [dateButton release];
    [datePicker release];
    [viewClubName release];
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
    //release view.
    [view release];
    
    //allocate club label.
    clubNameLabel = [[UILabel alloc]
                    initWithFrame:CGRectMake(0, 2.5, 320.0, 40.0)];
    clubNameLabel.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    clubNameLabel.textAlignment = UITextAlignmentCenter;
    clubNameLabel.textColor = [UIColor blueColor];
    clubNameLabel.backgroundColor = [UIColor whiteColor];
    //set text as selected club.
    clubNameLabel.text = viewClubName;
    //add clubNameLabel to headbar subview.
    [view addSubview:clubNameLabel];

    //create dateButton to display date selected and pop the datepicker
    dateButton = [[UIButton alloc] init];
    dateButton.frame = CGRectMake(10, 60, 300, 40);
    dateButton.backgroundColor = [UIColor clearColor];
    NSDateFormatter *theDateFormat = [[NSDateFormatter alloc] init];
    theDateFormat.dateStyle = NSDateFormatterMediumStyle;
    [dateButton setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
    [dateButton setTitle:[NSString stringWithFormat:@"Date Planned: %@", [theDateFormat stringFromDate:[NSDate date]]] forState:UIControlStateNormal];
    [dateButton addTarget:self action:@selector(popDatePicker) forControlEvents:UIControlEventTouchUpInside];
    [theDateFormat release];
    [self.view addSubview:dateButton];
    
    //allocate the datePicker 
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 250, 325, 300)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.hidden = YES;
    datePicker.date = [NSDate date];
    
    [datePicker addTarget:self
                   action:@selector(pickerChange)
         forControlEvents:UIControlEventValueChanged];
    [view addSubview:datePicker];
    
    //add close button to view.
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitle:@"X" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    closeButton.backgroundColor = [UIColor whiteColor];
    closeButton.frame = CGRectMake(285.0, 8.5, 35.0, 35.0);
    //add closeButton to the view subview.
    [view addSubview:closeButton];   
    
}

//touches anywhere on the view will hide the datePicker
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {    
    datePicker.hidden = YES;
}

//close the model view, the heading here view.
- (void) close {
    NSLog(@"close view");
    
    [self dismissModalViewControllerAnimated:YES];
}

//called when submit is selected.
- (void) submit {
    NSLog(@"Submit button activated");
    
}

//display the datepicker
- (void) popDatePicker {
    //basic animation for datepicker.
    datePicker.alpha = 0.0f;
    datePicker.hidden = NO;
    
    [UIView animateWithDuration:0.5f animations:^{
        datePicker.alpha = 1.0f;
    } completion:^(BOOL finished){}];
}

//updates the button text when the picker date is changed.
- (void) pickerChange {
    NSDateFormatter *theDateFormat = [[NSDateFormatter alloc] init];
    theDateFormat.dateStyle = NSDateFormatterMediumStyle;
    [dateButton setTitle:[NSString stringWithFormat:@"Date Planned: %@", [theDateFormat stringFromDate:datePicker.date]] forState:UIControlStateNormal];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
