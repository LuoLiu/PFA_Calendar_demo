//
//  ScheduleTableDataSource.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "ScheduleTableDataSource.h"
#import "ScheduleTableViewModel.h"

@interface ScheduleTableDataSource () 

@property (nonatomic, weak) ScheduleTableViewModel *viewModel;

@end

@implementation ScheduleTableDataSource

#pragma mark - Initialization

- (instancetype)initWithViewModel:(ScheduleTableViewModel *)viewModel {
    self = [super init];
    
    if (self) {
        _viewModel = viewModel;
    }
    
    return self;
}

@end
