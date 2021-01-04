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

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.viewControllers.count > 0) {
        // 此时push进来的viewController是第二个子控制器
        // 自动隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;

        viewController.navigationItem.leftBarButtonItem = [self itemWithTargat:self action:@selector(back) image:@"return_gray" highImage:@"return_gray"];

    }else{
        viewController.hidesBottomBarWhenPushed = NO;
    }

    [super pushViewController:viewController animated:animated];
}

/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
- (UIBarButtonItem *)itemWithTargat:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,35,35)];
    view.backgroundColor = [UIColor redColor];
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    firstButton.frame = CGRectMake(0, 0, 35,35);
    
    [firstButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [firstButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];

    [firstButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    firstButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    return [[UIBarButtonItem alloc] initWithCustomView:firstButton];

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
