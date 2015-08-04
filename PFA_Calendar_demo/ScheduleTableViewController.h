//
//  ScheduleTableViewController.h
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScheduleTableViewControllerDelegate <NSObject>

- (void)isTodayDismiss:(BOOL)isTodayDismiss;

@end

@interface ScheduleTableViewController : UITableViewController

@property (weak, nonatomic) id<ScheduleTableViewControllerDelegate> delegate;

@end
