//
//  ScheduleTableViewModel.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "ScheduleTableViewModel.h"
#import "ScheduleTableDataSource.h"
#import "ScheduleTableDelegate.h"

@interface ScheduleTableViewModel ()

@property (nonatomic, strong) NSArray *scheduleList;

@end

@implementation ScheduleTableViewModel

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _dataSource = [[ScheduleTableDataSource alloc] initWithViewModel:self];
        _delegate = [[ScheduleTableDelegate alloc] initWithViewModel:self];
    }
    return self;
}

- (NSInteger)numberOfSections {
    return 0;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 0;

}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    return @"";

    
}

@end
