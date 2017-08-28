//
//  ViewController.m
//  XHDatePicker
//
//  Created by XH_J on 2016/10/25.
//  Copyright © 2016年 XHJCoder. All rights reserved.
//

#import "ViewController.h"
#import "XHDatePickerView.h"
#import "NSDate+XHExtension.h"

@interface ViewController ()
- (IBAction)selelctTimeAction:(UIButton *)btn;
@property (weak, nonatomic) IBOutlet UITextField *startTimeText;
@property (weak, nonatomic) IBOutlet UITextField *endtimeText;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (IBAction)selelctTimeAction:(UIButton *)btn {
    XHDateStyle dateStyle;
    NSString *format;
    switch (btn.tag) {
        case 1:
            dateStyle = DateStyleShowYearMonthDayHourMinute;
            format = @"yyyy-MM-dd HH:mm";
            break;
        case 2:
            dateStyle = DateStyleShowMonthDayHourMinute;
            format = @"MM-dd HH:mm";
            break;
        case 3:
            dateStyle = DateStyleShowYearMonthDay;
            format = @"yyyy-MM-dd";
            break;
        case 4:
            dateStyle = DateStyleShowMonthDay;
            format = @"MM-dd";
            break;
        case 5:
            dateStyle = DateStyleShowHourMinute;
            format = @"HH:mm";
            break;
            
        default:
            dateStyle = DateStyleShowYearMonthDayHourMinute;
            format = @"yyyy-MM-dd HH:mm";
            break;
    }
    
    
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCurrentDate:[NSDate date] CompleteBlock:^(NSDate *startDate, NSDate *endDate) {
        NSLog(@"\n开始时间： %@，结束时间：%@",startDate,endDate);
        if (startDate) {
            self.startTimeText.text = [startDate stringWithFormat:format];
        }
        
        if (endDate) {
            self.endtimeText.text = [endDate stringWithFormat:format];
        }
        
    }];
    
//    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate,NSDate *endDate) {
//        NSLog(@"\n开始时间： %@，结束时间：%@",startDate,endDate);
//        self.startTimeText.text = [startDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
//        self.endtimeText.text = [endDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
//    }];
    datepicker.datePickerStyle = dateStyle;
    datepicker.dateType = DateTypeStartDate;
    datepicker.minLimitDate = [NSDate date:@"2017-2-28 12:22" WithFormat:@"yyyy-MM-dd HH:mm"];
    datepicker.maxLimitDate = [NSDate date:@"2018-2-28 12:12" WithFormat:@"yyyy-MM-dd HH:mm"];
    [datepicker show];
}
@end
