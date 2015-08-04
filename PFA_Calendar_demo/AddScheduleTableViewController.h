//
//  AddScheduleTableViewController.h
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScheduleEvent;

@interface AddScheduleTableViewController : UITableViewController

@property (strong, nonatomic) ScheduleEvent *scheduleEvent;
@property (assign, nonatomic) BOOL isEditSchedule;

@end
