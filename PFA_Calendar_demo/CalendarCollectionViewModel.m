//
//  CalendarCollectionViewModel.m
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "CalendarCollectionViewModel.h"
#import "CalendarDate.h"
#import "ScheduleEvent.h"
#import "NSDate+HYExtension.h"
#import "DateFormatterHelper.h"

#define kWEEK_DAYS           (7)
#define kCOLLECTIONVIEW_ROWS (6)
#define kFIRSTWEEKDAY        (1) //Sunday(1),Monday(2)...

@interface CalendarCollectionViewModel ()

@end

@implementation CalendarCollectionViewModel

#pragma mark - Initialization

- (instancetype)initWithDateList:(NSArray *)dateList andEventList:(NSArray *)eventList{
    self = [super init];
    
    if (self) {
        _dateList = dateList;
        _eventList = eventList;
        
        _minimumDate  = [[dateList firstObject] date];
        _maximumDate  = [[dateList lastObject] date];
        _currentDate  = [NSDate date].dateByIgnoringTimeComponents;
        _currentMonth = [_currentDate copy];
        //-------test-----------
        _minimumDate = [NSDate dateWithYear:1970 month:1 day:1];
        _maximumDate = [NSDate dateWithYear:2099 month:12 day:31];
        _pregDate    = [NSDate dateWithYear:2015 month:3 day:5];
        _expBirthday = [NSDate dateWithYear:2015 month:12 day:25];
        _birthday    = [NSDate dateWithYear:2015 month:12 day:27];
        //-------test end-------
        
        //-------test-----------
        ScheduleEvent *event1 = [[ScheduleEvent alloc] init];
        event1.eventTitle = @"検診";
        event1.startDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/7/27 11:00:11"];
        event1.endDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/7/29 11:00:11"];
        event1.eventType = ScheduleEventTypeCheckup;
        event1.alarmMinutes = 5;
        event1.memo = @"ScheduleEvent";
        
        ScheduleEvent *event2 = [[ScheduleEvent alloc] init];
        event2.eventTitle = @"検診";
        event2.startDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/7/28 22:00:22"];
        event2.endDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/7/28 23:00:22"];
        event2.eventType = ScheduleEventTypeCheckup;
        event2.alarmMinutes = -1;
        event2.memo = @"";
        
        ScheduleEvent *event3 = [[ScheduleEvent alloc] init];
        event3.eventTitle = @"Test 3";
        event3.startDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/7/28 23:00:33"];
        event3.endDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/8/1 23:00:33"];
        event3.eventType = ScheduleEventTypeOthers;
        event3.isShare = YES;
        event3.alarmMinutes = -1;
        event3.memo = @"ScheduleEvent";
        
        ScheduleEvent *event4 = [[ScheduleEvent alloc] init];
        event4.eventTitle = @"Test Test 4";
        event4.startDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/6/1 10:54:33"];
        event4.endDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/6/2 10:54:33"];
        event4.eventType = ScheduleEventTypeOthers;
        event4.isShare = YES;
        event4.alarmMinutes = -1;
        event4.memo = @"ScheduleEvent";
        
        ScheduleEvent *event5 = [[ScheduleEvent alloc] init];
        event5.eventTitle = @"検診";
        event5.startDate = [NSDate date];
        event5.endDate = [NSDate date];
        event5.eventType = ScheduleEventTypeCheckup;
        event5.alarmMinutes = -1;
        event5.memo = @"ScheduleEvent";
        
        _eventList = [NSArray arrayWithObjects:event1, event2, event3, event4, event5, event1, event2, event3, event4, event5, nil];
        //-------test end-------

    }
    return self;
}

#pragma mark - Collection

- (NSInteger)numberOfSections {
    return [_maximumDate monthsFrom:[_minimumDate firstDayOfMonth]] + 1;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    return kWEEK_DAYS*kCOLLECTIONVIEW_ROWS;
}

- (CalendarDate *)calendarDateForIndexPath:(NSIndexPath *)indexPath {
    NSDate *date = [self dateForIndexPath:indexPath];
//    for (CalendarDate *calendarDate in _dateList) {
//        if ([calendarDate.date isEqualToDate:date]) {
//            return calendarDate;
//        }
//    }
    
    CalendarDate *calendarDate = [[CalendarDate alloc] init];
    calendarDate.date = date;
    //-------test-----------
    if ([date isEqualToDateForDay:[NSDate dateWithYear:2015 month:8 day:8]]) {
        calendarDate.isDogsDay = YES;
    }
    //-------test end-------
    return calendarDate;
}

- (NSDate *)dateForIndexPath:(NSIndexPath *)indexPath {
    NSDate *selectMonth = [[_minimumDate firstDayOfMonth] dateByAddMonths:indexPath.section];
    NSDate *firstDayOfMonth = [NSDate dateWithYear:[selectMonth getYear]
                                             month:[selectMonth getMonth]
                                               day:1];
    NSInteger numberOfPalaceholdersForPrev = (([firstDayOfMonth weekday] - kFIRSTWEEKDAY) + kWEEK_DAYS) % kWEEK_DAYS ? : kWEEK_DAYS;
    NSDate *firstDayOfPage = [firstDayOfMonth dateByMinusDays:numberOfPalaceholdersForPrev];
    NSUInteger rows = indexPath.item % kCOLLECTIONVIEW_ROWS;
    NSUInteger columns = indexPath.item / kCOLLECTIONVIEW_ROWS;
    NSDate *date = [firstDayOfPage dateByAddDays:kWEEK_DAYS * rows + columns];
    
    return [date dateByIgnoringTimeComponents];
}

