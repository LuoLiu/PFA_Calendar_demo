//
//  AlarmTableViewController.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "AlarmTableViewController.h"

@interface AlarmTableViewController ()

@property (assign, nonatomic) NSInteger alarmMinutes;

@end

@implementation AlarmTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 8;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            //あし
            _alarmMinutes = -1;
            break;
        case 1:
            //予定時刻
            _alarmMinutes = 0;
            break;
        case 2:
            //5 分前
            _alarmMinutes = 5;
            break;
        case 3:
            //15 分前
            _alarmMinutes = 15;
            break;
        case 4:
            //30 分前
            _alarmMinutes = 30;
            break;
        case 5:
            //1 時間前
            _alarmMinutes = 60;
            break;
        case 6:
            //2 時間前
            _alarmMinutes = 60*2;
            break;
        case 7:
            //1 日前
            _alarmMinutes = 60*24;
            break;
        default:
            break;
    }
    [self.delegate alarmMinutes:_alarmMinutes];
    [self configureAlarmWithMinutes:_alarmMinutes];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configureAlarmWithMinutes:(NSInteger)minutes {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification != nil) {
        NSDate *itemDate = self.startDate;
        notification.fireDate = [itemDate dateByAddingTimeInterval:-minutes*60];
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.alertBody = [NSString stringWithFormat:@"%d分钟后XXXX！", (int)minutes];
        notification.alertAction = NSLocalizedString(@"查看", nil);
        notification.soundName = UILocalNotificationDefaultSoundName;
        [notification setApplicationIconBadgeNumber:1];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

@end
