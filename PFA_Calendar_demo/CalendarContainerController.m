//
//  CalendarContainerController.m
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 15/7/23.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "CalendarContainerController.h"
#import "CalendarViewController.h"
#import "CalendarScheduleTableViewController.h"

@interface CalendarContainerController () <CalendarViewControllerDelegate>

@property (strong, nonatomic) CalendarViewController *calendarVC;
@property (strong, nonatomic) CalendarScheduleTableViewController *calendarScheduleVC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarViewContainerHeightConstaint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewContainerHeightConstaint;

@end

@implementation CalendarContainerController

- (void)calendarCurrentMonthStringDidChangeTo:(NSString *)monthString {
    [self.delegate calendarCurrentMonthStringDidChangeTo:monthString];
}

-(void)isCurrentMonth:(BOOL)isCurrentMonth {
    [self.delegate isCurrentMonth:isCurrentMonth];
}

-(void)getScheduleDate:(CalendarDate *)calendarDate andEventList:(NSArray *)eventList{
    self.calendarScheduleVC.scheduleDate = calendarDate;
    self.calendarScheduleVC.scheduleEventList = eventList;
    [self.calendarScheduleVC.tableView reloadData];
    [self updateViewConstraints];
}

-(void)updateViewConstraints {
    [super updateViewConstraints];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if (screenSize.width == 375) {
        self.calendarViewContainerHeightConstaint.constant = 350;
        
        if (self.calendarScheduleVC.tableView.contentSize.height < 92) {
            self.tableViewContainerHeightConstaint.constant = self.calendarScheduleVC.tableView.contentSize.height;
        }
        else {
            self.tableViewContainerHeightConstaint.constant = 92;
        }
    }
    else if (screenSize.width == 320)
    {
        self.calendarViewContainerHeightConstaint.constant = 300;

        if (self.calendarScheduleVC.tableView.contentSize.height < 57) {
            self.tableViewContainerHeightConstaint.constant = self.calendarScheduleVC.tableView.contentSize.height;
        }
        else {
            self.tableViewContainerHeightConstaint.constant = 57;
        }
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CalendarEmbedSegue"]) {
        self.calendarVC = segue.destinationViewController;
        self.calendarVC.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"CalendarScheduleEmbedSegue"])
    {
        self.calendarScheduleVC = segue.destinationViewController;
    }
}

@end
