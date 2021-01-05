//
//  AppDelegate.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/7/16.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "AppDelegate.h"
#import "NavView_VC.h"
#import "BaseDB.h"
#import "Login_VC.h"
#import "IQKeyboardManager.h"
#import "Mine_VC.h"
#import "TabBar_VC.h"


@interface AppDelegate (){
    TabBar_VC *tabBar;
}

@property (nonatomic,strong) Login_VC *loginVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseRootVC) name:CHOOSEROOTVC object:nil];
    
    [DCURLRouter loadConfigDictFromPlist:@"DCURLRouter.plist"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self createRooVC];

    [self chooseRootVC];
    
    [self.window makeKeyAndVisible];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // 正在使用应用的时候按“home”键，恢复系统的亮度
    [[NSNotificationCenter defaultCenter] removeObserver:CHOOSEROOTVC];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // 终止APP的时候 恢复记录的亮度（双击“home”键之后，强制杀死程序）
    [[NSNotificationCenter defaultCenter] removeObserver:CHOOSEROOTVC];
}

-(void)createRooVC
{
    
    tabBar = [[TabBar_VC alloc] init];
    
}

-(void)chooseRootVC
{
    
    BOOL flag = [[NSUserDefaults standardUserDefaults]boolForKey:@"firstIn"];
    
    if (flag == YES) {
        self.window.rootViewController = tabBar;
        [tabBar setSelectedIndex:0];
    } else {
        NavView_VC *nav = [[NavView_VC alloc] initWithRootViewController:self.loginVC];
        self.window.rootViewController = nav;
    }
    
}





-(Login_VC *)loginVC{
    
    
    if (!_loginVC) {
        _loginVC = [[Login_VC alloc]init];
        __weak typeof(self) weakSelf = self;
            
        //登录页的回调
        _loginVC.chooseRootVCBack = ^(){
            [weakSelf chooseRootVC];
        };
    }
    return _loginVC;
}




//#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
