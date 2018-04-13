//
//  XHDatePickerView.h
//  XHDatePicker
//
//  Created by XH_J on 2016/10/25.
//  Copyright © 2016年 XHJCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    XHDatePickerModeYearMonthDayHourMinute  = 0,   // 年月日时分
    XHDatePickerModeMonthDayHourMinute,            // 月日时分
    XHDatePickerModeYearMonthDay,                  // 年月日
    XHDatePickerModeYearMonth,                     // 年月
    XHDatePickerModeMonthDay,                      // 月日
    XHDatePickerModeHourMinute                     // 时分
} XHDatePickerMode;

@interface XHDatePickerView : UIView

@property (nonatomic, assign) XHDatePickerMode datePickerMode;

/* 默认与datePickerMode相对应
 * 比如：XHDatePickerModeYearMonthDayHourMinute对应的dateFormatter是：@"yyyy-MM-dd HH:mm"
 * 你也可以设置格式为 yyyy年MM月dd日HH时mm分
 */
@property (nonatomic, copy) NSString *dateFormatter;

@property (nonatomic, strong) UIColor *themeColor;

@property (nonatomic, strong) NSDate *minimumDate; // 限制最大时间（默认nil）
@property (nonatomic, strong) NSDate *maximumDate; // 限制最小时间（默认nil）
@property (nonatomic, strong) NSDate *currentDate; // 当前显示时间（默认[NSDate date]）

-(instancetype)initWithCompleteBlock:(void(^)(NSDate *date, NSString *dateString))completeBlock;

-(void)show;


@end
