//
//  Home_VC.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/11/10.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "Home_VC.h"
#import <CoreMotion/CoreMotion.h>
#import "XCPageView.h"
#import "WaterWaveView.h"
#import "XCWaterWaveView.h"


//#import "Toast.h"


@interface Home_VC ()<UINavigationControllerDelegate, XCPageViewDelegate>{
    XCPageView *pageView;
    XCWaterWaveView *waveView;
    NSInteger targetNumber;
    
}


@property (nonatomic, strong) CMPedometer * pedonmeter;

@property (nonatomic, strong) CMPedometerData *pedometerData;

@property (nonatomic, strong) UILabel * tipsLabel;

@property (nonatomic, strong) UILabel *dayStepsLabel;

@property (nonatomic, strong) UILabel *targetStepsLabel;

@end

@implementation Home_VC

- (void)dealloc {
    self.navigationController.delegate = nil;
    [waveView stop];
}

- (void)viewDidAppear:(BOOL)animated{
    
}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.title = @"首页";
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationController.delegate = self;
      
    //设置目标步数
    targetNumber = 8000;
    
    /// 创建计步器对象
    if ([CMPedometer isStepCountingAvailable]) { // 8.0 之后可使用
        
        self.pedonmeter = [[CMPedometer alloc] init];
        
    }
        
    [self initView];
    
   
  
}

- (void)initView{
    
//    WeakSelf(weakSelf);
    
    pageView = [[XCPageView alloc]initWithFrame:CGRectMake(20, 60, MainScreen_Width - 40, 200)];
    pageView.imagesName = @[@"image_01",@"image_02",@"image_03",@"image_04",@"image_05"];
    pageView.delegate = self;
    [self.view addSubview:pageView];
    
    
    waveView = [[XCWaterWaveView alloc] initWithFrame:CGRectMake(50, 300, (MainScreen_Width - 100), (MainScreen_Width - 100))];
    waveView.targetStepsLabel.text = [NSString stringWithFormat:@"目标：%ld",(long)targetNumber];
    [self.view addSubview:waveView];
    
    waveView.refreshStepsBlock = ^{
        
    };
    
    
    [self startToNowTntervalSteps:[NSString stringWithFormat:@"%@ 00:00:00",[XCUtils getCurrentYearMonthDay]]];
    
}

#pragma mark - XCPageViewDelegate

- (void)pageViewDidClick:(XCPageView *)pageView atCurrentPage:(NSInteger)currentPage{
    NSLog(@"======%ld=======",(long)currentPage);
}

#pragma mark - 步数计算

///统计从某个时间开始到现在的步数
- (void)startToNowTntervalSteps:(NSString *)startTime{
    
    
    if ([CMPedometer isStepCountingAvailable]&& [CMPedometer isDistanceAvailable]) {
        
        [self.pedonmeter startPedometerUpdatesFromDate:[self stringToData:startTime] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            
            if (!error) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self->waveView.dayStepsLabel.text = [NSString stringWithFormat:@"%@",pedometerData.numberOfSteps];
                    CGFloat numberOfSteps = [pedometerData.numberOfSteps floatValue];
                    self->waveView.progress = numberOfSteps/self->targetNumber;
                    NSLog(@"=====%f------",numberOfSteps/self->targetNumber);
                });
                
            } else {
                
                [self.view makeToast:@"获取步数失败"];
                
            }
            
        }];
        
    }else{
        [self.view makeToast:@"当前设备不支持步进计数功能"];
    }
    
    
    
}

///统计从某个时间开始到某个时间结束的步数
- (void)timeTntervalSteps:(NSString *)startTime end:(NSString *)endTime{
    
    [self.pedonmeter queryPedometerDataFromDate:[self stringToData:startTime] toDate:[self stringToData:endTime] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        
        if (!error) {
            
        } else {
            
        }
        
    }];
    
}

#pragma mark - 时间转换
- (NSDate *)stringToData:(NSString *)dateString{
    
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateformater dateFromString:dateString];
    return date;
    
}
























#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
    
}



#pragma mark - Lazying

- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc]init];
        _tipsLabel.text = @"今日步数";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    }
    return _tipsLabel;
}

- (UILabel *)dayStepsLabel{
    if (!_dayStepsLabel) {
        _dayStepsLabel = [[UILabel alloc]init];
        _dayStepsLabel.text = @"";
        _dayStepsLabel.layer.masksToBounds = YES;
        _dayStepsLabel.layer.cornerRadius = (MainScreen_Width - 100)/2;
        _dayStepsLabel.layer.borderWidth = 5;
        _dayStepsLabel.layer.borderColor = Main_Blue.CGColor;
        _dayStepsLabel.textAlignment = NSTextAlignmentCenter;
        _dayStepsLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:60];
    }
    return _dayStepsLabel;
}

- (UILabel *)targetStepsLabel{
    if (!_targetStepsLabel) {
        _targetStepsLabel = [[UILabel alloc]init];
        _targetStepsLabel.text = @"目标步数：8000";
        _targetStepsLabel.textAlignment = NSTextAlignmentCenter;
        _targetStepsLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    }
    return _targetStepsLabel;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
