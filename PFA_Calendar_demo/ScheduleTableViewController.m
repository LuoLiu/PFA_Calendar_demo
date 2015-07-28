//
//  ScheduleTableViewController.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "ScheduleTableViewController.h"
#import "ScheduleDetailTableViewCell.h"
#import "ScheduleTableViewModel.h"
#import "ScheduleEvent.h"

#define kCalendarScheduleTableCellReuseIdentifier    @"ScheduleDetailTableCellIdentifier"

@interface ScheduleTableViewController ()

@property (strong, nonatomic) ScheduleTableViewModel *viewModel;
@property (strong, nonatomic) NSArray *evenList;

@end

@implementation ScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///////////test
    ScheduleEvent *event1 = [[ScheduleEvent alloc] init];
    event1.eventTitle = @"Test 1";
    event1.startDate = @"2015/7/27 11:00:11";
    
    ScheduleEvent *event2 = [[ScheduleEvent alloc] init];
    event2.eventTitle = @"Test 2";
    event2.startDate = @"2015/7/27 22:00:22";
    
    ScheduleEvent *event3 = [[ScheduleEvent alloc] init];
    event3.eventTitle = @"Test 3";
    event3.startDate = @"2015/7/28 23:00:33";
    
    _evenList = [NSArray arrayWithObjects:event1, event2, event3, nil];
    ///////////test

    _viewModel = [[ScheduleTableViewModel alloc] initWithEventList:_evenList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_viewModel numberOfRowsInSection:section];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_viewModel titleForHeaderInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ScheduleDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCalendarScheduleTableCellReuseIdentifier];
    
    cell.planLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row];
    return cell;
}


@end
