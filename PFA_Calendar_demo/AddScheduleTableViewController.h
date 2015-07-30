//
//  AddScheduleTableViewController.h
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddScheduleTableViewController;
@class ScheduleEvent;

@protocol AddScheduleTableViewControllerDelegate <NSObject>

- (void)getNewScheduleEvent:(ScheduleEvent *)scheduleEvent;

@end

@interface AddScheduleTableViewController : UITableViewController

@property (weak, nonatomic) id<AddScheduleTableViewControllerDelegate> delegate;

@end
