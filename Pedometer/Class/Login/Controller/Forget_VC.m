//
//  Forget_VC.m
//  Pedometer
//
//  Created by 黄盛全 on 2021/1/4.
//  Copyright © 2021 黄盛全. All rights reserved.
//

#import "Forget_VC.h"
#import "BaseDB.h"
#import "UserInfoEntity.h"

@interface Forget_VC (){
    UITextField *phoneField;
    UITextField *codeField;
    UITextField *passwordField;
    UITextField *sureField;
    UIButton *passwordBtn;
    UIButton *sureBtn;
    UIButton *codeBtn;
}

@property (nonatomic, strong) UIButton *forgetBtn;

@end

@implementation Forget_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"忘记密码";
    
    self.view.backgroundColor = mbgColor;
    
    [self initView];
    
}

- (void)initView{
    
    [self.view addSubview:self.forgetBtn];
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-HOME_INDICATOR_HEIGHT);
        make.left.right.equalTo(0);
        make.height.equalTo(45);
    }];
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(20);
        make.height.equalTo(300);
    }];

    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.text = @"手机号";
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(15);
        make.left.equalTo(20);
        make.width.equalTo(90);
        make.height.equalTo(25);
    }];
    
    phoneField = [[UITextField alloc]init];
    phoneField.placeholder = @"请输入手机号";
    phoneField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:phoneField];
    [phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneLabel.mas_centerY);
        make.left.equalTo(phoneLabel.mas_right).equalTo(10);
        make.right.equalTo(-20);
        make.height.equalTo(25);
    }];
    
    UIView *phoneLine = [[UIView alloc]init];
    phoneLine.backgroundColor = mbgColor;
    [self.view addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLabel.mas_bottom).equalTo(15);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(1);
    }];
    
    
    UILabel *codeLabel = [[UILabel alloc]init];
    codeLabel.text = @"验证码";
    [self.view addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLine.mas_bottom).equalTo(15);
        make.left.equalTo(20);
        make.width.equalTo(90);
        make.height.equalTo(25);
    }];
    
    codeField = [[UITextField alloc]init];
    codeField.placeholder = @"请输入验证码";
    codeField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:codeField];
    [codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(codeLabel.mas_centerY);
        make.left.equalTo(codeLabel.mas_right).equalTo(10);
        make.right.equalTo(-100);
        make.height.equalTo(25);
    }];
    
    codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    codeBtn.backgroundColor = Main_Blue;
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    codeBtn.layer.cornerRadius = 5;
    codeBtn.layer.masksToBounds = YES;
    [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [codeBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeBtn];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(codeField.mas_centerY);
        make.right.equalTo(-10);
        make.width.equalTo(90);
        make.height.equalTo(30);
    }];
    
    UIView *codeLine = [[UIView alloc]init];
    codeLine.backgroundColor = mbgColor;
    [self.view addSubview:codeLine];
    [codeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeLabel.mas_bottom).equalTo(15);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(1);
    }];
    
    UILabel *passwordLabel = [[UILabel alloc]init];
    passwordLabel.text = @"密码";
    [self.view addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeLine.mas_bottom).equalTo(15);
        make.left.equalTo(20);
        make.width.equalTo(90);
        make.height.equalTo(25);
    }];
    
    passwordField = [[UITextField alloc]init];
    passwordField.placeholder = @"请输入密码";
    passwordField.clearButtonMode = UITextFieldViewModeAlways;
    passwordField.secureTextEntry = YES;
    [self.view addSubview:passwordField];
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(passwordLabel.mas_centerY);
        make.left.equalTo(passwordLabel.mas_right).equalTo(10);
        make.right.equalTo(-50);
        make.height.equalTo(25);
    }];
    
    passwordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    passwordBtn.backgroundColor = UIColor.clearColor;
    passwordBtn.selected = YES;
    passwordBtn.tag = 666666;
    [passwordBtn setImage:[UIImage imageNamed:@"login_eye_close"] forState:UIControlStateNormal];
    [passwordBtn addTarget:self action:@selector(changeBtnImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:passwordBtn];
    [passwordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(passwordField.mas_centerY);
        make.right.equalTo(-10);
        make.width.height.equalTo(30);
    }];
    
    UIView *passwordLine = [[UIView alloc]init];
    passwordLine.backgroundColor = mbgColor;
    [self.view addSubview:passwordLine];
    [passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordLabel.mas_bottom).equalTo(15);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(1);
    }];
    
    UILabel *sureLabel = [[UILabel alloc]init];
    sureLabel.text = @"确认密码";
    [self.view addSubview:sureLabel];
    [sureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordLine.mas_bottom).equalTo(15);
        make.left.equalTo(20);
        make.width.equalTo(90);
        make.height.equalTo(25);
    }];
    
    sureField = [[UITextField alloc]init];
    sureField.placeholder = @"请再次输入密码";
    sureField.clearButtonMode = UITextFieldViewModeAlways;
    sureField.secureTextEntry = YES;
    sureField.keyboardType = UIKeyboardTypeAlphabet;
    [self.view addSubview:sureField];
    [sureField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sureLabel.mas_centerY);
        make.left.equalTo(sureLabel.mas_right).equalTo(10);
        make.right.equalTo(-50);
        make.height.equalTo(25);
    }];
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.backgroundColor = UIColor.clearColor;
    sureBtn.selected = YES;
    sureBtn.tag = 999999;
    [sureBtn setImage:[UIImage imageNamed:@"login_eye_close"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(changeBtnImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sureField.mas_centerY);
        make.right.equalTo(-10);
        make.width.height.equalTo(30);
    }];
    
    [backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(20);
        make.bottom.equalTo(sureField.mas_bottom).equalTo(20);
    }];
    
}

