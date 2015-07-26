//
//  CalendarCollectionViewCell.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "CalendarCollectionViewCell.h"
#import "NSDate+PFAExtension.h"
#import "CalendarCollectionViewModel.h"

#define kCellSelectedColor      [UIColor redColor]
#define kCellTodayColor         [UIColor blueColor]
#define kCellPlaceholderColor   [UIColor colorWithWhite:0.9 alpha:1]
#define kCellAnnounceColor      [UIColor yellowColor]

@interface CalendarCollectionViewCell ()

@property (strong, nonatomic) NSMutableDictionary *backgroundColors;


@end

@implementation CalendarCollectionViewCell

- (void)awakeFromNib {
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    _backgroundColors = [NSMutableDictionary dictionaryWithCapacity:4];
    _backgroundColors[@(CalendarCellStatePlaceholder)] = kCellPlaceholderColor;
    _backgroundColors[@(CalendarCellStateNormal)]      = [UIColor clearColor];
    _backgroundColors[@(CalendarCellStateSelected)]    = kCellSelectedColor;
    _backgroundColors[@(CalendarCellStateToday)]       = kCellTodayColor;
    _backgroundColors[@(CalendarCellStateAnnounce)]    = kCellAnnounceColor;
}

-(void)prepareForReuse {
    self.selected = NO;
    self.backgroundColor = _backgroundColors[@(CalendarCellStateNormal)];
    self.hospitalIcon.hidden = YES;
    self.mmIcon.hidden = YES;
    self.ppIcon.hidden = YES;
}

- (void)configureCellAppearence {
    self.backgroundColor = [self colorForCurrentStateInDictionary:_backgroundColors];
    self.hospitalIcon.hidden = YES;
    self.mmIcon.hidden = YES;
    self.ppIcon.hidden = YES;
}

- (UIColor *)colorForCurrentStateInDictionary:(NSDictionary *)dictionary
{
    if (self.selected) {
        if (self.isToday) {
            return dictionary[@(CalendarCellStateToday)];
        }
        else {
            return dictionary[@(CalendarCellStateSelected)];
        }
    }
    
    if (self.isPlaceholder) {
        return dictionary[@(CalendarCellStatePlaceholder)];
    }

    return dictionary[@(CalendarCellStateNormal)];
}

- (BOOL)isPlaceholder
{
    return ![self.date isEqualToDateForMonth:self.month];
}

- (BOOL)isToday
{
    return [self.date isEqualToDateForDay:_calenderViewModel.currentDate];
}

- (BOOL)isWeekend
{
    return [self.date weekday] == 1 || [self.date weekday] == 7;
}

@end
