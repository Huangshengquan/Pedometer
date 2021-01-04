//
//  XCUtils.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/12.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "XCUtils.h"

@implementation XCUtils

static XCUtils *_utils = nil;

+ (XCUtils *)shareUtils
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _utils = [[self alloc] init];
    });
    return _utils;
    
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _utils = [super allocWithZone:zone];
    });
    return _utils;
}


- (id)copyWithZone:(NSZone *)zone
{
    return _utils;
}

///UILabel 根据文字自适应宽度
+ (float) calculateStrwidthWithStr:(NSString *)str Font: (UIFont *) font
{
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, font.pointSize)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
    
    return ceil(textRect.size.width);
}

///判断字符串中含有几个类型数据
+(NSString *)checkIsHaveNumAndLetter:(NSString*)password{
    
    NSLog(@"=====输入框的值=====%@=====", password);
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:password
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, password.length)];
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];

    if (tNumMatchCount == password.length) {
        //全部符合数字，表示沒有英文
        NSLog(@"=====1=====");
        return @"1";

    } else if (tLetterMatchCount == password.length) {
        //全部符合英文，表示沒有数字
        NSLog(@"=====2=====");
        return @"2";

    } else if (tNumMatchCount + tLetterMatchCount == password.length) {
        //符合英文和符合数字条件的相加等于密码长度
        NSLog(@"=====3=====");
        return @"3";

    } else {
        NSLog(@"=====4=====");
        return @"4";
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
    }

}

///获取当前时间的 年月日 时分秒
+ (NSString *)getCurrentHourMinuteSecond
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    //    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

///获取当前时间的 年月日 时分
+ (NSString*)getCurrentHourMinute
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

///获取当前时间的 年
+ (NSString*)getCurrentYear
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyy"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

///获取当前时间的 年月
+ (NSString*)getCurrentYearMonth
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyy-MM"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

///获取当前时间的 年月日
+ (NSString*)getCurrentYearMonthDay
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

///比较两个日期的大小  日期格式为2016-08-14 08：46：20
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];

    
    NSDate *dta = [dateformater dateFromString:aDate];
    NSDate *dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedSame)
    {
        //        相等
        aa = 0;
    }else if (result == NSOrderedAscending)
    {
        //bDate比aDate大
        aa = 1;
    }else if (result == NSOrderedDescending)
    {
        //bDate比aDate小
        aa = -1;
        
    }
    
    return aa;
}

+ (NSInteger)compareDateTime:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSDate *dta = [dateformater dateFromString:aDate];
    NSDate *dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedSame)
    {
        //        相等
        aa = 0;
    }else if (result == NSOrderedAscending)
    {
        //bDate比aDate大
        aa = 1;
    }else if (result == NSOrderedDescending)
    {
        //bDate比aDate小
        aa = -1;
        
    }
    
    return aa;
}


+ (NSInteger)acceptCompareDateTime:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    
    NSDate *dta = [dateformater dateFromString:aDate];
    NSDate *dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedSame)
    {
        //        相等
        aa = 0;
    }else if (result == NSOrderedAscending)
    {
        //bDate比aDate大
        aa = 1;
    }else if (result == NSOrderedDescending)
    {
        //bDate比aDate小
        aa = -1;
        
    }
    
    return aa;
}


+ (NSString *)compareTimeWithString:(NSString *)aTimeString{//NSDate
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate  *expireDate = [formater dateFromString:aTimeString];
    
    NSDate  *nowDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval1 = [zone secondsFromGMTForDate:expireDate];
    NSInteger interval = [zone secondsFromGMTForDate:nowDate];
    
    NSDate *bidDate = [expireDate  dateByAddingTimeInterval: interval1];
    NSDate *localeDate = [nowDate  dateByAddingTimeInterval: interval];
//    // 当前时间字符串格式
//    NSString *nowDateStr = [formater stringFromDate:localeDate];
//    // 当前时间date格式
//    nowDate = [formater dateFromString:nowDateStr];
    
    NSTimeInterval timeInterval =[bidDate timeIntervalSinceDate:localeDate];
    
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    
    if (days<=0&&hours<=0&&minutes<=0&&seconds<=0) {
        
        //        if (transportType != 1) {
        //            [self loadNewData];
        //        }
        
        return @"已结束";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天 %@时%@分%@秒", dayStr,hoursStr, minutesStr,secondsStr];
    }
    return [NSString stringWithFormat:@"%@时%@分%@秒",hoursStr , minutesStr,secondsStr];
}

- (void)countDownButton:(UIButton *)btn
                 title:(NSString *)title
        countDownTitle:(NSString *)subTitle
            startColor:(UIColor *)sColor
              endColor:(UIColor *)eColor
                 downTime:(NSInteger )downTime
               timeType:(NSInteger )type
{
    
    if (_timer == nil) {
        
        __block NSInteger timeOut = downTime; // 倒计时时间
        
        if (timeOut!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC,  0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeOut <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                    dispatch_source_cancel(self->_timer);
                    self->_timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [btn setTitle:title forState:UIControlStateNormal];
                        btn.backgroundColor = sColor;
                        
                    });
                } else {
                    // 倒计时重新计算 时/分/秒
                    NSInteger days = (int)(timeOut/(3600*24));
                    NSInteger hours = (int)((timeOut-days*24*3600)/3600);
                    NSInteger minute = (int)(timeOut-days*24*3600-hours*3600)/60;
                    NSInteger second = timeOut - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime = @"";
                    
                    if (type == 1) {
                        if (days != 1) {
                            strTime = [NSString stringWithFormat:@"%ld天 %02ld : %02ld : %02ld", days, hours, minute, second];
                        } else {
                            strTime = [NSString stringWithFormat:@"%02ld : %02ld : %02ld", hours, minute, second];
                        }
                        
                    } else if (type == 2) {
                        
                        strTime = [NSString stringWithFormat:@"%02ld : %02ld : %02ld", hours, minute, second];
                        
                    } else if (type == 3) {
                        
                        strTime = [NSString stringWithFormat:@"%02ld", timeOut];
                        
                    }else{
                        
                        strTime = [NSString stringWithFormat:@"%02ld", timeOut];
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [btn setTitle:strTime forState:UIControlStateNormal];
                        btn.backgroundColor = eColor;
                        
                    });
                    
                    timeOut--; // 递减 倒计时-1(总时间以秒来计算)
                }
            });
            dispatch_resume(_timer);
        }
    }
    
}


@end
