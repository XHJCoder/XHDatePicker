//
//  TableViewController.m
//  XHDatePicker
//
//  Created by XHJCoder on 2018/4/10.
//  Copyright © 2018年 江欣华. All rights reserved.
//

#import "TableViewController.h"
#import "XHDatePickerView.h"
#import "NSDate+XHExtension.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XHDatePickerView *datePicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *date, NSString *dateString) {
        NSLog(@"%@ , %@",date, dateString);
    }];
    datePicker.themeColor = [UIColor redColor];
    datePicker.datePickerMode = (int)indexPath.row;
    datePicker.minimumDate = [NSDate date:@"2015-01-14 12:14" WithFormat:@"yyyy-MM-dd HH:mm"];
    datePicker.maximumDate = [NSDate date:@"2022-11-23 07:55" WithFormat:@"yyyy-MM-dd HH:mm"];
    datePicker.currentDate = [NSDate dateTomorrow];
    datePicker.dateFormatter = @"yyyy年MM月dd日 HH:mm";
//    datePicker.themeColor = [UIColor colorWithRed:(arc4random_uniform(256) / 255.0) green:(arc4random_uniform(256) / 255.0) blue:(arc4random_uniform(256) / 255.0) alpha:1];
    [datePicker show];
}

@end
