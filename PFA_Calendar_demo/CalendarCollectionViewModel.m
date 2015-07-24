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

@property (strong, nonatomic) NSArray *dateList;
@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;

@end

@implementation CalendarCollectionViewModel

#pragma mark - Initialization

- (instancetype)initWithDateList:(NSArray *)dateList {
    self = [super init];
    
    if (self) {
        _dateList = dateList;
        _minimumDate = [dateList firstObject];
        _maximumDate = [dateList lastObject];
        ////////test
        _minimumDate = [NSDate dateWithYear:1970 month:1 day:1];
        _maximumDate = [NSDate dateWithYear:2099 month:12 day:31];
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
    NSUInteger    rows = indexPath.item % kCOLLECTIONVIEW_ROWS;
    NSUInteger columns = indexPath.item / kCOLLECTIONVIEW_ROWS;
    NSDate *date = [firstDayOfPage dateByAddDays:kWEEK_DAYS * rows + columns];
    
    return [date dateByIgnoringTimeComponents];
}

//- (NSDate *)monthForSection:(NSInteger)section {
//    NSDate *selectMonth = [[_minimumDate firstDayOfMonth] dateByAddMonths:section];
//    NSDate *date = [selectMonth dateByAddMonths:section];
//    
//    return [date dateByIgnoringTimeComponents];
//}

- (NSString *)setMonthLabelForSection:(NSInteger)section {
    NSDate *selectMonth = [[_minimumDate firstDayOfMonth] dateByAddMonths:section];
    NSString *monthString = [NSString stringWithFormat:@"%d/%d", (int)[selectMonth getYear], (int)[selectMonth getMonth]];
    return monthString;
}

@end
