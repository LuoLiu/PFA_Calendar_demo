//
//  ScheduleTableViewModel.m
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "ScheduleTableViewModel.h"
#import "ScheduleEvent.h"
#import "NSDate+HYExtension.h"

@interface ScheduleTableViewModel ()

@property (strong, nonatomic) NSArray *eventList;
@property (strong, nonatomic) NSArray *dateList;

@end

@implementation ScheduleTableViewModel

#pragma mark - Initialization

- (instancetype)initWithEventList:(NSArray *)eventList{
    self = [super init];
    
    if (self) {
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

- (NSArray *)eventsForSection:(NSInteger)section {
    NSMutableArray *eventsForSection = [NSMutableArray array];
    NSString *sectionTitle = [self titleForHeaderInSection:section];
    for (ScheduleEvent *event in self.eventList) {
        NSString *eventDateTitle = [self dateTitleForEvent:event];
        if ([eventDateTitle isEqualToString:sectionTitle]) {
            [eventsForSection addObject:event];
        }
    }
    
    return eventsForSection;
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
        NSString *dateTitle = [self dateTitleForEvent:event];
        if (![dateList containsObject:dateTitle]) {
            [dateList addObject:dateTitle];
        }
    }
    return dateList;
}

- (NSString *)dateTitleForEvent:(ScheduleEvent *)event {
    NSDate *eventDate = [NSDate dateFromString:event.startDate format:@"yyyy/MM/dd HH:mm:ss"];
    NSString *weekDayString = [NSString stringWithFormat:@"（%@）", [eventDate dayInWeek]];
    NSString *title = [[eventDate stringWithFormat:@"MM月dd日"] stringByAppendingString:weekDayString];
    if (eventDate.isHoliday) {
        NSString *holidayName = [NSString stringWithString:eventDate.holidayName];
        title = [title stringByAppendingString:holidayName];
    }
    return title;
}

@end
