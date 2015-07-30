//
//  ScheduleDetailTableViewController.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 15/7/30.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "ScheduleDetailTableViewController.h"

@interface ScheduleDetailTableViewController ()



@end

@implementation ScheduleDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
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
    return 9;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
