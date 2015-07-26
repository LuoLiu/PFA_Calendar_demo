//
//  CalendarCellInfo.h
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CalendarCellInfo : NSObject

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

@end
