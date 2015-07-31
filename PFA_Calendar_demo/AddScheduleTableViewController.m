//
//  AddScheduleTableViewController.m
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "AddScheduleTableViewController.h"
#import "ScheduleEvent.h"
#import "AlarmTableViewController.h"
#import "NSDate+HYExtension.h"

#define kDateStartRow   2
#define kDateEndRow     4
#define kMemoRow        8
#define kDelRow         9
#define kDatePickerHeight   162
#define kMemoRowHeight      175
#define kDelRowHeight       168

@interface AddScheduleTableViewController () <AlarmTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *eventTitleTextField;
@property (weak, nonatomic) IBOutlet UITextView *memoTextView;
@property (weak, nonatomic) IBOutlet UISwitch *checkUpSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *shareSwitch;
@property (weak, nonatomic) IBOutlet UILabel *alarmLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;

@property (strong, nonatomic) AlarmTableViewController *alarmTableVC;
@property (strong, nonatomic) ScheduleEvent *scheduleEvent;

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (assign, nonatomic) NSInteger alarmMinutes;

@property (assign, nonatomic) BOOL isEditStartDate;
@property (assign, nonatomic) BOOL isEditEndDate;

@end

@implementation AddScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scheduleEvent = [[ScheduleEvent alloc] init];
    _memoTextView.text = @"";
    _startDateLabel.text = [[NSDate date] stringWithFormat:@"yyyy/MM/dd HH:mm:ss"];
    _endDateLabel.text = [[NSDate date] stringWithFormat:@"yyyy/MM/dd HH:mm:ss"];
    _isEditStartDate = NO;
    _isEditEndDate = NO;
    self.startDatePicker.hidden = YES;
    self.endDatePicker.hidden = YES;
    
    //test
    _scheduleEvent.startDate = [NSDate dateFromString:@"2015/7/29 23:00:22" format:@"yyyy/MM/dd HH:mm:ss"];
    //test
    self.startDate = _scheduleEvent.startDate;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addScheduleEvent) name:@"addScheduleEvent" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"addScheduleEvent" object:nil];
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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == kDateStartRow + 1) {
        if (_isEditStartDate) {
            return self.tableView.rowHeight + kDatePickerHeight;
        } else {
            return 0;
        }
    }
    else if (indexPath.section == 0 && indexPath.row == kDateEndRow + 1) {
        if (_isEditEndDate) {
            return self.tableView.rowHeight + kDatePickerHeight;
        } else {
            return 0;
        }
    }
    else if (indexPath.section == 0 && indexPath.row == kMemoRow) {
        return kMemoRowHeight;
    }
    else if (indexPath.section == 0 && indexPath.row == kDelRow) {
        return kDelRowHeight;
    }
    else {
        return self.tableView.rowHeight;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == kDateStartRow) {
        _isEditStartDate = !_isEditStartDate;
        self.startDatePicker.hidden = !self.startDatePicker.hidden;

        [UIView animateWithDuration:0.4 animations:^{
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:kDateStartRow + 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];

            [self.tableView reloadData];
        }];
    }
    if (indexPath.section == 0 && indexPath.row == kDateEndRow) {
        _isEditEndDate = !_isEditEndDate;
        self.endDatePicker.hidden = !self.endDatePicker.hidden;
        [UIView animateWithDuration:0.4 animations:^{
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:kDateEndRow + 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
        }];
    }
}

#pragma mark - DatePicker

- (IBAction)startDateValueChanged:(id)sender {
    
}

- (IBAction)endDateValueChanged:(id)sender {
    
}


#pragma mark - Button Method

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
    
}

- (IBAction)okButtonTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addScheduleEvent" object:nil];
}

- (IBAction)delButtonTapped:(id)sender {
    //Delete scheduleEvent
    
}

#pragma mark - Alarm

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
        self.alarmTableVC.startDate = self.startDate;
    }
}

@end
