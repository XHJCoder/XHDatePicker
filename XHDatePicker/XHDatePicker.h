//
//  XHDatePicker.h
//  XHDatePicker
//
//  Created by XH_J on 2016/10/25.
//  Copyright © 2016年 XHJCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XHDatePickerMode) {
    XHDatePickerModeYearMonthDayHourMinute  = 0,   // 年月日时分
    XHDatePickerModeMonthDayHourMinute,            // 月日时分
    XHDatePickerModeYearMonthDay,                  // 年月日
    XHDatePickerModeYearMonth,                     // 年月
    XHDatePickerModeMonthDay,                      // 月日
    XHDatePickerModeHourMinute                     // 时分
};

@interface XHDatePicker : UIView

// default is XHDatePickerModeYearMonthDayHourMinute
@property (nonatomic, assign) XHDatePickerMode datePickerMode;

/**
 * 默认与datePickerMode相对应
 * 比如：XHDatePickerModeYearMonthDayHourMinute对应的dateFormatter是：@"yyyy-MM-dd HH:mm"
 * 你也可以设置格式为 yyyy年MM月dd日HH时mm分
 */
@property (nonatomic, copy) NSString *dateFormatter;

@property (nonatomic, strong) UIColor *themeColor;

@property (nonatomic, strong) NSDate *minimumDate; // 限制最大时间（default is nil）
@property (nonatomic, strong) NSDate *maximumDate; // 限制最小时间（default is nil）
@property (nonatomic, strong) NSDate *date;        // 当前显示时间（default is [NSDate date]）

+ (instancetype)showWithCompleteBlock:(void(^)(NSDate *date, NSString *dateString))completeBlock;

@end
