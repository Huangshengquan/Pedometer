//
//  ConfigMacro.h
//  Pedometer
//
//  Created by 黄盛全 on 2020/7/16.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#ifndef ConfigMacro_h
#define ConfigMacro_h




/**
*  完美解决Xcode NSLog打印不全的宏
*/
#ifdef DEBUG
#define NSLog(FORMAT, ...) {\
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
[dateFormatter setDateStyle:NSDateFormatterMediumStyle];\
[dateFormatter setTimeStyle:NSDateFormatterShortStyle];\
NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];\
[dateFormatter setTimeZone:timeZone];\
[dateFormatter setDateFormat:@"HH:mm:ss.SSSSSSZ"];\
NSString *str = [dateFormatter stringFromDate:[NSDate date]];\
fprintf(stderr,"\n --TIME：%s %s:%d   %s\n",[str UTF8String],[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[[NSString alloc] initWithData:[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] dataUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding] UTF8String]);\
}
#else
# define NSLog(...);
#endif

//weakSelf宏
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;




#pragma mark - 设备类型和系统版本判断
#define IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IS_IOS9 [[[UIDevice currentDevice] systemVersion] doubleValue]>=9.0

#pragma mark - 目录路径
// Documents目录路径
//#define APP_PATH_DOCUMENT     [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
//#define APP_PATH_CACHES      [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/"]
//#define PRINT_APP_PATH       NSLog(@"\n******** [App Path] *******\n%@\n***************************", NSHomeDirectory());


#pragma mark - 自定义函数

#define APPLICATION ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define Window_key   [UIApplication sharedApplication].keyWindow


#pragma mark - 用于Jason字段取值后赋值
#define MySetValue(dict, value) ((!dict[value] || [dict[value] isKindOfClass:[NSNull class]])?@"":dict[value])
#define MySetValueNumber(dict, value) ((!dict[value] || [dict[value] isKindOfClass:[NSNull class]])?@0:dict[value])
#define MySetStr(value) (!value || [value isKindOfClass:[NSNull class]])?@"":value





#pragma mark - 通知事件的名字

#define CHOOSEROOTVC            @"chooseRootVC"


#endif /* ConfigMacro_h */
