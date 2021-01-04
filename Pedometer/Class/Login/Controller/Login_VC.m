//
//  Login_VC.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/29.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "Login_VC.h"
#import "Register_VC.h"
#import "TabBar_VC.h"
#import "BaseDB.h"
#import "UserInfoEntity.h"
#import "Forget_VC.h"


@interface Login_VC ()<UINavigationControllerDelegate>{
    UITextField *accountField;
    UITextField *passwordField;
}

///主界面结构tab
@property (nonatomic , strong) TabBar_VC *tabVC;

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIButton *registerBtn;

@property (nonatomic, strong) UIButton *forgetBtn;

@end

@implementation Login_VC

- (void)dealloc {
    self.navigationController.delegate = nil;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationController.delegate = self;
    
    [self initView];
    
}

- (void)initView{
    
    UIView *accountView = [[UIView alloc]init];
    accountView.layer.masksToBounds = YES;
    accountView.layer.cornerRadius = 4.0f;
    accountView.backgroundColor = mbgColor;
    [self.view addSubview:accountView];
    [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(200);
        make.left.equalTo(30);
        make.right.equalTo(-30);
        make.height.equalTo(50);
    }];
    
    accountField = [[UITextField alloc]init];
    accountField.placeholder = @"请输入登录名";
    accountField.textAlignment = NSTextAlignmentCenter;
    accountField.layer.masksToBounds = YES;
    accountField.layer.cornerRadius = 4.0f;
    [accountView addSubview:accountField];
    [accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(5);
        make.left.equalTo(30);
        make.right.equalTo(-30);
        make.height.equalTo(40);
    }];
    
    UIView *passwordView = [[UIView alloc]init];
    passwordView.layer.masksToBounds = YES;
    passwordView.layer.cornerRadius = 4.0f;
    passwordView.backgroundColor = mbgColor;
    [self.view addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accountView.mas_bottom).equalTo(15);
        make.left.equalTo(30);
        make.right.equalTo(-30);
        make.height.equalTo(50);
    }];
    
    passwordField = [[UITextField alloc]init];
    passwordField.placeholder = @"请输入登录密码";
    passwordField.textAlignment = NSTextAlignmentCenter;
    passwordField.layer.masksToBounds = YES;
    passwordField.layer.cornerRadius = 4.0f;
    passwordField.secureTextEntry = YES;
    [passwordView addSubview:passwordField];
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(5);
        make.left.equalTo(30);
        make.right.equalTo(-30);
        make.height.equalTo(35);
    }];
    
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordView.mas_bottom).equalTo(50);
        make.left.equalTo(30);
        make.right.equalTo(-30);
        make.height.equalTo(45);
    }];
    
    [self.view addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).equalTo(10);
        make.width.equalTo(90);
        make.right.equalTo(-30);
        make.height.equalTo(35);
    }];
    
    [self.view addSubview:self.forgetBtn];
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).equalTo(10);
        make.width.equalTo(90);
        make.left.equalTo(30);
        make.height.equalTo(35);
    }];
    
}

#pragma mark - Action

- (void)loginAction:(UIButton *)btn{
    
    if (accountField.text.length <= 0) {
        [Window_key makeToast:@"请输入用户名或手机号"];
        return;
    }
    
    if (passwordField.text.length <= 0) {
        [Window_key makeToast:@"请输入密码"];
        return;
    }
    
    NSMutableDictionary *dataDic = [DB checkSQL:@"SELECT * FROM t_user;" tableName:@"t_user"];
    NSMutableArray *dataArray = dataDic[@"data"];
    BOOL isExist = NO;
    
    for (NSDictionary *dic in dataArray) {
        
        UserInfoEntity *entity = [[UserInfoEntity alloc]initWithDictionary:dic];
        
        if ([entity.mobile isEqualToString:accountField.text] || [entity.name isEqualToString:accountField.text]) {
            
            isExist = YES;
            
            if ([entity.password isEqualToString:passwordField.text]) {
                //保存为已经进入app
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstIn"];
                [[NSUserDefaults standardUserDefaults] synchronize];//及时保存 不等到按home键就保存内容
                [[NSUserDefaults standardUserDefaults] setObject:@"login" forKey:@"login"];
                
                if (self.chooseRootVCBack) {
                    
                    self.chooseRootVCBack();
                    
                }else{
                    
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                    
                };

                break;
                
            } else {
                [Window_key makeToast:@"密码输入错误"];
                return;
            }
        }
        
    }
    
    if (!isExist) {
        [Window_key makeToast:@"用户不存在"];
        return;
    }
    
    
    
}

- (void)registerAction:(UIButton *)btn{
    
    Register_VC *vc = [[Register_VC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)forgetAction:(UIButton *)btn{
    
    Forget_VC *vc = [[Forget_VC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];

    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
    
}

#pragma mark - Lazy

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:Main_Blue];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 4.0f;
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_registerBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:Main_Blue forState:UIControlStateNormal];
        [_registerBtn setBackgroundColor:[UIColor whiteColor]];
        [_registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}


- (UIButton *)forgetBtn {
    if (!_forgetBtn) {
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:Main_Blue forState:UIControlStateNormal];
        [_forgetBtn setBackgroundColor:[UIColor whiteColor]];
        [_forgetBtn addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
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
