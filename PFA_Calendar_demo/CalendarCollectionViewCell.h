//
//  CalendarCollectionViewCell.h
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekAndDayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dateIcon;
@property (weak, nonatomic) IBOutlet UIImageView *hospitalIcon;
@property (weak, nonatomic) IBOutlet UIImageView *mmIcon;
@property (weak, nonatomic) IBOutlet UIImageView *ppIcon;

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSDate *month;

@end
