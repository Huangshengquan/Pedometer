//
//  BaseViewController.m
//  Pedometer
//
//  Created by 黄盛全 on 2021/1/4.
//  Copyright © 2021 黄盛全. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+DCURLRouter.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
        
    [self showHUD];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
        
    [self hideHUD];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)showHUD
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideHUD
{
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
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
