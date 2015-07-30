//
//  ScheduleEvent.m
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "ScheduleEvent.h"
#import "CalendarDate.h"
#import "NSDate+HYExtension.h"

@implementation ScheduleEvent

- (CalendarDate *)calendarDate {
    CalendarDate *date = [[CalendarDate alloc] init];
    date.date = [NSDate dateWithYear:[self.startDate getYear] month:[self.startDate getMonth] day:[self.startDate getDay]];
    ///从服务器获取数据
    date.isHoliday = NO;
    date.isDogsDay = NO;
    date.holidayName = @"";
    return date;
}

@end
