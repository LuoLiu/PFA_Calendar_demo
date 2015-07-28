//
//  NSDate+PFAExtension.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "NSDate+PFAExtension.h"

@implementation NSDate (PFAExtension)

- (NSInteger)getDay {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitDay
                                              fromDate:self];
    return component.day;
}

- (NSInteger)getMonth {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitMonth
                                              fromDate:self];
    return component.month;
}

- (NSInteger)getYear {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitYear fromDate:self];
    return component.year;
}

- (NSInteger)weekday {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return component.weekday;
}

- (NSString *)dayInWeek {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekday fromDate:self];
    switch (component.weekday) {
        case 1:
            return @"日";
            break;
        case 2:
            return @"月";
            break;
        case 3:
            return @"火";
            break;
        case 4:
            return @"水";
            break;
        case 5:
            return @"木";
            break;
        case 6:
            return @"金";
            break;
        case 7:
            return @"土";
            break;
            
        default:
            return @"";
            break;
    }
}

- (NSInteger)weekOfYear {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekOfYear fromDate:self];
    return component.weekOfYear;
}

- (NSDate *)dateByIgnoringTimeComponents {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    return [calendar dateFromComponents:components];
}

- (BOOL)isEqualToDateForDay:(NSDate *)date {
    return [self getYear] == [date getYear] && [self getMonth] == [date getMonth] && [self getDay] == [date getDay];
}

- (BOOL)isEqualToDateForWeek:(NSDate *)date {
    return [self getYear] == [date getYear] && [self weekOfYear] == [date weekOfYear];
}

- (BOOL)isEqualToDateForMonth:(NSDate *)date {
    return [self getYear] == [date getYear] && [self getMonth] == [date getMonth];
}

#pragma mark - Date For Month

- (NSDate *)firstDayOfMonth {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    components.day = 1;
    return [calendar dateFromComponents:components];
}

- (NSDate *)lastDayOfMonth {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    components.month++;
    components.day = 0;
    return [calendar dateFromComponents:components];
}

- (NSInteger)numberOfDaysInMonth {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay
                           inUnit:NSCalendarUnitMonth
                          forDate:self];
    return days.length;
}

#pragma mark - Date From

- (NSInteger)daysFrom:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.day;
}

- (NSInteger)weeksFrom:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekOfYear
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.weekOfYear;
}

- (NSInteger)monthsFrom:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.month;
}

- (NSInteger)yearsFrom:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.year;
}

#pragma mark - Date Add/Minus

- (NSDate *)dateByAddDays:(NSInteger)days {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByMinusDays:(NSInteger)days {
    return [self dateByAddDays:-days];
}

- (NSDate *)dateByAddWeeks:(NSInteger)weeks {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByMinusWeeks:(NSInteger)weeks {
    return [self dateByAddWeeks:-weeks];
}

- (NSDate *)dateByAddMonths:(NSInteger)months {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByMinusMonths:(NSInteger)months {
    return [self dateByAddMonths:-months];
}

- (NSDate *)dateByAddYears:(NSInteger)years {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByMinusYears:(NSInteger)years {
    return [self dateByAddYears:-years];
}

#pragma mark - DateTransform

+ (instancetype)dateFromString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter dateFromString:string];
}

+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    return [calendar dateFromComponents:components];
}

@end

@implementation NSCalendar (PFAExtension)

+ (instancetype)sharedCalendar {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //instance = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierJapanese];
        instance = [NSCalendar currentCalendar];
    });
    return instance;
}

@end
