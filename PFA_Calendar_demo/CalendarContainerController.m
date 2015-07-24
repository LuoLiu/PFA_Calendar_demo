//
//  CalendarContainerController.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 15/7/23.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "CalendarContainerController.h"
#import "CalendarViewController.h"

@interface CalendarContainerController () <CalendarViewControllerDelegate>

@property (strong, nonatomic) CalendarViewController *calendarVC;

@end

@implementation CalendarContainerController

- (void)calendarCurrentMonthStringDidChangeTo:(NSString *)monthString {
    [self.delegate calendarCurrentMonthStringDidChangeTo:monthString];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CalendarEmbedSegue"]) {
        self.calendarVC = segue.destinationViewController;
        self.calendarVC.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"CalendarScheduleEmbedSegue"])
    {
        //
    }
}

@end
