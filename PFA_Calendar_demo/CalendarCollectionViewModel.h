//
//  CalendarCollectionViewModel.h
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CalendarCollectionViewModel : NSObject

@property (strong, nonatomic) NSArray *dateList;
@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;
@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonatomic) NSDate *selectedDate;
@property (strong, nonatomic) NSDate *currentMonth;

///妊娠日
@property (strong, nonatomic) NSDate *pregDate;
///出産予定日
@property (strong, nonatomic) NSDate *expBirthday;
///誕生日(出生日)
@property (strong, nonatomic) NSDate *birthday;


- (instancetype)initWithDateList:(NSArray *)dateList;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (NSDate *)dateForIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathForDate:(NSDate *)date;
//- (NSDate *)monthForSection:(NSInteger)section;
- (NSString *)setMonthLabelForSection:(NSInteger)section;
- (BOOL)isDateInRange:(NSDate *)date;
- (void)setSelectedDate:(NSDate *)selectedDate animate:(BOOL)animate;
- (NSString *)weekAndDayToExpBirthday:(NSDate *)date;

@end
