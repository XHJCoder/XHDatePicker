//
//  XHDatePicker.m
//  XHDatePicker
//
//  Created by XH_J on 2016/10/25.
//  Copyright © 2016年 XHJCoder. All rights reserved.
//

#import "XHDatePicker.h"
#import "NSDate+XHExtension.h"

typedef NS_ENUM(NSInteger, XHDateType) {
    XHDateTypeYear,
    XHDateTypeMonth,
    XHDateTypeDay,
    XHDateTypeHour,
    XHDateTypeMinute
};

@interface XHDatePicker ()<UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate> {
    
    NSArray *_rowsDataArray;
    NSArray *_dateTypeArray;
    NSArray *_textDataArray;
    BOOL _isRepeatMonth;
    
}

@property (weak, nonatomic) IBOutlet UIView *buttomView;
@property (weak, nonatomic) IBOutlet UILabel *showYearView;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (nonatomic, strong) UIPickerView *datePicker;
@property (nonatomic, strong) void(^doneBlock)(NSDate *date, NSString *dateString);
@property (nonatomic, copy) NSString *yearText;
@property (nonatomic, strong) NSDate *currentDate; 


@end

@implementation XHDatePicker

+ (instancetype)showWithCompleteBlock:(void (^)(NSDate *, NSString *))completeBlock {
    
    XHDatePicker *datePickerView = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    [datePickerView setupUI];
    
    datePickerView.datePickerMode = XHDatePickerModeYearMonthDayHourMinute;
    datePickerView.date = [NSDate date];
    
    if (completeBlock) {
        datePickerView.doneBlock = ^(NSDate *date, NSString *dateString) {
            completeBlock(date,dateString);
        };
    }
    return datePickerView;
}

- (void)setupUI {
    
    self.buttomView.layer.cornerRadius = 10;
    self.buttomView.layer.masksToBounds = YES;
    self.frame = [UIScreen mainScreen].bounds;
    
    //点击背景是否隐藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    self.bottomConstraint.constant = -self.frame.size.height;
    self.backgroundColor = [UIColor colorWithRed:(0 / 255.0) green:(0 / 255.0) blue:(0 / 255.0) alpha:0];
    [self layoutIfNeeded];
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    [self.showYearView addSubview:self.datePicker];
    
    [self show];
    
}

- (void)addLabelWithName:(NSArray *)nameArr {
    for (id subView in self.showYearView.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
    CGSize datePickerSize = self.datePicker.frame.size;
    for (int i=0; i<nameArr.count; i++) {
        CGFloat labelX = datePickerSize.width/(nameArr.count*2)+18+datePickerSize.width/nameArr.count*i;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, self.showYearView.frame.size.height/2-15, 15, 15)];
        label.text = nameArr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = self.doneBtn.backgroundColor;
        label.backgroundColor = [UIColor clearColor];
        [self.showYearView addSubview:label];
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    [self addLabelWithName:_textDataArray];
    return _textDataArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_rowsDataArray[component] integerValue];
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        customLabel.font = [UIFont systemFontOfSize:16];
        customLabel.textColor = [UIColor blackColor];
    }
    customLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return customLabel;

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    XHDateType type = [_dateTypeArray[component] integerValue];
    NSString *title;
    switch (type) {
        case XHDateTypeYear:
        case XHDateTypeDay:
            title = [NSString stringWithFormat:@"%d",(int)row+1];
            break;
        case XHDateTypeMonth:
            title = [NSString stringWithFormat:@"%d",(int)(row)%12+1];
            break;
        case XHDateTypeHour:
        case XHDateTypeMinute:
            title = [NSString stringWithFormat:@"%.2d",(int)row];
            break;
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
    NSInteger rowData = label.text.integerValue;
    
    // 月份是否循环滚动
    if ([_dateTypeArray[component] integerValue] == XHDateTypeMonth && _isRepeatMonth) {
        NSInteger year = row/12+1;
        self.currentDate = [_currentDate dateByAddingYears:year - _currentDate.year];
    }
    
    [self updateCurrentDateWithRowData:rowData dateType:[_dateTypeArray[component] integerValue]];
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if( [touch.view isDescendantOfView:self.buttomView])
        return NO;
    return YES;
}

