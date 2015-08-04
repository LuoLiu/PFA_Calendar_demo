//
//  CalendarScheduleTableViewController.h
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalendarDate;

@interface CalendarScheduleTableViewController : UITableViewController

@property (strong, nonatomic) CalendarDate *scheduleDate;
@property (strong, nonatomic) NSArray *scheduleEventList;

@end
