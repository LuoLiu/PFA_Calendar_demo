//
//  DateFormatterHelper.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 15/8/3.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "DateFormatterHelper.h"

static NSString *JapanIdentifier = @"ja";

@implementation DateFormatterHelper

+ (NSDateFormatter *)shortDateFormatter {
    static dispatch_once_t once;
    static NSDateFormatter * shortDateFormatter;
    dispatch_once(&once, ^{
        shortDateFormatter = [[NSDateFormatter alloc] init];
        shortDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:JapanIdentifier];
        shortDateFormatter.dateFormat = @"yyyyMMdd";
    });
    return shortDateFormatter;
}

+ (NSDateFormatter *)longDateFormatter {
    static dispatch_once_t once;
    static NSDateFormatter * longDateFormatter;
    dispatch_once(&once, ^{
        longDateFormatter = [[NSDateFormatter alloc] init];
        longDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:JapanIdentifier];
        longDateFormatter.dateFormat = @"yyyyMMddHHmmss";
    });
    return longDateFormatter;
}

+ (NSDateFormatter *)longDateYMDHMSDateFormatter {
    static dispatch_once_t once;
    static NSDateFormatter * longDateYMDHMSDateFormatter;
    dispatch_once(&once, ^{
        longDateYMDHMSDateFormatter = [[NSDateFormatter alloc] init];
        longDateYMDHMSDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:JapanIdentifier];
        longDateYMDHMSDateFormatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    });
    return longDateYMDHMSDateFormatter;
}

+ (NSDateFormatter *)hmDateFormatter {
    static dispatch_once_t once;
    static NSDateFormatter * hmDateFormatter;
    dispatch_once(&once, ^{
        hmDateFormatter = [[NSDateFormatter alloc] init];
        hmDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:JapanIdentifier];
        hmDateFormatter.dateFormat = @"HH:mm";
    });
    return hmDateFormatter;
}

+ (NSDateFormatter *)mdDateFormatter {
    static dispatch_once_t once;
    static NSDateFormatter * mdDateFormatter;
    dispatch_once(&once, ^{
        mdDateFormatter = [[NSDateFormatter alloc] init];
        mdDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:JapanIdentifier];
        mdDateFormatter.dateFormat = @"M月d日";
    });
    return mdDateFormatter;
}

+ (NSDateFormatter *)scheduleDateFormatter {
    static dispatch_once_t once;
    static NSDateFormatter * scheduleDateFormatter;
    dispatch_once(&once, ^{
        scheduleDateFormatter = [[NSDateFormatter alloc] init];
        scheduleDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:JapanIdentifier];
        scheduleDateFormatter.dateFormat = @"M月d日（EEE）";
    });
    return scheduleDateFormatter;
}

+ (NSDateFormatter *)scheduleYMDHMDateFormatter {
    static dispatch_once_t once;
    static NSDateFormatter * scheduleMDHMDateFormatter;
    dispatch_once(&once, ^{
        scheduleMDHMDateFormatter = [[NSDateFormatter alloc] init];
        scheduleMDHMDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:JapanIdentifier];
        scheduleMDHMDateFormatter.dateFormat = @"yyyy年M月d日 HH:mm";
    });
    return scheduleMDHMDateFormatter;
}

@end
