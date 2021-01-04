//
//  XCWaterWaveView.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/22.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "XCWaterWaveView.h"

#define XCDefaultFirstWaveColor [UIColor colorWithRed:34/255.0 green:116/255.0 blue:210/255.0 alpha:1]
#define XCDefaultSecondWaveColor [UIColor colorWithRed:34/255.0 green:116/255.0 blue:210/255.0 alpha:0.3]
#define XCDefaultBackGroundColor [UIColor colorWithRed:96/255.0f green:159/255.0f blue:150/255.0f alpha:1]

// 默认高度
static CGFloat const XCWaveAmplitude = 10;
//默认初相
static CGFloat const XCWaveX = 0;

@interface XCWaterWaveView()
{
    CADisplayLink *_disPlayLink;
    /** 曲线角速度 */
    CGFloat _wavePalstance;
    /** 曲线初相 */
    CGFloat _waveX;
    /** 曲线偏距 */
    CGFloat _waveY;
}
 /** 两条波浪 */
@property (nonatomic,strong)CAShapeLayer * waveLayer1;
@property (nonatomic,strong)CAShapeLayer * waveLayer2;

@end

@implementation XCWaterWaveView



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.bounds = CGRectMake(0, 0, MIN(frame.size.width, frame.size.height), MIN(frame.size.width, frame.size.height));
        //振幅
        _waveAmplitude = XCWaveAmplitude;
        //角速度
        /*
         决定波的宽度和周期，比如，我们可以看到上面的例子中是一个周期的波曲线，
         一个波峰、一个波谷，如果我们想在0到2π这个距离显示2个完整的波曲线，那么周期就是π。
         ω常量 _wavePalstance计算如下 可以根据自己的需求计算
         */
        _wavePalstance = M_PI/self.bounds.size.width;
        //偏距
        _waveY = self.bounds.size.height;
        //初相
        _waveX = XCWaveX;
        //x轴移动速度
        _waveMoveSpeed = _wavePalstance * 2;
        
        //添加点击监听
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
        [gesture addTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:gesture];
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    //初始化波浪
    [self.layer addSublayer:self.waveLayer1];
    //上层
    [self.layer addSublayer:self.waveLayer2];
    //圆
    self.layer.cornerRadius = self.bounds.size.width/2.0f;
    self.layer.masksToBounds = true;
    self.backgroundColor = XCDefaultBackGroundColor;
    
    [self addSubview:self.targetStepsLabel];
    [self.targetStepsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).equalTo(40);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(130).priorityLow();
        make.height.equalTo(20).priorityLow();
    }];

    [self addSubview:self.dayStepsLabel];
    [self.dayStepsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(MainScreen_Width - 100);
        make.height.equalTo(25).priorityLow();
    }];
    
    [self addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dayStepsLabel.mas_bottom).equalTo(10);
        make.width.equalTo(MainScreen_Width - 100);
        make.height.equalTo(20).priorityLow();
    }];
    
}

/**
 *  处理点击事件
 */
- (void)tap:(UITapGestureRecognizer *)gesture {
    if (self.refreshStepsBlock) {
        self.refreshStepsBlock();
    }
}


#pragma mark -- 波动动画实现
- (void)waveAnimation:(CADisplayLink *)link{
    _waveX += _waveMoveSpeed;
    [self updateWaveY];//更新波浪的高度位置
    [self startWaveAnimation];//波浪轨迹和动画
}
//更新偏距的大小 直到达到目标偏距 让wave有一个匀速增长的效果
-(void)updateWaveY
{
    CGFloat targetY = self.bounds.size.height - _progress * self.bounds.size.height;
    if (_waveY < targetY) {
        _waveY += 2;
    }
    if (_waveY > targetY ) {
        _waveY -= 2;
    }
}

