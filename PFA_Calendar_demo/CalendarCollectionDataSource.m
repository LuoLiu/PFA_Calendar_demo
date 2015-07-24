//
//  CalendarCollectionDataSource.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "CalendarCollectionDataSource.h"
#import "CalendarCollectionViewModel.h"
#import "CalendarCollectionViewCell.h"

#define kCalendarCellReuseIdentifier       @"CalendarCellIdentifier"

@interface CalendarCollectionDataSource ()

@property (nonatomic, weak) CalendarCollectionViewModel *viewModel;

@end

@implementation CalendarCollectionDataSource

#pragma mark - Initialization

- (instancetype)initWithViewModel:(CalendarCollectionViewModel *)viewModel {
    self = [super init];
    
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [_viewModel numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_viewModel numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCalendarCellReuseIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(CalendarCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

@end
