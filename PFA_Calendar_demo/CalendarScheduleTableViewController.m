//
//  CalendarScheduleTableViewController.m
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "CalendarScheduleTableViewController.h"
#import "CalendarViewController.h"
#import "ScheduleDetailTableViewCell.h"
#import "ScheduleEvent.h"
#import "CalendarDate.h"
#import "NSDate+HYExtension.h"

#define kCalendarScheduleTableCellReuseIdentifier      @"ScheduleDetailTableCellIdentifier"

@interface CalendarScheduleTableViewController ()

@property (strong, nonatomic) NSMutableArray *scheduleEventList;

@end

@implementation CalendarScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///////获取特定日期的scheduleEventList
    _scheduleEventList = [NSMutableArray array];
    ///////////test
    
    ScheduleEvent *event1 = [[ScheduleEvent alloc] init];
    event1.eventTitle = @"Test 1";
    event1.startDate = [NSDate dateFromString:@"00:11" format:@"HH:mm"];
    [_scheduleEventList addObject:event1];
    
    ScheduleEvent *event2 = [[ScheduleEvent alloc] init];
    event2.eventTitle = @"Test 2";
    event2.startDate = [NSDate dateFromString:@"00:22" format:@"HH:mm"];
    [_scheduleEventList addObject:event2];
    ///////////test

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

    return self.scheduleEventList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCalendarScheduleTableCellReuseIdentifier];
    
    if (self.scheduleEventList.count != 0) {
        ScheduleEvent *scheduleEvent = [self.scheduleEventList objectAtIndex:indexPath.row];
        cell.dateLabel.text = [scheduleEvent.startDate stringWithFormat:@"HH:mm"];
        cell.planLabel.text = scheduleEvent.eventTitle;
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *weekDayString = [NSString stringWithFormat:@"（%@）", [self.scheduleDate.date dayInWeek]];
    NSString *scheduleDateString = [[self.scheduleDate.date stringWithFormat:@"MM月dd日"] stringByAppendingString:weekDayString];
    
    if (self.scheduleDate.isHoliday) {
        NSString *holidayName = [NSString stringWithString:self.scheduleDate.holidayName];
        scheduleDateString = [scheduleDateString stringByAppendingString:holidayName];
    }
    
    return scheduleDateString;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
