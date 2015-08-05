//
//  ScheduleDetailTableViewController.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 15/7/30.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "ScheduleDetailTableViewController.h"
#import "AddScheduleTableViewController.h"
#import "ScheduleEvent.h"
#import "DateFormatterHelper.h"

@interface ScheduleDetailTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmLabel;
@property (weak, nonatomic) IBOutlet UITextView *memoTextView;

@end

@implementation ScheduleDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];

    self.titleLabel.text = _scheduleEvent.eventTitle;
    self.startDateLabel.text = [[DateFormatterHelper longDateYMDHMSDateFormatter] stringFromDate:_scheduleEvent.startDate];
    self.endDateLabel.text = [[DateFormatterHelper longDateYMDHMSDateFormatter] stringFromDate:_scheduleEvent.endDate];
    self.alarmLabel.text = [self stringForAlarmMinutes:_scheduleEvent.alarmMinutes];
    self.memoTextView.text = _scheduleEvent.memo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

#pragma mark - Alarm

-(NSString *)stringForAlarmMinutes:(NSInteger)alarmMinutes {
    if (alarmMinutes < 0) {
        return @"あし";
    }
    
    NSString *alarmString = @"";
    switch (alarmMinutes) {
        case 0:
            alarmString = @"予定時刻";
            break;
        case 5:
            alarmString = @"5分前";
            break;
        case 15:
            alarmString = @"15分前";
            break;
        case 30:
            alarmString = @"30分前";
            break;
        case 60:
            alarmString = @"1時間前";
            break;
        case 60*2:
            alarmString = @"2時間前";
            break;
        case 60*24:
            alarmString = @"1日前";
            break;
            
        default:
            alarmString = @"あし";
            break;
    }
    return alarmString;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EditScheduleSegue"]) {
        AddScheduleTableViewController *addScheduleVC = segue.destinationViewController;
        addScheduleVC.scheduleEvent = self.scheduleEvent;
        addScheduleVC.isEditSchedule = YES;
    }
}

@end
