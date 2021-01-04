//
//  Mine_VC.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/11/10.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "Mine_VC.h"

@interface Mine_VC ()

@property (nonatomic, strong) UIButton *LogOutBtn;

@end

@implementation Mine_VC

- (void)viewWillAppear:(BOOL)animated{
    [self testGroup];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.LogOutBtn];
    [self.LogOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-HOME_INDICATOR_HEIGHT);
        make.left.right.equalTo(0);
        make.height.equalTo(45);
    }];
    
    
}

#pragma mark -Action

- (void)logOutAction:(UIButton *)btn{
    
    //保存为退出app
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstIn"];
    [[NSUserDefaults standardUserDefaults] synchronize];//及时保存 不等到按home键就保存内容
    [[NSUserDefaults standardUserDefaults] setObject:@"login" forKey:@"login"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CHOOSEROOTVC object:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

/**
 A,B,C,D,E,F
 A,B,C:并发执行
 */

- (void)testGroup {
    
    //D --> A , B
    dispatch_group_t g1 = dispatch_group_create();//创建结构体
    
    //E --> B , C
    dispatch_group_t g2 = dispatch_group_create();//创建结构体
    
    //F --> D , E
    dispatch_group_t g3 = dispatch_group_create();//创建结构体
    
    // value = 2
    dispatch_group_enter(g1);//类似计数器的操作
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"A-----");
        }
        dispatch_group_leave(g1);
    });
    
    dispatch_group_enter(g1);
    dispatch_group_enter(g2);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"B-----");
        }
        dispatch_group_leave(g1);
        dispatch_group_leave(g2);
    });
    
    dispatch_group_enter(g2);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"C-----");
        }
        dispatch_group_leave(g2);
    });
    
    dispatch_group_enter(g3);
    dispatch_group_notify(g1, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (int i = 0; i < 3; i++) {
                NSLog(@"D-----");
            }
            dispatch_group_leave(g3);
        });
    });
    
    dispatch_group_enter(g3);
    dispatch_group_notify(g2, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (int i = 0; i < 3; i++) {
                NSLog(@"E-----");
            }
            dispatch_group_leave(g3);
        });
    });
    
    dispatch_group_notify(g3, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (int i = 0; i < 3; i++) {
                NSLog(@"F-----");
            }
        });
    });
    
    
    
}


#pragma mark - Lazy

- (UIButton *)LogOutBtn {
    if (!_LogOutBtn) {
        _LogOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _LogOutBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_LogOutBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_LogOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_LogOutBtn setBackgroundColor:Main_Blue];
        [_LogOutBtn addTarget:self action:@selector(logOutAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _LogOutBtn;
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
