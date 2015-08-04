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

#define kCellPlaceholderColor   [UIColor clearColor]
#define kCellNormalColor        [UIColor whiteColor]

#define kCellNormalTextColor        [UIColor blackColor]
#define kCellPlaceholderTextColor   [UIColor colorWithWhite:0.5 alpha:1]
#define kCellSaturdayTextColor      [UIColor blueColor]
#define kCellSundayTextColor        [UIColor redColor]
#define kCellHolidayTextColor       [UIColor redColor]

@interface CalendarCollectionViewCell ()

@property (strong, nonatomic) NSMutableDictionary *backgroundColors;
@property (strong, nonatomic) NSMutableDictionary *dateLabelColors;

@end

@implementation CalendarCollectionViewCell

- (void)awakeFromNib {
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.monthIcon.backgroundColor = [UIColor clearColor];
    
    self.hospitalIcon.image = [UIImage imageNamed:@"icon_hospital"];
    self.mmIcon.image       = [UIImage imageNamed:@"icon_mama"];
    self.ppIcon.image       = [UIImage imageNamed:@"icon_baba"];

    _backgroundColors = [NSMutableDictionary dictionary];
    _backgroundColors[@(CalendarCellStatePlaceholder)] = kCellPlaceholderColor;
    _backgroundColors[@(CalendarCellStateNormal)]      = kCellNormalColor;
    
    _dateLabelColors = [NSMutableDictionary dictionary];
    _dateLabelColors[@(CalendarCellStateNormal)]        = kCellNormalTextColor;
    _dateLabelColors[@(CalendarCellStatePlaceholder)]   = kCellPlaceholderTextColor;
    _dateLabelColors[@(CalendarCellStateSaturday)]      = kCellSaturdayTextColor;
    _dateLabelColors[@(CalendarCellStateSunday)]        = kCellSundayTextColor;
    _dateLabelColors[@(CalendarCellStateHoliday)]       = kCellHolidayTextColor;
}

-(void)prepareForReuse {
    self.eventList = nil;
    self.selected = NO;
    self.backgroundColor = _backgroundColors[@(CalendarCellStateNormal)];
    self.hospitalIcon.hidden = YES;
    self.mmIcon.hidden = YES;
    self.ppIcon.hidden = YES;
    self.monthIcon.image = nil;
}

- (void)configureCellAppearence {
    self.weekAndDayLabel.hidden = self.isPlaceholder;
    
    self.backgroundColor = [self backgroundColorForCurrentStateInDictionary:_backgroundColors];
    self.backgroundImageView.image = [self setBackgroundImage];
    self.dateLabel.textColor = [self textColorForCurrentStateInDictionary:_dateLabelColors];

    self.hospitalIcon.hidden = YES;
    self.mmIcon.hidden = YES;
    self.ppIcon.hidden = YES;
    
    self.weekAndDayLabel.text = [_calenderViewModel weekAndDayToExpBirthday:self.calendarDate.date];
    self.monthIcon.image = [self setmonthIconImage];

    [self configureCellIcons];
}

- (UIImage *)setmonthIconImage {
    if (self.isPlaceholder) {
        return nil;
    }
    if ([self.calendarDate.date isEqualToDateForDay:_calenderViewModel.expBirthday]) {
        return [UIImage imageNamed:@"icon_dueday"];
    }
    else if ([_calenderViewModel pregMonthsInDate:self.calendarDate.date] > 0) {
        NSInteger pregMonth = [_calenderViewModel pregMonthsInDate:self.calendarDate.date];
        switch (pregMonth) {
            case 1:
                return [UIImage imageNamed:@"icon_1month"];
                break;
            case 2:
                return [UIImage imageNamed:@"icon_2month"];
                break;
            case 3:
                return [UIImage imageNamed:@"icon_3month"];
                break;
            case 4:
                return [UIImage imageNamed:@"icon_4month"];
                break;
            case 5:
                return [UIImage imageNamed:@"icon_5month"];
                break;
            case 6:
                return [UIImage imageNamed:@"icon_6month"];
                break;
            case 7:
                return [UIImage imageNamed:@"icon_7month"];
                break;
            case 8:
                return [UIImage imageNamed:@"icon_8month"];
                break;
            case 9:
                return [UIImage imageNamed:@"icon_9month"];
                break;
                
            default:
                break;
        }
    }
    self.monthIcon.backgroundColor = [UIColor clearColor];
    return nil;
}

- (UIImage *)setBackgroundImage {
    if (self.isPlaceholder) {
        return nil;
    }
    else if ([self.calendarDate.date isEqualToDate:_calenderViewModel.expBirthday]) {
        return [UIImage imageNamed:@"dueday_icon"];
    }
    else if ([self.calendarDate.date isEqualToDate:_calenderViewModel.birthday]) {
        return [UIImage imageNamed:@"birthday_icon"];
    }
    else if ([self.calendarDate isDogsDay]) {
        return [UIImage imageNamed:@"dogday_icon"];
    }
    else if (self.isToday) {
        return [UIImage imageNamed:@"today_bg"];
    }
    else if (self.selected) {
        return [UIImage imageNamed:@"dueday_bg"];
    }
    else if (self.hasAnnounce) {
        return [UIImage imageNamed:@"noteday_bg"];
    }
    return nil;
}

- (void)configureCellIcons {
    if (self.isPlaceholder) {
        return;
    }
    for (ScheduleEvent *event in self.eventList) {
        if (event.eventType == ScheduleEventTypeCheckup) {
            self.hospitalIcon.hidden = NO;
            continue;
        }
        
        if (event.isShare) {
            self.mmIcon.hidden = NO;
            self.ppIcon.hidden = NO;
        }
        else {
            self.mmIcon.hidden = NO;/////显示提交者icon
        }
    }
}

- (UIColor *)backgroundColorForCurrentStateInDictionary:(NSDictionary *)dictionary {
    if (self.isPlaceholder) {
        return dictionary[@(CalendarCellStatePlaceholder)];
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
    if (self.calendarDate.isHoliday) {
        return dictionary[@(CalendarCellStateHoliday)];
    }
    
    return dictionary[@(CalendarCellStateNormal)];
}

//- (BOOL)hasEvent {
//    return self.eventList.count != 0;
//}

- (BOOL)hasAnnounce {
    return NO;////Announce
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
