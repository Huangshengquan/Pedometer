//
//  XCWaterWaveView.h
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/22.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCWaterWaveView : UIView

/** 进度 */
@property(nonatomic,assign)CGFloat progress;

/** 波浪1颜色 */
@property (nonatomic,strong)UIColor * firstWaveColor;

/** 波浪2颜色 */
@property (nonatomic,strong)UIColor * secondWaveColor;

/** 背景颜色 */
@property (nonatomic,strong)UIColor * waveBackgroundColor;

/** 曲线移动速度 */
@property (nonatomic,assign) CGFloat waveMoveSpeed;

/** 曲线振幅 */
@property (nonatomic,assign) CGFloat waveAmplitude;


@property (nonatomic, strong) UILabel * tipsLabel;

@property (nonatomic, strong) UILabel *dayStepsLabel;

@property (nonatomic, strong) UILabel *targetStepsLabel;

@property (nonatomic , copy) void (^refreshStepsBlock)(void);

/** 停止动画 */
-(void)stop;


@end

NS_ASSUME_NONNULL_END