#pragma mark - Action
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.3 animations:^{
        self.bottomConstraint.constant = 10;
        self.backgroundColor = [UIColor colorWithRed:(0 / 255.0) green:(0 / 255.0) blue:(0 / 255.0) alpha:0.3];
        [self layoutIfNeeded];
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:.3 animations:^{
        self.bottomConstraint.constant = -self.frame.size.height;
        self.backgroundColor = [UIColor colorWithRed:(0 / 255.0) green:(0 / 255.0) blue:(0 / 255.0) alpha:0];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}

- (IBAction)doneAction:(UIButton *)btn {
    if (!_dateFormatter) {
        switch (_datePickerMode) {
            case XHDatePickerModeYearMonthDayHourMinute:
                _dateFormatter = @"yyyy-MM-dd HH:mm";
                break;
            case XHDatePickerModeMonthDayHourMinute:
                _dateFormatter = @"MM-dd HH:mm";
                break;
            case XHDatePickerModeYearMonthDay:
                _dateFormatter = @"yyyy-MM-dd";
                break;
            case XHDatePickerModeYearMonth:
                _dateFormatter = @"yyyy-MM";
                break;
            case XHDatePickerModeMonthDay:
                _dateFormatter = @"MM-dd";
                break;
            case XHDatePickerModeHourMinute:
                _dateFormatter = @"HH:mm";
                break;
        }
    }
    NSString *dateStr = [_currentDate stringWithFormat:_dateFormatter];
    self.doneBlock(_currentDate,dateStr);
    [self dismiss];
}

#pragma mark - Tools
// 判断当前时间是否在限定范围内  (YES:在限定范围内 NO:不在限定范围内)
- (BOOL)currentDateInRangeWithAnimated:(BOOL)animated {
    BOOL isScroll = NO;
    
    if (_minimumDate && [_currentDate compare:_minimumDate] == NSOrderedAscending) {
        _currentDate = _minimumDate;
        isScroll = YES;
    } else if (_maximumDate && [_currentDate compare:_maximumDate] == NSOrderedDescending) {
        _currentDate = _maximumDate;
        isScroll = YES;
    }
    
    self.yearText = [NSString stringWithFormat:@"%d",(int)_currentDate.year];
    if (isScroll) {
        [self scrollToCurrentDateWithAnimated:animated];
    }
    return !isScroll;

}

// 滚动到当前时间
- (void)scrollToCurrentDateWithAnimated:(BOOL)animated {
    if (!_currentDate) return;
    
    NSArray *indexArray;
    NSInteger yearIndex = _currentDate.year-1;
    NSInteger monthIndex = _currentDate.month-1;
    NSInteger dayIndex = _currentDate.day-1;
    NSInteger hourIndex = _currentDate.hour;
    NSInteger minuteIndex = _currentDate.minute;
    
    switch (_datePickerMode) {
        case XHDatePickerModeYearMonthDayHourMinute:
            indexArray = @[@(yearIndex),@(monthIndex),@(dayIndex),@(hourIndex),@(minuteIndex)];
            break;
        case XHDatePickerModeMonthDayHourMinute:
            indexArray = @[@(monthIndex+(yearIndex*12)),@(dayIndex),@(hourIndex),@(minuteIndex)];
            break;
        case XHDatePickerModeYearMonthDay:
            indexArray = @[@(yearIndex),@(monthIndex),@(dayIndex)];
            break;
        case XHDatePickerModeYearMonth:
            indexArray = @[@(yearIndex),@(monthIndex)];
            break;
        case XHDatePickerModeMonthDay:
            indexArray = @[@(monthIndex+(yearIndex*12)),@(dayIndex)];
            break;
        case XHDatePickerModeHourMinute:
            indexArray = @[@(hourIndex),@(minuteIndex)];
            break;
    }
    
    for (NSInteger i=0; i<indexArray.count; i++) {
        [self.datePicker selectRow:[indexArray[i] integerValue] inComponent:i animated:animated];
    }
}

// 更新当前选择的时间
- (void)updateCurrentDateWithRowData:(NSInteger)rowData dateType:(XHDateType)dateType {
    NSInteger days = 0;
    BOOL isUpdateDays = NO;
    NSDate *tmpDate = [NSDate date];
    switch (dateType) {
        case XHDateTypeYear:
            days = [self getDaysfromYear:rowData andMonth:_currentDate.month];
            if (_currentDate.day>days) {
                isUpdateDays = YES;
            }
            tmpDate = [_currentDate dateByAddingYears:rowData - _currentDate.year];
            break;
        case XHDateTypeMonth:
            days = [self getDaysfromYear:_currentDate.year andMonth:rowData];
            if (_currentDate.day>days) {
                isUpdateDays = YES;
            }
            tmpDate = [_currentDate dateByAddingMonths:rowData - _currentDate.month];
            break;
        case XHDateTypeDay:
            days = [self getDaysfromYear:_currentDate.year andMonth:_currentDate.month];
            if (rowData>days) {
                rowData = days;
                isUpdateDays = YES;
            }
            tmpDate = [_currentDate dateByAddingDays:rowData - _currentDate.day];
            break;
        case XHDateTypeHour:
            tmpDate = [_currentDate dateByAddingHours:rowData - _currentDate.hour];
            break;
        case XHDateTypeMinute:
            tmpDate = [_currentDate dateByAddingMinutes:rowData - _currentDate.minute];
            break;
    }
    if (isUpdateDays) {
        [self.datePicker selectRow:days-1 inComponent:[_dateTypeArray indexOfObject:@(XHDateTypeDay)] animated:YES];
    }
    
    self.currentDate = tmpDate;
}

// 通过年月求每月天数
- (NSInteger)getDaysfromYear:(NSInteger)year andMonth:(NSInteger)month {
    BOOL isrunNian = year%4==0 ? (year%100==0? (year%400==0?YES:NO):YES):NO;
    switch (month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:
            return 31;
        case 4:case 6:case 9:case 11:
            return 30;
        case 2:
            return isrunNian ? 29 : 28;
    }
    return 0;
}

#pragma mark - Setter
- (void)setDatePickerMode:(XHDatePickerMode)datePickerMode {
    _datePickerMode = datePickerMode;
    switch (datePickerMode) {
        case XHDatePickerModeYearMonthDayHourMinute:
            _rowsDataArray = @[@(10000), @(12), @(31), @(24), @(60)];
            _dateTypeArray = @[@(XHDateTypeYear),@(XHDateTypeMonth),@(XHDateTypeDay),@(XHDateTypeHour),@(XHDateTypeMinute)];
            _textDataArray = @[@"年",@"月",@"日",@"时",@"分"];
            _isRepeatMonth = NO;
            break;
        case XHDatePickerModeMonthDayHourMinute:
            _rowsDataArray = @[@(12*10000), @(31), @(24), @(60)];
            _dateTypeArray = @[@(XHDateTypeMonth),@(XHDateTypeDay),@(XHDateTypeHour),@(XHDateTypeMinute)];
            _textDataArray = @[@"月",@"日",@"时",@"分"];
            _isRepeatMonth = YES;
            break;
        case XHDatePickerModeYearMonthDay:
            _rowsDataArray = @[@(10000), @(12), @(31)];
            _dateTypeArray = @[@(XHDateTypeYear),@(XHDateTypeMonth),@(XHDateTypeDay)];
            _textDataArray = @[@"年",@"月",@"日"];
            _isRepeatMonth = NO;
            break;
        case XHDatePickerModeYearMonth:
            _rowsDataArray = @[@(10000), @(12)];
            _dateTypeArray = @[@(XHDateTypeYear),@(XHDateTypeMonth)];
            _textDataArray = @[@"年",@"月"];
            _isRepeatMonth = NO;
            break;
        case XHDatePickerModeMonthDay:
            _rowsDataArray = @[@(12*10000), @(31)];
            _dateTypeArray = @[@(XHDateTypeMonth),@(XHDateTypeDay)];
            _textDataArray = @[@"月",@"日"];
            _isRepeatMonth = YES;
            break;
        case XHDatePickerModeHourMinute:
            _rowsDataArray = @[@(24), @(60)];
            _dateTypeArray = @[@(XHDateTypeHour),@(XHDateTypeMinute)];
            _textDataArray = @[@"时",@"分"];
            _isRepeatMonth = NO;
            break;
    }
    [self.datePicker reloadAllComponents];
    self.yearText = [NSString stringWithFormat:@"%d",(int)_currentDate.year];
    [self scrollToCurrentDateWithAnimated:NO];
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    [self currentDateInRangeWithAnimated:NO];
}

- (void)setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
    [self currentDateInRangeWithAnimated:NO];
}

