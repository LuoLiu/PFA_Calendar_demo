//
//  PFACalendarViewController.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "PFACalendarViewController.h"
#import "CalendarContainerController.h"
#import "ScheduleTableViewController.h"

@interface PFACalendarViewController () <CalendarContainerControllerDelegate>

//@property (strong, nonatomic) CalendarContainerController *calendarCC;
//@property (strong, nonatomic) ScheduleTableViewController *scheduleVC;

@end

@implementation PFACalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.segmentedControl.selectedSegmentIndex = 0;
    self.CalenderContainer.hidden = NO;
    self.ScheduleContainer.hidden = YES;
    
//    self.calendarCC = [self.storyboard instantiateViewControllerWithIdentifier:@"CalendarContainerControllerIdentifier"];
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

- (void)calendarCurrentMonthStringDidChangeTo:(NSString *)monthString {
    self.monthLabel.text = monthString;
    NSLog(@"CurrentMonth:%@", monthString);
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CalendarContainerEmbedSegue"]) {
        CalendarContainerController *calendarCC = segue.destinationViewController;
        calendarCC.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"ScheduleTableViewEmbedSegue"])
    {
        //
    }
}

@end
