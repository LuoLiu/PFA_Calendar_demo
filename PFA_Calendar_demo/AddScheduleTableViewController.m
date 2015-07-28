//
//  AddScheduleTableViewController.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "AddScheduleTableViewController.h"
#import "ScheduleEvent.h"
#import "AlarmTableViewController.h"

@interface AddScheduleTableViewController () <AlarmTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *eventTitleTextField;
@property (weak, nonatomic) IBOutlet UITextView *memoTextView;
@property (weak, nonatomic) IBOutlet UISwitch *checkUpSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *shareSwitch;
@property (weak, nonatomic) IBOutlet UILabel *alarmLabel;

@property (strong, nonatomic) AlarmTableViewController *alarmTableVC;
@property (strong, nonatomic) ScheduleEvent *scheduleEvent;

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (assign, nonatomic) NSInteger alarmMinutes;

@end

@implementation AddScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scheduleEvent = [[ScheduleEvent alloc] init];
    _memoTextView.text = @"";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addScheduleEvent) name:@"addScheduleEvent" object:nil];
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
    return 7;
}

- (IBAction)checkUpSwitchAction:(id)sender {
    if ([(UISwitch *)sender isOn]) {
        _scheduleEvent.eventType = ScheduleEventTypeCheckup;
        self.eventTitleTextField.text = @"検診";
    }
    else {
        _scheduleEvent.eventType = ScheduleEventTypeOthers;
        self.eventTitleTextField.text = @"";
    }
}

- (IBAction)shareSwitchAction:(id)sender {
    _scheduleEvent.isShare = [(UISwitch *)sender isOn];
}

- (void)addScheduleEvent {
    _scheduleEvent.isShare = self.shareSwitch.isOn;
    _scheduleEvent.alarmMinutes = self.alarmMinutes;
    _scheduleEvent.eventTitle = [NSString stringWithString:self.eventTitleTextField.text];
    _scheduleEvent.memo = [NSString stringWithString:self.memoTextView.text];
    
    [self.delegate getNewScheduleEvent:_scheduleEvent];
}

-(void)alarmMinutes:(NSInteger)alarmMinutes {
    
    _alarmMinutes = alarmMinutes;

    if (alarmMinutes < 0) {
        self.alarmLabel.text = @"あし";
        return;
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
    self.alarmLabel.text = [NSString stringWithString:alarmString];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowAlarmSegue"]) {
        self.alarmTableVC = segue.destinationViewController;
        self.alarmTableVC.delegate = self;
    }
}

@end
