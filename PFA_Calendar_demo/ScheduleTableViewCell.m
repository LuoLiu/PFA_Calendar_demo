//
//  ScheduleTableViewCell.m
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "ScheduleTableViewCell.h"
#import "ScheduleEvent.h"

@implementation ScheduleTableViewCell

- (void)awakeFromNib {
    
}

- (void)prepareForInterfaceBuilder {
    self.scheduleEvent = nil;
    self.dateLabel.text = @"";
    self.planLabel.text = @"";
    self.iconImageView.image = nil;
}

- (UIImage *)setCellIcon {
    ScheduleEvent *event = self.scheduleEvent;
    if (event.eventType == ScheduleEventTypeCheckup) {
        return [UIImage imageNamed:@"icon_hospital_big"];
    }
    else if (!event.isShare) {
        return [UIImage imageNamed:@"icon_mama_big"];//上传者icon
    }
    else if (event.isShare && !_addEvenForSelf){//&& 上传者
        _addEvenForSelf = YES;
        return [UIImage imageNamed:@"icon_mama_big"];//上传者icon
    }
    else {
        _addEvenForSelf = NO;
        return [UIImage imageNamed:@"icon_baba_big"];//对方icon
    }
}

@end
