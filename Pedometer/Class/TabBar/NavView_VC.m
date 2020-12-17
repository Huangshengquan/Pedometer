//
//  NavView_VC.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/11/10.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "NavView_VC.h"

@interface NavView_VC ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation NavView_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //解决导航栏的透明问题
    [self.navigationBar setTranslucent:NO];

    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];

    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationBar.barTintColor = RGBCOLOR(14, 97, 199);

    
}

- (void)back {
    [self popViewControllerAnimated:YES];
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
