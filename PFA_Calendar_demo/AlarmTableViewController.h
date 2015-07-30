//
//  AlarmTableViewController.h
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlarmTableViewController;

@protocol AlarmTableViewControllerDelegate <NSObject>

- (void)alarmMinutes:(NSInteger)alarmMinutes;

@end

@interface AlarmTableViewController : UITableViewController

@property (strong, nonatomic) NSDate *startDate;
@property (assign, nonatomic) id<AlarmTableViewControllerDelegate> delegate;

@end
