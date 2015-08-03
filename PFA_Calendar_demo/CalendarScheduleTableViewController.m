//
//  CalendarScheduleTableViewController.m
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "CalendarScheduleTableViewController.h"
#import "CalendarViewController.h"
#import "ScheduleDetailTableViewController.h"
#import "ScheduleTableViewCell.h"
#import "AnnounceTableViewCell.h"
#import "ScheduleEvent.h"
#import "CalendarDate.h"
#import "NSDate+HYExtension.h"
#import "DateFormatterHelper.h"

static NSString *kCalendarScheduleTableCellReuseIdentifier = @"ScheduleDetailTableCellIdentifier";

@interface CalendarScheduleTableViewController ()

@property (strong, nonatomic) NSMutableArray *scheduleEventList;
@property (strong, nonatomic) ScheduleDetailTableViewController *scheduleDetailTableVC;
@property (assign, nonatomic) BOOL hasAnnounce;

@end

@implementation CalendarScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    ///////获取特定日期的scheduleEventList
    _scheduleEventList = [NSMutableArray array];
    ///////////test
    
    ScheduleEvent *event1 = [[ScheduleEvent alloc] init];
    event1.eventTitle = @"Test 1";
    event1.startDate = [[DateFormatterHelper hmDateFormatter] dateFromString:@"00:11"];
    [_scheduleEventList addObject:event1];
    
    ScheduleEvent *event2 = [[ScheduleEvent alloc] init];
    event2.eventTitle = @"Test 2";
    event2.startDate = [[DateFormatterHelper hmDateFormatter] dateFromString:@"00:22"];
    [_scheduleEventList addObject:event2];
    
    ScheduleEvent *event3 = [[ScheduleEvent alloc] init];
    event3.eventTitle = @"Test 3";
    event3.startDate = [[DateFormatterHelper hmDateFormatter] dateFromString:@"00:33"];
    [_scheduleEventList addObject:event3];
    ///////////test
    _hasAnnounce = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (_hasAnnounce) {
        return self.scheduleEventList.count+1;
    }
    else {
        return self.scheduleEventList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCalendarScheduleTableCellReuseIdentifier];
    ScheduleEvent *scheduleEvent= [[ScheduleEvent alloc] init];
    if (_hasAnnounce) {
        if (indexPath.row == 0) {
            AnnounceTableViewCell *announceCell = [tableView dequeueReusableCellWithIdentifier:@"AnnounceCell" forIndexPath:indexPath];
            announceCell.contentLabel.text = @"アナウンス";
            return announceCell;
        }
        
        if (self.scheduleEventList.count != 0) {
            scheduleEvent = [self.scheduleEventList objectAtIndex:indexPath.row-1];
        }
    }
    else if (self.scheduleEventList.count != 0){
        scheduleEvent = [self.scheduleEventList objectAtIndex:indexPath.row];
    }
    cell.scheduleEvent = scheduleEvent;
    cell.dateLabel.text = [[DateFormatterHelper hmDateFormatter] stringFromDate:scheduleEvent.startDate];
    cell.planLabel.text = scheduleEvent.eventTitle;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *scheduleDateString = [[DateFormatterHelper scheduleDateFormatter] stringFromDate:self.scheduleDate.date];
    if (self.scheduleDate.isHoliday) {
        NSString *holidayName = [NSString stringWithString:self.scheduleDate.holidayName];
        scheduleDateString = [scheduleDateString stringByAppendingString:holidayName];
    }
    
    return scheduleDateString;
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
