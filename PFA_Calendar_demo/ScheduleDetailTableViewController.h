//
//  ScheduleDetailTableViewController.h
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 15/7/30.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScheduleEvent;

@interface ScheduleDetailTableViewController : UITableViewController

@property (strong, nonatomic) ScheduleEvent *scheduleEvent;

@end
