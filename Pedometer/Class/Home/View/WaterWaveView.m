//
//  WaterWaveView.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/22.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "WaterWaveView.h"

@implementation WaterWaveView
{
    CGFloat a;
    CGFloat w;
    CGFloat φ;
    CGFloat k;
    
    
    CGFloat viewHeight;
    CGFloat viewWidth;
    
    CGFloat speed;
    
    CADisplayLink *displayLink;
    
    UIBezierPath *path1;
    UIBezierPath *path2;
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initData];
        self.backgroundColor = [UIColor clearColor];
        
//        dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
//
//        dispatch_async(queue, ^{
//            // 追加任务 1
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
//            self->displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(waveAnimation)];
//            [self->displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//        });
        
        
        
        
    }
    return self;
}


#pragma mark - 初始化
- (void)initData
{
    viewWidth = self.bounds.size.width;
    viewHeight = self.bounds.size.height;
    
    a = viewHeight/20;
    w = 2*M_PI/(viewWidth*0.9);
  
    speed = 0.08;
}

- (void)drawRect:(CGRect)rect
{
    [self drawStar];
    [self drawWave];
}


#pragma mark - 五角星
- (void)drawStar
{
    
    path1 = [UIBezierPath
                          bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.f,self.bounds.size.height/2.f)
                          radius:self.bounds.size.width/2.f
                          startAngle:0
                          endAngle:M_PI *2
                          clockwise:YES];
    
    
    
    //创建一个shapeLayer
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    layer.path = path1.CGPath;                         //从bezier曲线获取到的形状
    layer.strokeColor = [UIColor greenColor].CGColor; //边缘线的颜色
    layer.fillColor = [UIColor clearColor].CGColor;   //闭环填充的颜色
    layer.lineCap = kCALineCapSquare;                  //边缘线的类型
    layer.lineWidth = 4.0f;                            //线条宽度
    
    //    layer.strokeStart = 0.0f;
    //    layer.strokeEnd = 0.0f;
    //    self.layer.mask = layer;
    //    [path stroke];
    //    //将layer添加进图层
    
    [self.layer addSublayer:layer];
    //剪切当前画布区域，之后的绘图都在该区域中进行
    [[UIColor lightGrayColor] setFill];
    [path1 fill];
    [path1 addClip];
    
}

#pragma mark - 绘制波纹
- (void)drawWave
{
    path2 = [UIBezierPath bezierPath];
    
    
    for (CGFloat x = 0.0; x <= viewWidth; x ++) {
        CGFloat y = a*sin(w*x + φ) + (1-_progress)*(viewHeight + 2*a);
        if (x == 0) {
            //起始点
            [path2 moveToPoint:CGPointMake(x, y - a)];
        } else {
            [path2 addLineToPoint:CGPointMake(x, y - a)];
        }
    }
    //闭合path
    [path2 addLineToPoint:CGPointMake(viewWidth, viewHeight)];
    [path2 addLineToPoint:CGPointMake(0, viewHeight)];
    [path2 closePath];
    
    [[UIColor redColor] setFill];
    [path2 fill];
}


#pragma mark - animation
- (void)waveAnimation
{
    φ += speed;
    [self setNeedsDisplay];
}


-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    if (displayLink) {
        [displayLink invalidate];
        displayLink = nil;
    }
    
    //以屏幕刷新速度为周期刷新曲线的位置
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(waveAnimation)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}


- (void)dealloc
{
    [self stop];
    [displayLink invalidate];
    displayLink = nil;
}

-(void)stop
{
    if (displayLink) {
        [displayLink invalidate];
        displayLink = nil;
    }
    if (path1) {
        path1 = nil;
    }
    if (path2) {
        path2 = nil;
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
