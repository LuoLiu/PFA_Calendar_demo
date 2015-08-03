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
#import "ScheduleDetailTableViewController.h"
#import "ScheduleEvent.h"
#import "NSDate+HYExtension.h"
#import "DateFormatterHelper.h"

static NSString *kCalendarScheduleTableCellReuseIdentifier = @"ScheduleDetailTableCellIdentifier";

@interface ScheduleTableViewController ()

@property (strong, nonatomic) ScheduleDetailTableViewController *scheduleDetailTableVC;
@property (strong, nonatomic) ScheduleTableViewModel *viewModel;
@property (strong, nonatomic) NSArray *evenList;

@end

@implementation ScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///////////test
    ScheduleEvent *event1 = [[ScheduleEvent alloc] init];
    event1.eventTitle = @"Test 1";
    event1.startDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/7/27 11:00:11"];
    event1.eventType = ScheduleEventTypeCheckup;
    
    ScheduleEvent *event2 = [[ScheduleEvent alloc] init];
    event2.eventTitle = @"Test 2";
    event2.startDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/7/28 22:00:22"];
    event2.eventType = ScheduleEventTypeOthers;
    
    ScheduleEvent *event3 = [[ScheduleEvent alloc] init];
    event3.eventTitle = @"Test 3";
    event3.startDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/7/28 23:00:33"];
    event3.eventType = ScheduleEventTypeOthers;
    event3.isShare = YES;
    
    ScheduleEvent *event4 = [[ScheduleEvent alloc] init];
    event4.eventTitle = @"Test Test 4";
    event4.startDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/6/1 10:54:33"];
    event4.eventType = ScheduleEventTypeOthers;
    event4.isShare = YES;

    ScheduleEvent *event5 = [[ScheduleEvent alloc] init];
    event5.eventTitle = @"Test 5";
    event5.startDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/8/28 13:20:33"];
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
    ScheduleEvent *cellEvent = [_viewModel eventForIndexPath:indexPath];
    cell.scheduleEvent = cellEvent;
    cell.dateLabel.text = [_viewModel dateStringForIndexPath:indexPath];
    cell.planLabel.text = [_viewModel planStringForIndexPath:indexPath];
    cell.iconImageView.image = [_viewModel imageForForIndexPath:indexPath];
    ////////test
//        ScheduleEvent *cellEvent = [_viewModel eventForIndexPath:indexPath];
//        if (cellEvent.eventType == ScheduleEventTypeCheckup) {
//            cell.iconImageView.backgroundColor = [UIColor yellowColor];//test
//        }
//        else if (!cellEvent.isShare) {
//            cell.iconImageView.backgroundColor = [UIColor redColor];//test
//        }
//        else {
//            //两个cell
//        }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showScheduleDetail"]) {
        self.scheduleDetailTableVC = segue.destinationViewController;
        ScheduleTableViewCell *cell = sender;
        self.scheduleDetailTableVC.scheduleEvent = cell.scheduleEvent;
    }
}

@end
