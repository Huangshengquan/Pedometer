//
//  XCPageView.h
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/17.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XCPageView;

@protocol XCPageViewDelegate <NSObject>

@optional
/**
 *  当被点击时调用，并且可以得到点击页码的下标
 */
- (void)pageViewDidClick:(XCPageView *)pageView atCurrentPage:(NSInteger)currentPage;

@end

@interface XCPageView : UIView

@property (weak, nonatomic) NSTimer *timer;

/**
 *  代理属性
 */
@property (weak, nonatomic) id<XCPageViewDelegate> delegate;

/**
 *  图片名称数组，传入之后会自动加载图片
 */
@property (strong, nonatomic) NSArray *imagesName;

/**
 *  当前页小圆点颜色，默认是白色
 */
@property (strong, nonatomic) UIColor *currentIndicatorColor;

/**
 *  其它页小圆点颜色，默认是亮灰色
 */
@property (strong, nonatomic) UIColor *pageIndicatorColor;

/**
 *  定时器执行时间间隔，默认是两秒。如果设置为0，则不自动滚动
 */
@property (assign, nonatomic) NSTimeInterval timerInterval;

/**
 *  返回R0PageView的对象
 */
//+ (instancetype)pageView;
- (instancetype)initWithFrame:(CGRect)frame;


@end

NS_ASSUME_NONNULL_END
