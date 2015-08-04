//
//  ScheduleTableViewModel.m
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "ScheduleTableViewModel.h"
#import "ScheduleEvent.h"
#import "CalendarDate.h"
#import "NSDate+HYExtension.h"
#import "DateFormatterHelper.h"

@interface ScheduleTableViewModel ()

@property (strong, nonatomic) NSArray *eventList;
@property (strong, nonatomic) NSArray *dateList;
@property (assign, nonatomic) BOOL addEvenForSelf;

@end

@implementation ScheduleTableViewModel

#pragma mark - Initialization

- (instancetype)initWithEventList:(NSArray *)eventList{
    self = [super init];
    
    if (self) {
        ///////////test
        ScheduleEvent *event1 = [[ScheduleEvent alloc] init];
        event1.eventTitle = @"検診";
        event1.startDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/7/27 11:00:11"];
        event1.endDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/7/29 11:00:11"];
        event1.eventType = ScheduleEventTypeCheckup;
        event1.memo = @"ScheduleEvent";
        
        ScheduleEvent *event2 = [[ScheduleEvent alloc] init];
        event2.eventTitle = @"検診";
        event2.startDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/7/28 22:00:22"];
        event2.endDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/7/28 23:00:22"];
        event2.eventType = ScheduleEventTypeCheckup;
        event2.memo = @"";
        
        ScheduleEvent *event3 = [[ScheduleEvent alloc] init];
        event3.eventTitle = @"Test 3";
        event3.startDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/7/28 23:00:33"];
        event3.endDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/8/1 23:00:33"];
        event3.eventType = ScheduleEventTypeOthers;
        event3.isShare = YES;
        event3.memo = @"ScheduleEvent";
        
        ScheduleEvent *event4 = [[ScheduleEvent alloc] init];
        event4.eventTitle = @"Test Test 4";
        event4.startDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/6/1 10:54:33"];
        event4.endDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/6/2 10:54:33"];
        event4.eventType = ScheduleEventTypeOthers;
        event4.isShare = YES;
        event4.memo = @"ScheduleEvent";
        
        ScheduleEvent *event5 = [[ScheduleEvent alloc] init];
        event5.eventTitle = @"検診";
        event5.startDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/8/28 13:20:33"];
        event5.endDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/8/31 13:20:33"];
        event5.eventType = ScheduleEventTypeCheckup;
        event5.memo = @"ScheduleEvent";
        
        eventList = [NSArray arrayWithObjects:event1, event2, event3, event4, event5,nil];
        ///////////test
        
        _eventList = [self sortEventList:eventList byAscending:YES];
        _dateList = [self getDateList];
    }
    return self;
}

- (NSInteger)numberOfSections {
    return _dateList.count;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [self eventsForSection:section].count;
}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    return [_dateList objectAtIndex:section];
}

- (NSArray *)eventsForCalendarDate:(CalendarDate *)calendarDate {
    NSMutableArray *eventsForDate = [NSMutableArray array];
    NSString *dateString = [self dateTitleForCalendarDate:calendarDate];
    for (ScheduleEvent *event in self.eventList) {
        NSString *eventDateTitle = [self dateTitleForCalendarDate:event.calendarDate];
        if ([eventDateTitle isEqualToString:dateString]) {
            [eventsForDate addObject:event];
            if (event.isShare) {
                [eventsForDate addObject:event];
            }
        }
    }
    return eventsForDate;
}

- (NSArray *)eventsForSection:(NSInteger)section {
    NSMutableArray *eventsForSection = [NSMutableArray array];
    NSString *sectionTitle = [self titleForHeaderInSection:section];
    for (ScheduleEvent *event in self.eventList) {
        NSString *eventDateTitle = [self dateTitleForCalendarDate:event.calendarDate];
        if ([eventDateTitle isEqualToString:sectionTitle]) {
            [eventsForSection addObject:event];
            if (event.isShare) {
                [eventsForSection addObject:event];
            }
        }
    }

    return eventsForSection;
}

- (ScheduleEvent *)eventForIndexPath:(NSIndexPath *)indexPath {
    ScheduleEvent *cellEvent = [[self eventsForSection:indexPath.section] objectAtIndex:indexPath.row];
    return cellEvent;
}

- (NSString *)dateStringForIndexPath:(NSIndexPath *)indexPath {
    ScheduleEvent *event = [self eventForIndexPath:indexPath];
    return [[DateFormatterHelper hmDateFormatter] stringFromDate:event.startDate];
}

- (NSString *)planStringForIndexPath:(NSIndexPath *)indexPath {
    ScheduleEvent *event = [self eventForIndexPath:indexPath];
    return event.eventTitle;
}

- (UIImage *)imageForForIndexPath:(NSIndexPath *)indexPath {
    ScheduleEvent *event = [self eventForIndexPath:indexPath];
    if (event.eventType == ScheduleEventTypeCheckup) {
        return [UIImage imageNamed:@"icon_hospital_big"];//医院icon
    }
    else if (!event.isShare) {
        return [UIImage imageNamed:@"icon_mama_big"];//上传者icon
    }
    else if (event.isShare && !_addEvenForSelf){//&& 上传者
        _addEvenForSelf = YES;
        return [UIImage imageNamed:@"icon_mama_big"];//上传者icon
    }
    else {
        _addEvenForSelf = NO;
        return [UIImage imageNamed:@"icon_baba_big"];//对方icon
    }
}

- (NSArray *)sortEventList:(NSArray *)eventList byAscending:(BOOL)ascending {
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:ascending];
    NSArray *sortArray = [NSArray arrayWithObjects:descriptor, nil];
    NSArray *sortedArray = [eventList sortedArrayUsingDescriptors:sortArray];
    return sortedArray;
}

- (NSMutableArray *)getDateList {
    NSMutableArray *dateList = [NSMutableArray array];

    for (ScheduleEvent *event in self.eventList) {
        NSString *dateTitle = [self dateTitleForCalendarDate:event.calendarDate];
        if (![dateList containsObject:dateTitle]) {
            [dateList addObject:dateTitle];
        }
    }
    return dateList;
}

- (NSString *)dateTitleForCalendarDate:(CalendarDate *)calendarDate {
    //NSDate *eventDate = event.startDate;
    NSString *title = [[DateFormatterHelper mdDateFormatter] stringFromDate:calendarDate.date];
    if (calendarDate.isHoliday) {
        NSString *holidayName = [NSString stringWithString:calendarDate.holidayName];
        title = [title stringByAppendingString:holidayName];
    }
    return title;
}

@end
