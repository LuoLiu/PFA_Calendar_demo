//
//  CalendarContainerController.h
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 15/7/23.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalendarContainerController;
@class CalendarViewController;
@class CalendarDate;

@protocol CalendarContainerControllerDelegate <NSObject>

- (void)calendarCurrentMonthStringDidChangeTo:(NSString *)monthString;
- (void)isCurrentMonth:(BOOL)isCurrentMonth;

@end

@interface CalendarContainerController : UIViewController

@property (weak, nonatomic) id<CalendarContainerControllerDelegate> delegate;

@end
