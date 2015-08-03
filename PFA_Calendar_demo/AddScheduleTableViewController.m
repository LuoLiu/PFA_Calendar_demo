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
#import "DateFormatterHelper.h"

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
@property (assign, nonatomic) BOOL canSave;

@end

@implementation AddScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
    _scheduleEvent = [[ScheduleEvent alloc] init];
    _memoTextView.text = @"";
    _startDateLabel.text = [[DateFormatterHelper scheduleYMDHMDateFormatter] stringFromDate:[NSDate date]];
    _endDateLabel.text = [[DateFormatterHelper scheduleYMDHMDateFormatter] stringFromDate:[NSDate date]];
    _isEditStartDate = NO;
    _isEditEndDate = NO;
    _canSave = YES;
    self.startDatePicker.hidden = YES;
    self.endDatePicker.hidden = YES;
    
    //test
    _scheduleEvent.startDate = [[DateFormatterHelper longDateYMDHMSDateFormatter] dateFromString:@"2015/7/29 23:00:22"];
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
        if (!self.endDatePicker.hidden) {
            self.endDatePicker.hidden = YES;
            _isEditEndDate = NO;
        }

        [UIView animateWithDuration:0.4 animations:^{
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:kDateStartRow + 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];

            [self.tableView reloadData];
        }];
    }
    if (indexPath.section == 0 && indexPath.row == kDateEndRow) {
        _isEditEndDate = !_isEditEndDate;
        self.endDatePicker.hidden = !self.endDatePicker.hidden;
        if (!self.startDatePicker.hidden) {
            self.startDatePicker.hidden = YES;
            _isEditStartDate = NO;
        }
        
        [UIView animateWithDuration:0.4 animations:^{
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:kDateEndRow + 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
        }];
    }
}

#pragma mark - DatePicker

- (IBAction)startDateValueChanged:(id)sender {
    UIDatePicker *datePicker = sender;
    
    _scheduleEvent.startDate = datePicker.date;
    _startDateLabel.text = [[DateFormatterHelper scheduleYMDHMDateFormatter] stringFromDate:datePicker.date];
}

- (IBAction)endDateValueChanged:(id)sender {
    UIDatePicker *datePicker = sender;
    
    _scheduleEvent.endDate = datePicker.date;
    NSComparisonResult result = [datePicker.date compare:self.startDatePicker.date];
    if (result < 0) {
        NSString *endDateString = [[DateFormatterHelper scheduleYMDHMDateFormatter] stringFromDate:datePicker.date];
        NSUInteger length = [endDateString length];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:endDateString];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, length)];
        [_endDateLabel setTextColor:[UIColor redColor]];
        [_endDateLabel setAttributedText:attri];
        _canSave = NO;
    }
    else {
        [_endDateLabel setTextColor:[UIColor blackColor]];
        _endDateLabel.text = [[DateFormatterHelper scheduleYMDHMDateFormatter] stringFromDate:datePicker.date];
        _canSave = YES;
    }
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
    if (!_canSave) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"EndDate Error" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addScheduleEvent" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
