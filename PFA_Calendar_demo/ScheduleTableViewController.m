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
@property (strong, nonatomic) NSArray *eventList;

@end

@implementation ScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self bindView];
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    if (section == 0) {
        headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_bg_red"]];
    }
    else {
        headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_bg"]];
    }
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width, 22)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = [_viewModel titleForHeaderInSection:section];
    [headerView addSubview:titleLabel];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCalendarScheduleTableCellReuseIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - Configure

- (void)bindView {
    NSArray *eventList = [NSArray array];
    _viewModel = [[ScheduleTableViewModel alloc] initWithEventList:eventList];
}

- (void)configureCell:(ScheduleTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ScheduleEvent *cellEvent = [_viewModel eventForIndexPath:indexPath];
    cell.scheduleEvent = cellEvent;
    cell.dateLabel.text = [_viewModel dateStringForIndexPath:indexPath];
    cell.planLabel.text = [_viewModel planStringForIndexPath:indexPath];
    cell.iconImageView.image = [_viewModel imageForForIndexPath:indexPath];
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
