//
//  ScheduleTableViewModel.h
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ScheduleTableViewModel : NSObject


@property (strong, nonatomic) id<UITableViewDataSource> dataSource;
@property (strong, nonatomic) id<UITableViewDelegate> delegate;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)titleForHeaderInSection:(NSInteger)section;

@end
