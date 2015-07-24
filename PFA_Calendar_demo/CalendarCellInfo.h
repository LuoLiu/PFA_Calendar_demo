//
//  CalendarCellInfo.h
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <Mantle/Mantle.h>

//typedef NS_ENUM(NSInteger, CalendarCellState) {
//    CalendarCellStateNormal           = 0,
//    CalendarCellStateSelected         = 1,
//    CalendarCellStateToday            = 2,
//    CalendarCellStateAnnounce         = 3,
//    CalendarCellStateSaturday         = 4,
//    CalendarCellStateSunday           = 5,
//    CalendarCellStateHoliday          = 6,
//    CalendarCellStateDogsDay           = 7,
//    CalendarCellStateScheduleBirthday = 8,
//    CalendarCellStateBirthday         = 9,
//
//};

@interface CalendarCellInfo : NSObject

///日付
///YYYY/MM/DDの形式
@property (copy, nonatomic) NSString *date;

///戌の日
///0: 通常日、1: 戌の日
@property (nonatomic) BOOL isDogsDay;

///祝日
///0: 通常日、1: 祝日
@property (nonatomic) BOOL isHoliday;

///祝日名
@property (copy, nonatomic) NSString *holidayName;

@end
