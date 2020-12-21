//
//  ColorMacro.h
//  Pedometer
//
//  Created by 黄盛全 on 2020/7/16.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#ifndef ColorMacro_h
#define ColorMacro_h






/**
 *规格尺寸
 */

//设备屏幕大小
//#define MainScreenFrame   [[UIScreen mainScreen] bounds]
#define MainScreenFrame   [UIApplication sharedApplication].keyWindow.rootViewController.view.bounds

//设备屏幕宽
#define MainScreen_Width  MainScreenFrame.size.width
//设备屏幕高
#define MainScreen_Height MainScreenFrame.size.height
//图片旋转
#define degreesToRadians(x)(M_PI*(x)/180.0)

// 判断是否是iPhone X
#define DEVICE_IS_IPHONEX ({BOOL isPhoneX = NO;\
    if (@available(iOS 11.0, *)) {\
        isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
    }\
    (isPhoneX);})

//iphone6P
#define DEVICE_IS_IPHONE6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
//iphone6判断
#define DEVICE_IS_IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//iphone5判断
#define DEVICE_IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//iphone4判断
#define DEVICE_IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)

// 状态栏高度
#define  STATUS_BAR_HEIGHT (DEVICE_IS_IPHONEX ? 44.f : 20.f)
//导航栏高度
#define NAVIGATION_BAR_HEIGHT (DEVICE_IS_IPHONEX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (DEVICE_IS_IPHONEX ? 49.f+34.f : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (DEVICE_IS_IPHONEX ? 34.f : 0.f)

#define GET_BOTTOM_Y(view) (view.frame.origin.y + view.frame.size.height )
#define GET_LEFT_X(view) (view.frame.origin.x + view.frame.size.width)

/**
 *颜色
 */

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

//背景灰
#define mbgColor RGBCOLOR(239, 239, 241)


#endif /* ColorMacro_h */
