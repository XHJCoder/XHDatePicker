//
//  ViewController.m
//  XHDatePicker
//
//  Created by 江欣华 on 16/8/16.
//  Copyright © 2016年 江欣华. All rights reserved.
//

#import "ViewController.h"
#import "XHDatePickerView.h"
#import "NSDate+Extension.h"

@interface ViewController ()
- (IBAction)selelctTimeAction:(id)sender;
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


- (IBAction)selelctTimeAction:(id)sender {
    
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCurrentDate:[NSDate date:@"2020-1-15 11:11" WithFormat:@"yyyy-MM-dd HH:mm"] CompleteBlock:^(NSDate *startDate, NSDate *endDate) {
        NSLog(@"\n开始时间： %@，结束时间：%@",startDate,endDate);
        self.startTimeText.text = [startDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        self.endtimeText.text = [endDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
    }];
    
//    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate,NSDate *endDate) {
//        NSLog(@"\n开始时间： %@，结束时间：%@",startDate,endDate);
//        self.startTimeText.text = [startDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
//        self.endtimeText.text = [endDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
//    }];
    datepicker.datePickerStyle = DateStyleShowYearMonthDayHourMinute;
    datepicker.dateType = DateTypeStartDate;
    datepicker.minLimitDate = [NSDate date:@"2017-2-28 12:22" WithFormat:@"yyyy-MM-dd HH:mm"];
    datepicker.maxLimitDate = [NSDate date:@"2018-2-28 12:12" WithFormat:@"yyyy-MM-dd HH:mm"];
    [datepicker show];
}
@end