#pragma mark - Action

- (void)changeBtnImageAction:(UIButton *)btn{
            
    if (btn.selected) {
        
        [btn setImage:[UIImage imageNamed:@"login_eye_open"] forState:UIControlStateNormal];
        btn.selected = NO;
        
        if (btn.tag == 666666) {
            passwordField.secureTextEntry = NO;
        }else{
            sureField.secureTextEntry = NO;
        }
        
    }else{
        
        [btn setImage:[UIImage imageNamed:@"login_eye_close"] forState:UIControlStateNormal];
        btn.selected = YES;
        
        if (btn.tag == 666666) {
            passwordField.secureTextEntry = YES;
        }else{
            sureField.secureTextEntry = YES;
        }
        
    }
    
}

- (void)getCodeAction:(UIButton *)btn{
    
    [Utils countDownButton:btn title:@"重新获取" countDownTitle:@"" startColor:Main_Blue endColor:Main_Gray downTime:60 timeType:3];
    
}

- (void)forgetAction:(UIButton *)btn{

    if (phoneField.text.length <= 0) {
        [Window_key makeToast:@"请输入手机号码"];
        return;
    }
    
    if (codeField.text.length <= 0) {
        [Window_key makeToast:@"请输入验证码"];
        return;
    }
    
    if (passwordField.text.length <= 0) {
        [Window_key makeToast:@"请输入密码"];
        return;
    }
    
    if (sureField.text.length <= 0) {
        [Window_key makeToast:@"请再次输入密码"];
        return;
    }
    
    if (![sureField.text isEqualToString:passwordField.text]) {
        [Window_key makeToast:@"两次密码输入不一致"];
        return;
    }
    
    NSMutableDictionary *dataDic = [DB checkSQL:@"SELECT * FROM t_user;" tableName:@"t_user"];
    NSMutableArray *dataArray = dataDic[@"data"];
    BOOL isExist = NO;

    for (NSDictionary *dic in dataArray) {

        UserInfoEntity *entity = [[UserInfoEntity alloc]initWithDictionary:dic];

        if ([entity.mobile isEqualToString:phoneField.text]) {
            isExist = YES;
            break;
        }

    }
    
    if (!isExist) {
        [Window_key makeToast:@"当前手机号没有注册过该App"];
        return;
    }
    
    [DB openDB:@"CREATE TABLE IF NOT EXISTS 't_user' ( 'userid' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'name' TEXT,'mobile' TEXT,'password' TEXT);" tableName:@"t_user"];

    [DB updateSQL:[NSString stringWithFormat:@"UPDATE t_user SET password = %@ WHERE mobile = %@ ;", passwordField.text, phoneField.text] tableName:@"t_user"];

    NSMutableDictionary *userDic = [DB checkSQL:@"SELECT * FROM t_user;" tableName:@"t_user"];

    NSLog(@"=====%@=====",userDic);
    
}


#pragma mark - Lazy

- (UIButton *)forgetBtn {
    if (!_forgetBtn) {
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_forgetBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_forgetBtn setBackgroundColor:Main_Blue];
        [_forgetBtn addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}

@end
