//
//  CalendarCollectionViewModel.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "CalendarCollectionViewModel.h"
#import "NSDate+PFAExtension.h"

#define kWEEK_DAYS           (7)
#define kCOLLECTIONVIEW_ROWS (6)
#define kFIRSTWEEKDAY        (1) //Sunday(1),Monday(2)...

@interface CalendarCollectionViewModel ()

@end

@implementation CalendarCollectionViewModel

#pragma mark - Initialization

- (instancetype)initWithDateList:(NSArray *)dateList {
    self = [super init];
    
    if (self) {
        _dateList = dateList;
        _minimumDate  = [dateList firstObject];
        _maximumDate  = [dateList lastObject];
        _currentDate  = [NSDate date].dateByIgnoringTimeComponents;
        _currentMonth = [_currentDate copy];
        ////////test
        _minimumDate = [NSDate dateWithYear:1970 month:1 day:1];
        _maximumDate = [NSDate dateWithYear:2099 month:12 day:31];
        _pregDate    = [NSDate dateWithYear:2015 month:3 day:5];
        _expBirthday = [NSDate dateWithYear:2015 month:12 day:25];
        ////////test
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
//    NSIndexPath *selectedIndexPath = [self indexPathForDate:selectedDate];
//    if ([self collectionView:_collectionView shouldSelectItemAtIndexPath:selectedIndexPath]) {
//        if (_collectionView.indexPathsForSelectedItems.count && _selectedDate) {
//            NSIndexPath *currentIndexPath = [self indexPathForDate:_selectedDate];
//            [_collectionView deselectItemAtIndexPath:currentIndexPath animated:YES];
//            [self collectionView:_collectionView didDeselectItemAtIndexPath:currentIndexPath];
//        }
//        [_collectionView selectItemAtIndexPath:selectedIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
//        [self collectionView:_collectionView didSelectItemAtIndexPath:selectedIndexPath];
//    }
//    if (!_collectionView.tracking && !_collectionView.decelerating) {
//        [self willChangeValueForKey:@"currentMonth"];
//        _currentMonth = [selectedDate copy];
//        if (!_supressEvent) {
//            _supressEvent = YES;
//            [self currentMonthDidChange];
//            _supressEvent = NO;
//        }
        [self didChangeValueForKey:@"currentMonth"];
//        [self scrollToDate:selectedDate animate:animate];
//    }
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
        _currentMonth = currentMonth;//
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

@end
