//
//  ScheduleEvent.h
//  HY_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/21.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ScheduleEventUpdateType) {
    ScheduleEventUpdateTypeAdd    = 1,
    ScheduleEventUpdateTypeUpdate = 2,
    ScheduleEventUpdateTypeDelede = 3
};

typedef NS_ENUM(NSInteger, ScheduleEventType) {
    ScheduleEventTypeCheckup = 1,
    ScheduleEventTypeOthers  = 2
};

typedef NS_ENUM(NSInteger, ScheduleEventIsShare) {
    ScheduleEventTypeNotShare = 0,
    ScheduleEventTypeShare  = 1
};

@interface ScheduleEvent : NSObject

///イベントID (アプリ内のID)
///*****必須
@property (assign, nonatomic) NSInteger eventId;

///更新種別 (1: 追加、2: 変更、3: 削除)
///*****必須
@property (assign, nonatomic) ScheduleEventUpdateType updateType;

///イベント種別 (1: 検診、2: その他の予定)
///*****更新種別=1:追加、2:変更の場合必須
@property (assign, nonatomic) ScheduleEventType eventType;

///タイトル (イベントのタイトル)
///size: 15
@property (copy, nonatomic) NSString *eventTitle;

///共有
///0: 共有しない、1: 共有する
///*****更新種別=1:追加、2:変更の場合必須
@property (assign, nonatomic) ScheduleEventIsShare isShare;

///開始日時
///YYYY/MM/DD hh:mm:ss JSTの形式。時間未指定時は、YYYY/MM/DD
///*****更新種別=1:追加、2:変更の場合必須
@property (copy, nonatomic) NSString *startDate;

///終了日時
///YYYY/MM/DD hh:mm:ss JSTの形式。時間未指定時は、YYYY/MM/DD
@property (copy, nonatomic) NSString *endDate;

///アラーム時間 (開始日時の指定分前にアラーム)
@property (assign, nonatomic) NSInteger alarmMinutes;

///メモ
///size: 500 (改行を含まない文字数)
@property (copy, nonatomic) NSString *memo;

///処理日時
///YYYY/MM/DD hh:mm:ss JSTの形式
///*****必須
@property (copy, nonatomic) NSString *opeDate;

@end
