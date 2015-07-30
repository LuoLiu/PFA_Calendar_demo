//
//  CalendarCollectionViewModel.h
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CalendarDate;

@interface CalendarCollectionViewModel : NSObject

@property (strong, nonatomic) NSArray *dateList;
@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;
@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonatomic) NSDate *currentMonth;
@property (strong, nonatomic) NSDate *selectedDate;

///妊娠日
@property (strong, nonatomic) NSDate *pregDate;
///出産予定日
@property (strong, nonatomic) NSDate *expBirthday;
///誕生日(出生日)
@property (strong, nonatomic) NSDate *birthday;

- (instancetype)initWithDateList:(NSArray *)dateList;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (NSDate *)dateForIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathForDate:(NSDate *)date;
//- (NSDate *)monthForSection:(NSInteger)section;

- (BOOL)isDateInRange:(NSDate *)date;
- (void)setSelectedDate:(NSDate *)selectedDate animate:(BOOL)animate;

- (NSString *)setMonthLabelForSection:(NSInteger)section;
- (NSString *)weekAndDayToExpBirthday:(NSDate *)date;
- (NSInteger)pregMonthsInDate:(NSDate *)date;

- (CalendarDate *)calendarDateForIndexPath:(NSIndexPath *)indexPath;

@end
