//
//  ScheduleTableViewModel.h
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ScheduleEvent;
@class CalendarDate;

@interface ScheduleTableViewModel : NSObject

- (instancetype)initWithEventList:(NSArray *)eventList;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)titleForHeaderInSection:(NSInteger)section;
- (ScheduleEvent *)eventForIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)eventsForCalendarDate:(CalendarDate *)calendarDate;
- (NSString *)dateStringForIndexPath:(NSIndexPath *)indexPath;
- (NSString *)planStringForIndexPath:(NSIndexPath *)indexPath;
- (UIImage *)imageForForIndexPath:(NSIndexPath *)indexPath;

@end
