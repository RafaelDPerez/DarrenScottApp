//
//  CalendarViewController.h
//  DarrenScottSalonApp
//
//  Created by Rafael Perez on 2/6/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"
#import "Review.h"

@interface CalendarViewController : UIViewController<FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance>
@property (weak, nonatomic) FSCalendar *calendar;

@property (weak, nonatomic) UIButton *previousButton;
@property (weak, nonatomic) UIButton *nextButton;

@property (strong, nonatomic) NSDateFormatter *dateFormatter1;
@property (strong, nonatomic) NSMutableDictionary *fillDefaultColors;

@property (strong, nonatomic) NSCalendar *gregorian;

@property (weak, nonatomic) UIView *hola;
@property (strong, nonatomic) NSMutableArray *reviewsArray;
@property (strong, nonatomic) NSMutableArray *reviewsArrayShow;
@property (weak, nonatomic) Review *reviewSelected;

- (void)previousClicked:(id)sender;
- (void)nextClicked:(id)sender;

@end
