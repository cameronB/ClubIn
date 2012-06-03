//
//  HeadingHereViewController.h
//  ClubIn
//
//  Created by Cameron Bradley on 2/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadingHereViewController : UIViewController <UIPickerViewDelegate, UITextFieldDelegate> {
    
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIButton *datButton;
    
    UIButton *closeButton;
    UILabel *clubNameLabel;
    UIButton *submitButton;
    NSString *viewClubName;
    
}

@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet UIButton *dateButton;

@property (nonatomic, retain) NSString *viewClubName;

@end
