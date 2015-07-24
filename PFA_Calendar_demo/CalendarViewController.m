//
//  CalendarViewController.m
//  PFA_Calendar_demo
//
//  Created by fenrir_cd08 on 2015/07/20.
//  Copyright (c) 2015年 fenrir_cd08. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarCollectionViewCell.h"
#import "CalendarCollectionViewModel.h"
#import "NSDate+PFAExtension.h"

//#define kCalendarCellNibName               @"CalendarCollectionViewCell"
#define kCalendarCellReuseIdentifier       @"CalendarCellIdentifier"
#define WEEK_DAYS           (7)
#define COLLECTIONVIEW_ROWS (6)

@interface CalendarViewController ()

@property (strong, nonatomic) CalendarCollectionViewModel *viewModel;
//@property (strong, nonatomic) NSDate *currentMonth;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.collectionView registerNib:[UINib nibWithNibName:kCalendarCellNibName bundle:nil] forCellWithReuseIdentifier:kCalendarCellReuseIdentifier];
    [self bindView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToPreMonth:) name:@"scrollToPreMonth" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToNextMonth:) name:@"scrollToNextMonth" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [_viewModel numberOfSections];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_viewModel numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCalendarCellReuseIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionView Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCollectionViewCell *cell = (CalendarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"select Cell: %@", cell.date);
}

#pragma mark - ScrollView Delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger section = [self.collectionView indexPathForItemAtPoint:self.collectionView.contentOffset].section;
    //self.currentMonth = [_viewModel monthForSection:section];
    [self.delegate calendarCurrentMonthStringDidChangeTo:[_viewModel setMonthLabelForSection:section]];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger section = [self.collectionView indexPathForItemAtPoint:self.collectionView.contentOffset].section;
    [self.delegate calendarCurrentMonthStringDidChangeTo:[_viewModel setMonthLabelForSection:section]];
}

- (void)scrollToPreMonth:(id)sender {
    NSInteger section = [self.collectionView indexPathForItemAtPoint:self.collectionView.contentOffset].section;
    if (section > 0) {
        [self collectionViewScrollToSection:section-1 animated:YES];
    }
}

- (void)scrollToNextMonth:(id)sender {
    NSInteger section = [self.collectionView indexPathForItemAtPoint:self.collectionView.contentOffset].section;
    if (section < [self.collectionView numberOfSections]) {
        [self collectionViewScrollToSection:section+1 animated:YES];
    }
}

- (void)collectionViewScrollToSection:(NSInteger)section animated:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    [self.collectionView scrollToItemAtIndexPath:indexPath
                                atScrollPosition:UICollectionViewScrollPositionLeft
                                        animated:animated];
}

#pragma mark - UICollectionView FlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame)/WEEK_DAYS, CGRectGetHeight(self.collectionView.frame)/COLLECTIONVIEW_ROWS);
}

#pragma mark - configure

- (void)bindView {
    NSArray *dateList = [NSArray array];
    _viewModel = [[CalendarCollectionViewModel alloc] initWithDateList:dateList];
}

- (void)configureCell:(CalendarCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.date = [_viewModel dateForIndexPath:indexPath];
    NSInteger dateDay = [cell.date getDay];
    cell.dateLabel.text = [NSString stringWithFormat:@"%d",(int)dateDay];
}

@end
