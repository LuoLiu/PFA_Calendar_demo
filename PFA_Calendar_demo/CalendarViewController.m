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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedToday:) name:@"selectedToday" object:nil];
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

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCollectionViewCell *cell = (CalendarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.isPlaceholder) {
        // 如果是上个月或者下个月的元素，则无需调用代理方法，在[setSelectedDate:animated:]中还会调用此方法
        return [_viewModel isDateInRange:cell.date] && ![cell.date isEqualToDateForDay:_viewModel.selectedDate];
    }
    BOOL shouldSelect = ![collectionView.indexPathsForSelectedItems containsObject:indexPath];
    
    return shouldSelect && [_viewModel isDateInRange:cell.date];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCollectionViewCell *cell = (CalendarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.isPlaceholder) {
        [_viewModel setSelectedDate:cell.date animate:YES];
    } else {
        [cell configureCellAppearence];
        _viewModel.selectedDate = [_viewModel dateForIndexPath:indexPath];
//        if (!_supressEvent) {
//            [_viewModel didSelectDate:_viewModel.selectedDate];
//        }
    }
    
    // CollectionView选中状态仅仅在‘当月’体现，placeholder需要重新计算'选中'状态
    [collectionView.visibleCells enumerateObjectsUsingBlock:^(CalendarCollectionViewCell *cell, NSUInteger idx, BOOL *stop) {
        if (cell.isPlaceholder) {
            [cell setNeedsLayout];
        }
    }];
    NSLog(@"select Day: %@, %@", cell.dateLabel.text, [cell.date dayInWeek]);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCollectionViewCell *cell = (CalendarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell configureCellAppearence];
}

#pragma mark - ScrollView Delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger section = [self.collectionView indexPathForItemAtPoint:self.collectionView.contentOffset].section;
    [self.delegate calendarCurrentMonthStringDidChangeTo:[_viewModel setMonthLabelForSection:section]];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger section = [self.collectionView indexPathForItemAtPoint:self.collectionView.contentOffset].section;
    [self.delegate calendarCurrentMonthStringDidChangeTo:[_viewModel setMonthLabelForSection:section]];
}

#pragma mark - NSNotification Method

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

- (void)selectedToday:(id)sender {
    NSDate *currentDate = _viewModel.currentDate;
    NSIndexPath *indexPath = [_viewModel indexPathForDate:currentDate];
    [self scrollToCurrentMonthAnimated:YES];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
    //CalendarCollectionViewCell *cell = (CalendarCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    //[cell configureCellAppearence];
    //NSLog(@"select Day: %@", cell.dateLabel.text);

}

- (void)scrollToCurrentMonthAnimated:(BOOL)animated {
    NSDate *currentMonth = _viewModel.currentMonth;
    NSIndexPath *indexPath = [_viewModel indexPathForDate:currentMonth];
    [self collectionViewScrollToSection:indexPath.section animated:animated];
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

#pragma mark - Configure

- (void)bindView {
    NSArray *dateList = [NSArray array];
    _viewModel = [[CalendarCollectionViewModel alloc] initWithDateList:dateList];
}

- (void)configureCell:(CalendarCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.calenderViewModel = _viewModel;
    cell.month = [[[_viewModel.minimumDate firstDayOfMonth] dateByAddMonths:indexPath.section] dateByIgnoringTimeComponents];
    cell.date = [_viewModel dateForIndexPath:indexPath];
    NSInteger dateDay = [cell.date getDay];
    cell.dateLabel.text = [NSString stringWithFormat:@"%d",(int)dateDay];
    [cell configureCellAppearence];

    [cell setNeedsLayout];
}

@end
