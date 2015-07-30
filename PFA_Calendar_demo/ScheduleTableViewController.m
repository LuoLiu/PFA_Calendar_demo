//
//  ScheduleTableViewController.m
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "ScheduleTableViewController.h"
#import "ScheduleTableViewCell.h"
#import "ScheduleTableViewModel.h"
#import "ScheduleEvent.h"
#import "NSDate+HYExtension.h"

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
    event1.startDate = [NSDate dateFromString:@"2015/7/27 11:00:11" format:@"yyyy/MM/dd HH:mm:ss"];
    event1.eventType = ScheduleEventTypeCheckup;
    
    ScheduleEvent *event2 = [[ScheduleEvent alloc] init];
    event2.eventTitle = @"Test 2";
    event2.startDate = [NSDate dateFromString:@"2015/7/28 22:00:22" format:@"yyyy/MM/dd HH:mm:ss"];
    event2.eventType = ScheduleEventTypeOthers;
    
    ScheduleEvent *event3 = [[ScheduleEvent alloc] init];
    event3.eventTitle = @"Test 3";
    event3.startDate = [NSDate dateFromString:@"2015/7/28 23:00:33" format:@"yyyy/MM/dd HH:mm:ss"];
    event3.eventType = ScheduleEventTypeOthers;
    event3.isShare = YES;
    
    ScheduleEvent *event4 = [[ScheduleEvent alloc] init];
    event4.eventTitle = @"Test Test 4";
    event4.startDate = [NSDate dateFromString:@"2015/6/1 10:54:33" format:@"yyyy/MM/dd HH:mm:ss"];
    event4.eventType = ScheduleEventTypeOthers;
    event4.isShare = YES;

    ScheduleEvent *event5 = [[ScheduleEvent alloc] init];
    event5.eventTitle = @"Test 5";
    event5.startDate = [NSDate dateFromString:@"2015/8/28 13:20:33" format:@"yyyy/MM/dd HH:mm:ss"];
    event5.eventType = ScheduleEventTypeCheckup;
    
    _evenList = [NSArray arrayWithObjects:event1, event2, event3, event4, event5,nil];
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
    
    ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCalendarScheduleTableCellReuseIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(ScheduleTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.dateLabel.text = [_viewModel dateStringForIndexPath:indexPath];
    cell.planLabel.text = [_viewModel planStringForIndexPath:indexPath];
    cell.iconImageView.image = [_viewModel imageForForIndexPath:indexPath];
    ////////test
        ScheduleEvent *cellEvent = [_viewModel eventForIndexPath:indexPath];
        if (cellEvent.eventType == ScheduleEventTypeCheckup) {
            cell.iconImageView.backgroundColor = [UIColor yellowColor];//test
        }
        else if (!cellEvent.isShare) {
            cell.iconImageView.backgroundColor = [UIColor redColor];//test
        }
        else {
            //两个cell
        }
}

@end
