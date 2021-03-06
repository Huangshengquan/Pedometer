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

+ (NSString *)getCurrentHourMinuteSecond
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    //    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

+ (NSString*)getCurrentHourMinute
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

+ (NSString*)getCurrentYear
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

+ (NSString*)getCurrentYearMonth
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

+ (NSString*)getCurrentYearMonthDay
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

//比较两个日期的大小  日期格式为2016-08-14 08：46：20
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



@end
