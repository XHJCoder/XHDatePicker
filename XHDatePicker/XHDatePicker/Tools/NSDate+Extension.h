//
//  NSDate+Extension.h
//  zhidianLock
//
//  Created by 江欣华 on 16/6/14.
//  Copyright © 2016年 zhidiankeji. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSCFW_SECOND_MINUTE     60
#define kSCFW_SECOND_HOUR       3600
#define kSCFW_SECOND_DAY		86400
#define kSCFW_SECOND_WEEK       604800
#define kSCFW_SECOND_YEAR       31556926

@interface NSDate (Extension)

/// 时间戳
- (NSTimeInterval)timestamp;

- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;

- (NSString *)weekday;

- (NSInteger)weekOfMonth;
- (NSInteger)weekOfYear;

/// 获取月份的天数
- (NSInteger)numberOfDaysInMonth;

/// 判断是否闰年
- (BOOL)isLeapYear;

/// 时间转字符串
- (NSString *)stringWithFormat:(NSString *)format;

/// 一天的开始时间
- (NSDate *)beginOfDay;
/// 一天的结束时间
- (NSDate *)endOfDay;

/// 是否是同一天
- (BOOL)isSameDay:(NSDate *)anotherDate;

/// 日期相隔多少天
- (NSInteger)daysSinceDate:(NSDate *)anotherDate;

/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

+ (NSDate *)date:(NSString *)datestr WithFormat:(NSString *)format;


@end
