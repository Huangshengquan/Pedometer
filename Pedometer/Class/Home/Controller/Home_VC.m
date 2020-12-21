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


@interface Home_VC ()<UINavigationControllerDelegate>


@property (nonatomic, strong) CMPedometer * pedonmeter;

@end

@implementation Home_VC

- (void)dealloc {
    self.navigationController.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.title = @"首页";
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationController.delegate = self;
    
    /// 创建计步器对象
    if ([CMPedometer isStepCountingAvailable]) { // 8.0 之后可使用
        
        self.pedonmeter = [[CMPedometer alloc] init];
        
    }
    
    [self initView];
  
}

- (void)initView{
    
    XCPageView *pageView = [[XCPageView alloc]initWithFrame:CGRectMake(20, 60, MainScreen_Width - 40, 200)];
    pageView.imagesName = @[@"image_01",@"image_02",@"image_03",@"image_04",@"image_05"];;
    [self.view addSubview:pageView];
    
    
}


///统计从某个时间开始到现在的步数
- (void)startToNowTntervalSteps:(NSString *)startTime{
    
    [self.pedonmeter startPedometerUpdatesFromDate:[self stringToData:startTime] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        
        if (!error) {
            
        } else {
            
        }
        
    }];
    
}

///统计从某个时间开始到某个时间结束的步数
- (void)timeTntervalSteps:(NSString *)startTime end:(NSString *)endTime{
    
    [self.pedonmeter queryPedometerDataFromDate:[self stringToData:startTime] toDate:[self stringToData:endTime] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        
        if (!error) {
            
        } else {
            
        }
        
    }];
    
}

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





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
