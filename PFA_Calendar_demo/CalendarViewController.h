//
//  CalendarViewController.h
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalendarViewController;
@class CalendarDate;

@protocol CalendarViewControllerDelegate <NSObject>

@optional
- (void)calendarCurrentMonthStringDidChangeTo:(NSString *)monthString;
- (void)isCurrentMonth:(BOOL)isCurrentMonth;
- (void)getScheduleDate:(CalendarDate *)calendarDate;

@end

@interface CalendarViewController : UICollectionViewController

@property (weak, nonatomic) id<CalendarViewControllerDelegate> delegate;

@end
