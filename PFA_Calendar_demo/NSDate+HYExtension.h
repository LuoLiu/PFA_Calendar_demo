//
//  NSDate+HYExtension.h
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HYExtension)

///日付
///YYYY/MM/DDの形式
@property (copy, nonatomic) NSString *date;

///戌の日
///0: 通常日、1: 戌の日
@property (assign, nonatomic) BOOL isDogsDay;

///祝日
///0: 通常日、1: 祝日
@property (assign, nonatomic) BOOL isHoliday;

///祝日名
@property (copy, nonatomic) NSString *holidayName;

- (NSInteger)getDay;
- (NSInteger)getMonth;
- (NSInteger)getYear;
- (NSInteger)weekday;
- (NSString *)dayInWeek;
- (NSInteger)weekOfYear;
- (NSDate *)dateByIgnoringTimeComponents;
- (NSString *)stringWithFormat:(NSString *)format;

- (BOOL)isEqualToDateForDay:(NSDate *)date;
- (BOOL)isEqualToDateForWeek:(NSDate *)date;
- (BOOL)isEqualToDateForMonth:(NSDate *)date;
    
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

@interface NSCalendar (HYExtension)

+ (instancetype)sharedCalendar;

@end