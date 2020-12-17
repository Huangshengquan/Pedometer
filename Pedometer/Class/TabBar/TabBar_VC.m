//
//  TabBar_VC.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/11/10.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "TabBar_VC.h"
#import "NavView_VC.h"
#import "Home_VC.h"
#import "Second_VC.h"
#import "Third_VC.h"


@interface TabBar_VC ()

@end

@implementation TabBar_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.backgroundColor = UIColor.whiteColor;
    
    [self initView];
    
}

- (void)initView{
    
    NSArray *title = @[@"首页", @"信息", @"我的"];
    NSArray *image = @[@"home_gray", @"second_gray", @"third_gray"];
    NSArray *selectImage = @[@"home_blue", @"second_blue", @"third_blue"];
    
    Home_VC *homeVC = [[Home_VC alloc] init];
    Second_VC *secondVC = [[Second_VC alloc] init];
    Third_VC *thirdVC = [[Third_VC alloc] init];
    
    NSArray *viewController = @[homeVC, secondVC, thirdVC];
    
    for (int i = 0; i < viewController.count; i++)
    {
        UIViewController *childVc = viewController[i];
        [self setVC:childVc title:title[i] image:image[i] selectedImage:selectImage[i]];
    }
    
}

- (void)setVC:(UIViewController *)VC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    VC.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:image];
    VC.edgesForExtendedLayout = UIRectEdgeNone;
    [VC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(78, 78, 78)} forState:UIControlStateNormal];
    [VC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBCOLOR(14, 97, 199)} forState:UIControlStateSelected];

    NavView_VC *navigationVc = [[NavView_VC alloc] initWithRootViewController:VC];
    [self addChildViewController:navigationVc];
    
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
