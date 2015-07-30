//
//  CalendarCollectionViewCell.m
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "CalendarCollectionViewCell.h"
#import "NSDate+HYExtension.h"
#import "CalendarCollectionViewModel.h"
#import "CalendarDate.h"
#import "ScheduleEvent.h"

#define kCellSelectedColor      [UIColor redColor]
#define kCellTodayColor         [UIColor blueColor]
#define kCellPlaceholderColor   [UIColor colorWithWhite:0.9 alpha:1]
#define kCellNormalColor        [UIColor whiteColor]
#define kCellAnnounceColor      [UIColor yellowColor]

#define kCellNormalTextColor        [UIColor blackColor]
#define kCellPlaceholderTextColor   [UIColor colorWithWhite:0.5 alpha:1]
#define kCellSaturdayTextColor      [UIColor blueColor]
#define kCellSundayTextColor        [UIColor redColor]

@interface CalendarCollectionViewCell ()

@property (strong, nonatomic) NSMutableDictionary *backgroundColors;
@property (strong, nonatomic) NSMutableDictionary *dateLabelColors;

@end

@implementation CalendarCollectionViewCell

- (void)awakeFromNib {
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    _backgroundColors = [NSMutableDictionary dictionary];
    _backgroundColors[@(CalendarCellStatePlaceholder)] = kCellPlaceholderColor;
    _backgroundColors[@(CalendarCellStateNormal)]      = kCellNormalColor;
    _backgroundColors[@(CalendarCellStateSelected)]    = kCellSelectedColor;
    _backgroundColors[@(CalendarCellStateToday)]       = kCellTodayColor;
    _backgroundColors[@(CalendarCellStateAnnounce)]    = kCellAnnounceColor;
    
    _dateLabelColors = [NSMutableDictionary dictionary];
    _dateLabelColors[@(CalendarCellStateNormal)]        = kCellNormalTextColor;
    _dateLabelColors[@(CalendarCellStatePlaceholder)]   = kCellPlaceholderTextColor;
    _dateLabelColors[@(CalendarCellStateSaturday)]      = kCellSaturdayTextColor;
    _dateLabelColors[@(CalendarCellStateSunday)]        = kCellSundayTextColor;
}

-(void)prepareForReuse {
    self.selected = NO;
    self.backgroundColor = _backgroundColors[@(CalendarCellStateNormal)];
    self.hospitalIcon.hidden = YES;
    self.mmIcon.hidden = YES;
    self.ppIcon.hidden = YES;
}

- (void)configureCellAppearence {
    
    self.weekAndDayLabel.hidden = self.isPlaceholder;
//    self.userInteractionEnabled = !self.isPlaceholder;
    
    self.backgroundColor = [self backgroundColorForCurrentStateInDictionary:_backgroundColors];
    self.dateLabel.textColor = [self textColorForCurrentStateInDictionary:_dateLabelColors];

    self.hospitalIcon.hidden = YES;
    self.mmIcon.hidden = YES;
    self.ppIcon.hidden = YES;
    
    self.weekAndDayLabel.text = [_calenderViewModel weekAndDayToExpBirthday:self.calendarDate.date];
}

- (UIColor *)backgroundColorForCurrentStateInDictionary:(NSDictionary *)dictionary {
    if (self.isPlaceholder) {
        return dictionary[@(CalendarCellStatePlaceholder)];
    }
    if (self.isToday) {
        return dictionary[@(CalendarCellStateToday)];
    }
    if (self.selected) {
        return dictionary[@(CalendarCellStateSelected)];
    }
    
    return dictionary[@(CalendarCellStateNormal)];
}

- (UIColor *)textColorForCurrentStateInDictionary:(NSDictionary *)dictionary {
    if (self.isPlaceholder) {
        return dictionary[@(CalendarCellStatePlaceholder)];
    }
    if (self.isSaturday) {
        return dictionary[@(CalendarCellStateSaturday)];
    }
    if (self.isSunday) {
        return dictionary[@(CalendarCellStateSunday)];
    }
    
    return dictionary[@(CalendarCellStateNormal)];
}

- (BOOL)hasEvent {
    return [self.scheduleEvent.startDate isEqualToDateForDay:self.calendarDate.date];
}

- (BOOL)isPlaceholder {
    return ![self.calendarDate.date isEqualToDateForMonth:self.month];
}

- (BOOL)isToday {
    return [self.calendarDate.date isEqualToDateForDay:_calenderViewModel.currentDate];
}

- (BOOL)isSaturday {
    return [self.calendarDate.date weekday] == 7;
}

- (BOOL)isSunday {
    return [self.calendarDate.date weekday] == 1;
}
@end
