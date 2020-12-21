//
//  XCUtils.h
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/12.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCUtils : NSObject

+ (XCUtils *)shareUtils;//构造单例

///UILabel 根据文字自适应宽度
+ (float) calculateStrwidthWithStr:(NSString *)str Font: (UIFont *) font;

///判断字符串中含有几个类型数据
+(NSString *)checkIsHaveNumAndLetter:(NSString*)password;

+ (NSString *)getCurrentHourMinuteSecond;

+ (NSString*)getCurrentHourMinute;

+ (NSString*)getCurrentYear;

+ (NSString*)getCurrentYearMonth;

+ (NSString*)getCurrentYearMonthDay;

//比较两个日期的大小  日期格式为2016-08-14 08：46：20
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate;

+ (NSInteger)compareDateTime:(NSString*)aDate withDate:(NSString*)bDate;

+ (NSInteger)acceptCompareDateTime:(NSString*)aDate withDate:(NSString*)bDate;

+ (NSString *)compareTimeWithString:(NSString *)aTimeString;

@end

NS_ASSUME_NONNULL_END
