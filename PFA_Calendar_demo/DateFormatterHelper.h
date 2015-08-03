//
//  DateFormatterHelper.h
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 15/8/3.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatterHelper : NSObject

/// yyyyMMdd
+ (NSDateFormatter *)shortDateFormatter;

/// yyyyMMddHHmmss
+ (NSDateFormatter *)longDateFormatter;

/// yyyy/MM/dd HH:mm:ss
+ (NSDateFormatter *)longDateYMDHMSDateFormatter;

/// HH:mm
+ (NSDateFormatter *)hmDateFormatter;

/// M月d日
+ (NSDateFormatter *)mdDateFormatter;

/// M月d日（EEE）
+ (NSDateFormatter *)scheduleDateFormatter;

/// yyyy年M月d日 HH:mm
+ (NSDateFormatter *)scheduleYMDHMDateFormatter;

@end
