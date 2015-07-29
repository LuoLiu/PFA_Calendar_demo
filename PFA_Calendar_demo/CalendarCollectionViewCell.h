//
//  CalendarCollectionViewCell.h
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CalendarCellState) {
    CalendarCellStatePlaceholder      = 0,
    CalendarCellStateNormal           = 1,
    CalendarCellStateSelected         = 2,
    CalendarCellStateToday            = 3,
    CalendarCellStateAnnounce         = 4,
    CalendarCellStateSaturday         = 5,
    CalendarCellStateSunday           = 6,
    CalendarCellStateHoliday          = 7,
    CalendarCellStateDogsDay          = 8,
    CalendarCellStateScheduleBirthday = 9,
    CalendarCellStateBirthday         = 10,

};

@class CalendarCollectionViewModel;

@interface CalendarCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekAndDayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dateIcon;
@property (weak, nonatomic) IBOutlet UIImageView *hospitalIcon;
@property (weak, nonatomic) IBOutlet UIImageView *mmIcon;
@property (weak, nonatomic) IBOutlet UIImageView *ppIcon;

@property (strong, nonatomic) CalendarCollectionViewModel *calenderViewModel;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSDate *month;
@property (assign, nonatomic) BOOL hasEvent;
@property (assign, nonatomic, getter=isPlaceholder) BOOL isPlaceholder;

- (void)configureCellAppearence;

@end
