//
//  XCUtils.h
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/12.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define Utils [XCUtils shareUtils]

@interface XCUtils : NSObject

@property (nonatomic, strong) dispatch_source_t timer;

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


/*
 *GCD 倒计时
 *btn          : 当前点击的按钮
 *title        : 倒计时结束时按钮的title
 *subTitle     : 倒计时过程中的title
 *sColor       : 倒计时结束的按钮背景色
 *eColor       : 倒计时进行时按钮背景色
 *downTime     : 倒计时的时间差
 *type         : 倒计时需要显示的时间类型  1：天 时分秒 2：时分秒 3：只有秒 默认为 3
 */
- (void)countDownButton:(UIButton *)btn
                 title:(NSString *)title
        countDownTitle:(NSString *)subTitle
            startColor:(UIColor *)sColor
              endColor:(UIColor *)eColor
                 downTime:(NSInteger )downTime
               timeType:(NSInteger )type;

@end

NS_ASSUME_NONNULL_END