-(void)startWaveAnimation
{
    //波浪宽度
    CGFloat waterWaveWidth = self.bounds.size.width;
    //初始化运动路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGMutablePathRef maskPath = CGPathCreateMutable();
    //设置起始位置
    CGPathMoveToPoint(path, nil, 0, _waveY);
    //设置起始位置
    CGPathMoveToPoint(maskPath, nil, 0, _waveY);
    //初始化波浪其实Y为偏距
    CGFloat y = _waveY;
    //正弦曲线公式为： y=Asin(ωx+φ)+k;
    for (float x = 0.0f; x <= waterWaveWidth ; x++) {
        y = _waveAmplitude * sin(_wavePalstance * x + _waveX) + _waveY;
        
        CGPathAddLineToPoint(path, nil, x, y);
        
    }
    for (float x = 0.0f; x <= waterWaveWidth ; x++) {
        y = _waveAmplitude * cos(_wavePalstance * x + _waveX) + _waveY;
        
        CGPathAddLineToPoint(maskPath, nil, x, y);
    }
    [self updateLayer:_waveLayer1 path:path];
    [self updateLayer:_waveLayer2 path:maskPath];
    
    if (self.firstWaveColor) {
        self.waveLayer1.fillColor = self.firstWaveColor.CGColor;
        self.waveLayer1.strokeColor = self.firstWaveColor.CGColor;
    }
    if (self.secondWaveColor) {
        self.waveLayer2.fillColor = self.secondWaveColor.CGColor;
        self.waveLayer2.strokeColor = self.secondWaveColor.CGColor;
    }
}

-(void)updateLayer:(CAShapeLayer *)layer path:(CGMutablePathRef )path
{
    //填充底部颜色
    CGFloat waterWaveWidth = self.bounds.size.width;
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    layer.path = path;
    CGPathRelease(path);
}


#pragma mark - setter


-(void)setWaveBackgroundColor:(UIColor *)waveBackgroundColor{
    _waveBackgroundColor = waveBackgroundColor;
    self.backgroundColor = waveBackgroundColor;
}

-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    if (_disPlayLink) {
        [_disPlayLink invalidate];
        _disPlayLink = nil;
    }
    
    //以屏幕刷新速度为周期刷新曲线的位置
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(waveAnimation:)];
    [_disPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - 停止动画
-(void)stop
{
    if (_disPlayLink) {
        [_disPlayLink invalidate];
        _disPlayLink = nil;
    }
}

-(void)dealloc
{
    [self stop];
    if (_waveLayer1) {
        [_waveLayer1 removeFromSuperlayer];
        _waveLayer1 = nil;
    }
    if (_waveLayer2) {
        [_waveLayer2 removeFromSuperlayer];
        _waveLayer2 = nil;
    }
    
}



#pragma mark - Lazying

- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc]init];
        _tipsLabel.text = @"当前步数";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.font = [UIFont systemFontOfSize:16];
    }
    return _tipsLabel;
}

- (UILabel *)dayStepsLabel{
    if (!_dayStepsLabel) {
        _dayStepsLabel = [[UILabel alloc]init];
        _dayStepsLabel.text = @"0";
        _dayStepsLabel.textAlignment = NSTextAlignmentCenter;
        _dayStepsLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:60];
    }
    return _dayStepsLabel;
}

- (UILabel *)targetStepsLabel{
    if (!_targetStepsLabel) {
        _targetStepsLabel = [[UILabel alloc]init];
        _targetStepsLabel.text = @"目标：8000";
        _targetStepsLabel.textAlignment = NSTextAlignmentCenter;
        _targetStepsLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    }
    return _targetStepsLabel;
}

/**
 正弦曲线公式可表示为y=Asin(ωx+φ)+k：
 A，振幅，最高和最低的距离
 W，角速度，用于控制周期大小，单位x中的起伏个数
 K，偏距，曲线整体上下偏移量
 φ，初相，左右移动的值
 
 这个效果主要的思路是添加两条曲线 一条正玄曲线、一条余弦曲线 然后在曲线下添加深浅不同的背景颜色，从而达到波浪显示的效果
 */

-(CAShapeLayer *)waveLayer1{
    if (!_waveLayer1) {
        _waveLayer1 = [CAShapeLayer layer];
        _waveLayer1.fillColor = XCDefaultFirstWaveColor.CGColor;
        _waveLayer1.strokeColor = XCDefaultFirstWaveColor.CGColor;
    }
    return _waveLayer1;
}

-(CAShapeLayer *)waveLayer2{
    if (!_waveLayer2) {
        _waveLayer2 = [CAShapeLayer layer];
        _waveLayer2.fillColor = XCDefaultSecondWaveColor.CGColor;
        _waveLayer2.strokeColor = XCDefaultSecondWaveColor.CGColor;
    }
    return _waveLayer2;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
