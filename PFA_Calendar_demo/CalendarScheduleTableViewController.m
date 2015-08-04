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

@property (strong, nonatomic) ScheduleDetailTableViewController *scheduleDetailTableVC;
@property (assign, nonatomic) BOOL hasAnnounce;

@end

@implementation CalendarScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    _hasAnnounce = NO;
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

    if (self.scheduleEventList.count == 0) {
        if (_hasAnnounce) {
            return 2;
        }
        else {
            return 1;
        }
    }
    
    if (_hasAnnounce) {
        return self.scheduleEventList.count+1;
    }
    else {
        return self.scheduleEventList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.scheduleEventList.count == 0) {

        if (_hasAnnounce) {
            if (indexPath.row == 0) {
                AnnounceTableViewCell *announceCell = [tableView dequeueReusableCellWithIdentifier:@"AnnounceCell" forIndexPath:indexPath];
                announceCell.contentLabel.text = @"アナウンス";
                return announceCell;
            }
        }
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"NO envent.";
        return cell;
    }
    
    ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCalendarScheduleTableCellReuseIdentifier];
    ScheduleEvent *scheduleEvent= [[ScheduleEvent alloc] init];
    if (_hasAnnounce) {
        if (indexPath.row == 0) {
            AnnounceTableViewCell *announceCell = [tableView dequeueReusableCellWithIdentifier:@"AnnounceCell" forIndexPath:indexPath];
            announceCell.contentLabel.text = @"アナウンス";
            return announceCell;
        }
        
        scheduleEvent = [self.scheduleEventList objectAtIndex:indexPath.row-1];
    }
    else {
        scheduleEvent = [self.scheduleEventList objectAtIndex:indexPath.row];
    }
    cell.scheduleEvent = scheduleEvent;
    cell.dateLabel.text = [[DateFormatterHelper hmDateFormatter] stringFromDate:scheduleEvent.startDate];
    cell.planLabel.text = scheduleEvent.eventTitle;
    cell.iconImageView.image = [cell setCellIcon];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_bg"]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width, 22)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    NSString *scheduleDateString = [[DateFormatterHelper scheduleDateFormatter] stringFromDate:self.scheduleDate.date];
    if (self.scheduleDate.isHoliday) {
        NSString *holidayName = [NSString stringWithString:self.scheduleDate.holidayName];
        scheduleDateString = [scheduleDateString stringByAppendingString:holidayName];
    }
    titleLabel.text = scheduleDateString;
    
    [headerView addSubview:titleLabel];
    return headerView;
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
