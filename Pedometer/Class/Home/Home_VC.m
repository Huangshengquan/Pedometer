//
//  Home_VC.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/11/10.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "Home_VC.h"

@interface Home_VC ()<UITextFieldDelegate, UINavigationControllerDelegate>

@end

@implementation Home_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.title = @"首页";
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationController.delegate = self;
    
    
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//    [dic setValue:@"hello" forKey:@"name"];
//    [dic setValue:@"12" forKey:@"age"];
//
//    if ([dic[@"name"] isEqualToString:@"hello"]) {
//        NSLog(@"========%@=========",dic[@"name"]);
//    } else if([dic[@"age"] isEqualToString:@"12"]) {
//        NSLog(@"========%@=========",dic[@"age"]);
//    }else{
//        NSLog(@"========%@+++++++++++++%@=========",dic[@"name"],dic[@"age"]);
//    }
//
//    for (int i = 0; i <= 4; i ++) {
//        [self switchTest:i];
//    }
    
//    UITextField *passWord = [[UITextField alloc]init];
//    passWord.placeholder = @"密码";
//    passWord.delegate = self;
//    passWord.backgroundColor = UIColor.grayColor;
//    passWord.keyboardType = UIKeyboardTypeASCIICapable;
//    passWord.secureTextEntry = YES;
//    [self.view addSubview:passWord];
//    [passWord mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(50);
//        make.left.equalTo(20);
//        make.right.equalTo(-20);
//        make.height.equalTo(30);
//    }];
//    [passWord addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
//
//    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"1",@"1",@"2",@"2",@"2",@"4" , nil];
//    [array removeObject:@"1"];
//    NSLog(@"===%@===",array);
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
    [dic2 setValue:@"" forKey:@"data"];
    [dic1 setValue:dic2 forKey:@"ha"];
    NSLog(@"%@",dic1);
    
    NSDictionary *infoDic = dic1[@"data"];
    NSLog(@"%@",infoDic);
    if (dic1[@"data"]) {
        NSLog(@"====++++====");
    }
    
    
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)dealloc {
    self.navigationController.delegate = nil;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSLog(@"=====输入框的值=====%@=====", textField.text);
    
    [self checkIsHaveNumAndLetter:[NSString stringWithFormat:@"%@%@", textField.text, string]];
    
    return YES;
    
}

- (void)textChange:(UITextField *)textField{
    
    
    
    [self checkIsHaveNumAndLetter:textField.text];
    
}


-(int)checkIsHaveNumAndLetter:(NSString*)password{
    
    NSLog(@"=====输入框的值=====%@=====", password);
    
    //数字条件

    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];

    

    //符合数字条件的有几个字节

    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:password

                                                                       options:NSMatchingReportProgress

                                                                         range:NSMakeRange(0, password.length)];

    

    //英文字条件

    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];

    

    //符合英文字条件的有几个字节

    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];

    

    if (tNumMatchCount == password.length) {
        //全部符合数字，表示沒有英文
        NSLog(@"=====1=====");
        return 1;

    } else if (tLetterMatchCount == password.length) {
        //全部符合英文，表示沒有数字
        NSLog(@"=====2=====");
        return 2;

    } else if (tNumMatchCount + tLetterMatchCount == password.length) {
        //符合英文和符合数字条件的相加等于密码长度
        NSLog(@"=====3=====");
        return 3;

    } else {
        NSLog(@"=====4=====");
        return 4;

        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误

    }

    

}

- (void)switchTest:(int)b{
    switch (b) {
        case 1:
            printf("\n向上");
            break;
        case 2:
            printf("\n向下");
            break;
        case 3:
            printf("\n向左");
            break;
        default:
            printf("\n原地不动");
//            break;
    }
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
