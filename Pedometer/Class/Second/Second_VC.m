//
//  Second_VC.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/11/10.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "Second_VC.h"
#import "Test_VC.h"

@interface Second_VC ()

@end

@implementation Second_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    
}
- (IBAction)goActions:(id)sender {
    
    Test_VC *vc = [[Test_VC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
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
