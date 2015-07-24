//
//  ScheduleTableDataSource.h
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ScheduleTableViewModel;

@interface ScheduleTableDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithViewModel:(ScheduleTableViewModel *)viewModel;

@end