- (void)setCurrentDate:(NSDate *)currentDate {
    _currentDate = currentDate;
    [self currentDateInRangeWithAnimated:YES];
}

- (void)setDate:(NSDate *)date {
    _date = date;
    _currentDate = date;
    if ([self currentDateInRangeWithAnimated:NO]) {
        [self scrollToCurrentDateWithAnimated:NO];
    }
    
}

- (void)setThemeColor:(UIColor *)themeColor {
    _themeColor = themeColor;
    self.doneBtn.backgroundColor = themeColor;
}

- (void)setYearText:(NSString *)yearText {
    _yearText = yearText;
    switch (_datePickerMode) {
        case XHDatePickerModeYearMonthDayHourMinute:
        case XHDatePickerModeYearMonthDay:
        case XHDatePickerModeYearMonth:
        case XHDatePickerModeHourMinute:
            self.showYearView.text = @"";
            break;
        case XHDatePickerModeMonthDayHourMinute:
        case XHDatePickerModeMonthDay:
            self.showYearView.text = yearText;
            break;
    }
}

#pragma mark - Getter
- (UIPickerView *)datePicker {
    if (!_datePicker) {
        [self.showYearView layoutIfNeeded];
        _datePicker = [[UIPickerView alloc] initWithFrame:self.showYearView.bounds];
        _datePicker.showsSelectionIndicator = YES;
        _datePicker.delegate = self;
        _datePicker.dataSource = self;
    }
    return _datePicker;
}

@end
