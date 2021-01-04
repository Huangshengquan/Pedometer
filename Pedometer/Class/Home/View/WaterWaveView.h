//
//  WaterWaveView.h
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/22.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaterWaveView : UIView

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) UILabel * tipsLabel;

@property (nonatomic, strong) UILabel *dayStepsLabel;

@property (nonatomic, strong) UILabel *targetStepsLabel;

-(void)stop;

@end

NS_ASSUME_NONNULL_END
