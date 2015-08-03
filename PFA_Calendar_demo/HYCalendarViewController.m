//
//  HYCalendarViewController.m
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "HYCalendarViewController.h"
#import "CalendarContainerController.h"
#import "ScheduleTableViewController.h"
#import "CalendarViewController.h"

@interface HYCalendarViewController () <CalendarContainerControllerDelegate>

@property (strong, nonatomic) CalendarContainerController *calendarContainer;
@property (strong, nonatomic) ScheduleTableViewController *scheduleVC;
@property (strong, nonatomic) CalendarViewController *calendarVC;

@end

@implementation HYCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
    self.segmentedControl.selectedSegmentIndex = 0;
    self.CalenderContainer.hidden = NO;
    self.ScheduleContainer.hidden = YES;
    self.monthLabel.text = @"";
    
//    self.calendarContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"CalendarContainerControllerIdentifier"];
//    self.scheduleVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ScheduleTableViewControllerIdentifier"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentedControlAction:(id)sender {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        self.CalenderContainer.hidden = NO;
        self.ScheduleContainer.hidden = YES;
    }
    else
    {
        self.CalenderContainer.hidden = YES;
        self.ScheduleContainer.hidden = NO;
    }
}

- (IBAction)toPreMonth:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollToPreMonth" object:nil];
}

- (IBAction)toNextMonth:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollToNextMonth" object:nil];
}

- (IBAction)toToday:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollToToday" object:nil];
}

- (void)calendarCurrentMonthStringDidChangeTo:(NSString *)monthString {
    self.monthLabel.text = monthString;
    NSLog(@"CurrentMonth:%@", monthString);
}

-(void)isCurrentMonth:(BOOL)isCurrentMonth {
    self.todayButton.hidden = isCurrentMonth;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CalendarContainerEmbedSegue"]) {
        self.calendarContainer = segue.destinationViewController;
        self.calendarContainer.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"ScheduleTableViewEmbedSegue"])
    {
        self.scheduleVC = segue.destinationViewController;
    }
}

@end
