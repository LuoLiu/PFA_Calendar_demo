//
//  AddScheduleContainerController.m
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "AddScheduleContainerController.h"
#import "AddScheduleTableViewController.h"
#import "ScheduleEvent.h"

@interface AddScheduleContainerController () <AddScheduleTableViewControllerDelegate>

@property (strong, nonatomic)AddScheduleTableViewController *addScheduleTableVC;
@property (strong, nonatomic)ScheduleEvent *scheduleEvent;

@end

@implementation AddScheduleContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)okButtonTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addScheduleEvent" object:nil];
}

- (IBAction)delButtonTapped:(id)sender {
    //Delete scheduleEvent

}

-(void)getNewScheduleEvent:(ScheduleEvent *)scheduleEvent {
    self.scheduleEvent = scheduleEvent;
    //Add scheduleEvent.....

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddScheduleEmbedSegue"]) {
        self.addScheduleTableVC = segue.destinationViewController;
        self.addScheduleTableVC.delegate = self;
    }
}

@end
