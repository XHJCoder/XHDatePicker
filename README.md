# XHDatePicker  日期选择器
![日期选择器](https://github.com/XHJCoder/XHDatePicker/blob/master/Screenshot/screen1.png)

## Installation【安装】

在Podfile文件中添加``` pod 'XHDatePicker'``` ，并运行 ```pod install```

## Usage【使用】
- init对象
```
/**
 @param completeBlock 时间选择好之后的回调，返回开始时间和结束时间 
 */
-(instancetype)initWithCompleteBlock:(void(^)(NSDate *,NSDate *))completeBlock;


/**
 @param currentDate 设置打开选择器时的默认显示时间
 *   minLimitDate < currentDate < maxLimitDate  显示 currentDate;
 *   currentDate < minLimitDate ||  currentDate > maxLimitDate   显示minLimitDate;
 @param completeBlock 时间选择好之后的回调，返回开始时间和结束时间 
 */
-(instancetype)initWithCurrentDate:(NSDate *)currentDate CompleteBlock:(void(^)(NSDate *,NSDate *))completeBlock;
```

- 设置日期选择器样式
```
typedef enum{
  DateStyleShowYearMonthDayHourMinute  = 0,  // 显示年月日时分
  DateStyleShowMonthDayHourMinute,           // 显示月日时分
  DateStyleShowYearMonthDay,                 // 显示年月日
  DateStyleShowMonthDay,                     // 显示月日
  DateStyleShowHourMinute                    // 显示时分
}XHDateStyle;

@property (nonatomic,assign)XHDateStyle datePickerStyle;
```

- 设置时间类型
```
typedef enum{
  DateTypeStartDate,   // 开始时间  
  DateTypeEndDate      // 结束时间
}XHDateType;

@property (nonatomic,assign)XHDateType dateType;
```

- 设置最大最小时间限制
```
@property (nonatomic, retain) NSDate *maxLimitDate; //限制最大时间（没有设置默认2049年）
@property (nonatomic, retain) NSDate *minLimitDate; //限制最小时间（没有设置默认1970年）
```

## Example【示例】
- 不设置默认显示时间
```
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate,NSDate *endDate) {
        NSLog(@"\n开始时间： %@，结束时间：%@",startDate,endDate);
        self.startTimeText.text = [startDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        self.endtimeText.text = [endDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
    }];
    datepicker.datePickerStyle = DateStyleShowYearMonthDayHourMinute;
    datepicker.dateType = DateTypeStartDate;
    datepicker.minLimitDate = [NSDate date:@"2017-08-11 12:22" WithFormat:@"yyyy-MM-dd HH:mm"];
    datepicker.maxLimitDate = [NSDate date:@"2020-12-12 12:12" WithFormat:@"yyyy-MM-dd HH:mm"];
    [datepicker show];
```

- 设置默认显示时间
```
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCurrentDate:[NSDate date] CompleteBlock:^(NSDate *startDate, NSDate *endDate) {
        NSLog(@"\n开始时间： %@，结束时间：%@",startDate,endDate);
        self.startTimeText.text = [startDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        self.endtimeText.text = [endDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
    }];
    datepicker.datePickerStyle = DateStyleShowYearMonthDayHourMinute;
    datepicker.dateType = DateTypeStartDate;
    datepicker.minLimitDate = [NSDate date:@"2017-08-11 12:22" WithFormat:@"yyyy-MM-dd HH:mm"];
    datepicker.maxLimitDate = [NSDate date:@"2020-12-12 12:12" WithFormat:@"yyyy-MM-dd HH:mm"];
    [datepicker show];
```


