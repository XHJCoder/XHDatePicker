# XHDatePicker  日期选择器
![日期选择器](https://github.com/XHJCoder/XHDatePicker/blob/master/Screenshot/screen1.png)

## Installation【安装】

在Podfile文件中添加``` pod 'XHDatePicker'``` ，并运行 ```pod install```

## Usage【使用】
- 导入
```
#import "XHDatePickerView.h"
```

- 生成对象并展示
```
/**
 @param completeBlock 时间选择好之后的回调，返回选择的时间和时间的String值
 */
+ (instancetype)showWithCompleteBlock:(void(^)(NSDate *date, NSString *dateString))completeBlock;
```

- 设置日期选择器样式
```
typedef enum {
    XHDatePickerModeYearMonthDayHourMinute  = 0,   // 年月日时分
    XHDatePickerModeMonthDayHourMinute,            // 月日时分
    XHDatePickerModeYearMonthDay,                  // 年月日
    XHDatePickerModeYearMonth,                     // 年月
    XHDatePickerModeMonthDay,                      // 月日
    XHDatePickerModeHourMinute                     // 时分
} XHDatePickerMode;

// default is XHDatePickerModeYearMonthDayHourMinute
@property (nonatomic, assign) XHDatePickerMode datePickerMode;
```

- 设置最大最小时间限制
```
@property (nonatomic, strong) NSDate *minimumDate; // 限制最大时间（default is nil）
@property (nonatomic, strong) NSDate *maximumDate; // 限制最小时间（default is nil）
```

- 设置当前显示时间
```
@property (nonatomic, strong) NSDate *date;        // 当前显示时间（default is [NSDate date]）
```

- 设置主题色
```
@property (nonatomic, strong) UIColor *themeColor;
```

- 设置时间格式
```
/**
 * 默认与datePickerMode相对应
 * 比如：XHDatePickerModeYearMonthDayHourMinute对应的dateFormatter是：@"yyyy-MM-dd HH:mm"
 * 你也可以设置格式为 yyyy年MM月dd日HH时mm分
 */
@property (nonatomic, copy) NSString *dateFormatter;
```

## Example【示例】
```
    XHDatePickerView *datePicker = [XHDatePickerView showWithCompleteBlock:^(NSDate *date, NSString *dateString) {
        NSLog(@"%@ , %@",date, dateString);
    }];
    
    datePicker.date = [NSDate date:@"2018-05-13 22:55" WithFormat:@"yyyy-MM-dd HH:mm"];
    datePicker.minimumDate = [NSDate date:@"2015-01-14 12:14" WithFormat:@"yyyy-MM-dd HH:mm"];
    datePicker.maximumDate = [NSDate date:@"2022-11-23 07:55" WithFormat:@"yyyy-MM-dd HH:mm"];
    datePicker.themeColor = [UIColor redColor];
    datePicker.dateFormatter = @"yyyy年MM月dd日 HH:mm";
    datePicker.datePickerMode = (int)indexPath.row;    
```


