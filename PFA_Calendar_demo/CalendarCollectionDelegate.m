//
//  CalendarCollectionDelegate.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "CalendarCollectionDelegate.h"
#import "CalendarCollectionViewModel.h"

@interface CalendarCollectionDelegate ()

@property (nonatomic, strong) CalendarCollectionViewModel *viewModel;

@end

@implementation CalendarCollectionDelegate

#pragma mark - Initialization

- (instancetype)initWithViewModel:(CalendarCollectionViewModel *)viewModel {
    self = [super init];
    
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}


@end
