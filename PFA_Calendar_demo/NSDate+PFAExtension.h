//
//  NSDate+PFAExtension.h
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PFAExtension)

- (NSInteger)getDay;
- (NSInteger)getMonth;
- (NSInteger)getYear;
- (NSInteger)weekday;
- (NSInteger)weekOfYear;
- (NSDate *)dateByIgnoringTimeComponents;

- (NSDate *)firstDayOfMonth;
- (NSDate *)lastDayOfMonth;
- (NSInteger)numberOfDaysInMonth;

- (NSInteger)daysFrom:(NSDate *)date;
- (NSInteger)weeksFrom:(NSDate *)date;
- (NSInteger)monthsFrom:(NSDate *)date;
- (NSInteger)yearsFrom:(NSDate *)date;

- (NSDate *)dateByAddDays:(NSInteger)days;
- (NSDate *)dateByMinusDays:(NSInteger)days;
- (NSDate *)dateByAddWeeks:(NSInteger)weeks;
- (NSDate *)dateByMinusWeeks:(NSInteger)weeks;
- (NSDate *)dateByAddMonths:(NSInteger)months;
- (NSDate *)dateByMinusMonths:(NSInteger)months;
- (NSDate *)dateByAddYears:(NSInteger)years;
- (NSDate *)dateByMinusYears:(NSInteger)years;

+ (instancetype)dateFromString:(NSString *)string format:(NSString *)format;
+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end

@interface NSCalendar (PFAExtension)

+ (instancetype)sharedCalendar;

@end