- (NSIndexPath *)indexPathForDate:(NSDate *)date {
    NSInteger section = [date monthsFrom:[_minimumDate firstDayOfMonth]];
    NSDate *firstDayOfMonth = [date firstDayOfMonth];
    NSInteger numberOfPlaceholdersForPrev = (([firstDayOfMonth weekday] - kFIRSTWEEKDAY) + kWEEK_DAYS) % kWEEK_DAYS ? : kWEEK_DAYS;
    NSDate *firstDateOfPage = [firstDayOfMonth dateByMinusDays:numberOfPlaceholdersForPrev];
    NSInteger item = 0;
    NSInteger vItem = [date daysFrom:firstDateOfPage];
    NSInteger rows = vItem / kWEEK_DAYS;
    NSInteger columns = vItem % kWEEK_DAYS;
    item = columns * kCOLLECTIONVIEW_ROWS + rows;

    return [NSIndexPath indexPathForItem:item inSection:section];
}

- (NSMutableArray *)eventListForIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *eventList = [NSMutableArray array];
    for (ScheduleEvent *event in self.eventList) {
        if ([event.startDate isEqualToDateForDay:[self dateForIndexPath:indexPath]]) {
            [eventList addObject:event];
            if (event.isShare) {
                [eventList addObject:event];
            }
        }
    }
   
    return eventList;
}

//- (NSDate *)monthForSection:(NSInteger)section {
//    NSDate *selectMonth = [[_minimumDate firstDayOfMonth] dateByAddMonths:section];
//    NSDate *date = [selectMonth dateByAddMonths:section];
//    
//    return [date dateByIgnoringTimeComponents];
//}

#pragma mark - Properties

- (void)setSelectedDate:(NSDate *)selectedDate animate:(BOOL)animate {
    if (![self isDateInRange:selectedDate]) {
        [NSException raise:@"selectedDate out of range" format:nil];
    }
    
    selectedDate = [selectedDate daysFrom:_minimumDate] < 0 ? [NSDate dateWithYear:[_minimumDate getYear] month:[_minimumDate getMonth] day:[selectedDate getDay]] : selectedDate;
    selectedDate = [selectedDate daysFrom:_maximumDate] > 0 ? [NSDate dateWithYear:[_maximumDate getYear] month:[_maximumDate getMonth] day:[selectedDate getDay]] : selectedDate;
    selectedDate = selectedDate.dateByIgnoringTimeComponents;
    [self didChangeValueForKey:@"currentMonth"];
}

- (void)setCurrentDate:(NSDate *)currentDate {
    if (![self isDateInRange:currentDate]) {
        [NSException raise:@"currentDate out of range" format:nil];
    }
    if (![_currentDate isEqualToDateForDay:currentDate]) {
        currentDate = [currentDate dateByIgnoringTimeComponents];
        _currentDate = currentDate;
        _currentMonth = [currentDate copy];
    }
}

- (void)setCurrentMonth:(NSDate *)currentMonth {
    if (![self isDateInRange:currentMonth]) {
        [NSException raise:@"currentMonth out of range" format:nil];
    }
    if (![_currentMonth isEqualToDateForMonth:currentMonth]) {
        currentMonth = [currentMonth dateByIgnoringTimeComponents];
        _currentMonth = currentMonth;
    }
}

- (BOOL)isDateInRange:(NSDate *)date {
    return [date daysFrom:_minimumDate] >= 0 && [date daysFrom:_maximumDate] <= 0;
}

- (NSString *)setMonthLabelForSection:(NSInteger)section {
    NSDate *selectMonth = [[_minimumDate firstDayOfMonth] dateByAddMonths:section];
    NSString *monthString = [NSString stringWithFormat:@"%d/%d", (int)[selectMonth getYear], (int)[selectMonth getMonth]];
    return monthString;
}

- (NSString *)weekAndDayToExpBirthday:(NSDate *)date {
    if ([date daysFrom:_expBirthday] >= 0 || [date daysFrom:_pregDate] < 0) {
        return @"";
    }
    
    NSInteger week = [date weeksFrom:_pregDate];
    NSInteger day = [date daysFrom:_pregDate]%7;
    
    NSString *weekAndDayString = [NSString stringWithFormat:@"%dw%dd", (int)week, (int)day];
    return weekAndDayString;
}

- (NSInteger)pregMonthsInDate:(NSDate *)date {
    if ([date daysFrom:_expBirthday] >= 0 || [date daysFrom:_pregDate] < 0) {
        return 0;
    }
    
    NSInteger week = [date weeksFrom:_pregDate];
    NSInteger day = [date daysFrom:_pregDate]%7;

    if ((week+1)%4 == 0 && day == 6) {
        return week/4+1;
    }
    return 0;
}

@end
