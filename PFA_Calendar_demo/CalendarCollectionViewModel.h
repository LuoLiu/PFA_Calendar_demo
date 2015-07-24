//
//  CalendarCollectionViewModel.h
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CalendarCellInfo;

@interface CalendarCollectionViewModel : NSObject

- (instancetype)initWithDateList:(NSArray *)dateList;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (NSDate *)dateForIndexPath:(NSIndexPath *)indexPath;
//- (NSDate *)monthForSection:(NSInteger)section;
- (NSString *)setMonthLabelForSection:(NSInteger)section;

@end
