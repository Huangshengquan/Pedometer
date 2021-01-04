//
//  ViewController.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/7/16.
//  Copyright © 2020 黄盛全. All rights reserved.
//


#define JKSqliteCachePath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches"]

#import "ViewController.h"
#import "sqlite3.h"
#import "DBManager.h"
#import "SQLiteManager.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface ViewController ()<UITextFieldDelegate>{
    UITextField *inputField;
    UILabel *showLabel;
    UIButton *openBtn;
    UIButton *insertBtn;
    UIButton *selectBtn;
    
    UIButton *openBtn1;
    UIButton *insertBtn1;
    UIButton *selectBtn1;
    
    NSArray *dataArray;
    NSArray *dataArray1;
}

@property (strong, nonatomic) FMDatabase *db;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    
//    [self syncConcurrent];

//    [self asyncConcurrent];

//    [self syncSerial];

//    [self asyncSerial];

//    [self syncMain];

//    [self asyncMain];

//    [self communication];
    
    [self initView];
    
    

}

- (void)initView{
    
    inputField = [[UITextField alloc]initWithFrame:(CGRectMake(20, 90, 300, 30))];
    inputField.placeholder = @"请输入";
    inputField.delegate = self;
    [self.view addSubview:inputField];
    
    showLabel = [[UILabel alloc]initWithFrame:(CGRectMake(20, 130, 300, 30))];
    showLabel.text = @"初始值";
    [self.view addSubview:showLabel];
    
    openBtn = [[UIButton alloc]initWithFrame:(CGRectMake(20, 180, 100, 45))];
    [openBtn setTitle:@"打开数据库" forState:UIControlStateNormal];
    [openBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    openBtn.backgroundColor = UIColor.blueColor;
    openBtn.layer.masksToBounds = YES;
    openBtn.layer.cornerRadius = 3;
    [self.view addSubview:openBtn];
    [openBtn addTarget:self action:@selector(openAction) forControlEvents:UIControlEventTouchUpInside];
    
    insertBtn = [[UIButton alloc]initWithFrame:(CGRectMake(140, 180, 100, 45))];
    [insertBtn setTitle:@"插入数据" forState:UIControlStateNormal];
    [insertBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    insertBtn.backgroundColor = UIColor.blueColor;
    insertBtn.layer.masksToBounds = YES;
    insertBtn.layer.cornerRadius = 3;
    [self.view addSubview:insertBtn];
    [insertBtn addTarget:self action:@selector(insertAction) forControlEvents:UIControlEventTouchUpInside];
    
    selectBtn = [[UIButton alloc]initWithFrame:(CGRectMake(260, 180, 100, 45))];
    [selectBtn setTitle:@"查询数据" forState:UIControlStateNormal];
    [selectBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    selectBtn.backgroundColor = UIColor.blueColor;
    selectBtn.layer.masksToBounds = YES;
    selectBtn.layer.cornerRadius = 3;
    [self.view addSubview:selectBtn];
    [selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    
    openBtn1 = [[UIButton alloc]initWithFrame:(CGRectMake(20, 250, 100, 45))];
    [openBtn1 setTitle:@"建表" forState:UIControlStateNormal];
    [openBtn1 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    openBtn1.backgroundColor = UIColor.blueColor;
    openBtn1.layer.masksToBounds = YES;
    openBtn1.layer.cornerRadius = 3;
    [self.view addSubview:openBtn1];
    [openBtn1 addTarget:self action:@selector(openAction1) forControlEvents:UIControlEventTouchUpInside];
    
    insertBtn1 = [[UIButton alloc]initWithFrame:(CGRectMake(140, 250, 100, 45))];
    [insertBtn1 setTitle:@"插入数据" forState:UIControlStateNormal];
    [insertBtn1 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    insertBtn1.backgroundColor = UIColor.blueColor;
    insertBtn1.layer.masksToBounds = YES;
    insertBtn1.layer.cornerRadius = 3;
    [self.view addSubview:insertBtn1];
    [insertBtn1 addTarget:self action:@selector(insertAction1) forControlEvents:UIControlEventTouchUpInside];
    
    selectBtn1 = [[UIButton alloc]initWithFrame:(CGRectMake(260, 250, 100, 45))];
    [selectBtn1 setTitle:@"查询数据" forState:UIControlStateNormal];
    [selectBtn1 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    selectBtn1.backgroundColor = UIColor.blueColor;
    selectBtn1.layer.masksToBounds = YES;
    selectBtn1.layer.cornerRadius = 3;
    [self.view addSubview:selectBtn1];
    [selectBtn1 addTarget:self action:@selector(selectAction1) forControlEvents:UIControlEventTouchUpInside];
    
}

- (BOOL)existTable:(NSString *)sql{
    
    if (![self.db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    }
    
    
    
    FMResultSet *rs = [self.db executeQuery:sql];
    
    if ([rs next]) {
        NSInteger count = [rs intForColumn:@"countNum"];
        NSLog(@"The table count: %li", count);
        if (count == 1) {
            NSLog(@"存在");
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}

- (NSString *)databaseFilePath{
    
    NSArray *filePath
    = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    NSLog(@"%@",filePath);
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"db.sqlite"];
    return dbFilePath;
}

- (void)openAction1{
    
    //先判断数据库是否存在，如果不存在，创建数据库
//    if (!db) {
//        [self creatDatabase];
//    }
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (![self.db open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    //判断表中是否有指定的数据， 如果没有则无删除的必要，直接return
    if([self.db tableExists:@"t_Name"]){
        NSLog(@"数据库已存在");
        return;
    }else{
        @try {
            //为数据库设置缓存，提高查询效率
            [self.db setShouldCacheStatements:YES];

            [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS 't_Name' ( 'ID' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'name' TEXT,'score' INTEGER,'sex' TEXT);"];

            NSLog(@"创建完成");
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
    [self.db close];
         
}

- (void)deleteTable:(NSString *)sql{
     
    if (![self.db open]) {
        NSLog(@"数据库打开失败");
        return;
    }
     
    [self.db setShouldCacheStatements:YES];
    
    
    //判断表中是否有指定的数据， 如果没有则无删除的必要，直接return
    if(![self.db tableExists:@"t_Name"]){
        return;
    }else{
        [self.db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@;",sql]];
        NSLog(@"数据库表已删除");
    }


}

- (void)insertAction1{
    
    [self deleteTable:@"t_Name"];
    
    if (![self.db open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    
    [self.db setShouldCacheStatements:YES];
    
    if(![self.db tableExists:@"t_Name"]){
        return;
    }else{
        @try {
            
            for (int i = 0; i < 50; i++) {
                NSString * name = [NSString stringWithFormat:@"name%d", i];
                CGFloat score = arc4random() % 101 * 1.0;
                NSString * sex = arc4random() % 2 == 0 ? @"男" : @"女";
                NSString * tsql = [NSString stringWithFormat:@"INSERT INTO t_Name (name,score,sex) VALUES ('%@',%f,'%@');", name, score, sex];
                [self.db executeUpdate:tsql];
            }
            
            NSLog(@"数据插入成功");
            
        } @catch (NSException *exception) {

        } @finally {

        }
    }
        
    
    
}



- (void)selectAction1{
    
    if (![self.db open]) {
        NSLog(@"数据库打开失败");
        return ;
    }
     
    [self.db setShouldCacheStatements:YES];
    
    FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM t_Name;"];
    
    //准备成功,开始查询数据
    //定义一个存放数据字典的可变数组
    NSMutableArray *dictArrM = [[NSMutableArray alloc] init];
    
    //判断结果集中是否有数据，如果有则取出数据
    while ([rs next]) {
        
        NSDictionary *dict = [rs resultDictionary];

        [dictArrM addObject:dict];
        
    }
    
    NSLog(@"=====%@=====",dictArrM);
    NSLog(@"=====%lu=====",(unsigned long)dictArrM.count);
    
}



- (void)openAction{

    BOOL isSuccess = NO;

    isSuccess = [SQLiteManager shareInstance].openDB;

}

- (void)insertAction{

    [[SQLiteManager shareInstance] insertData];

}



- (void)selectAction{

    dataArray = [[SQLiteManager shareInstance] querySQL:@"SELECT name,score,sex FROM t_User;"];
    NSLog(@"=====%@=====",dataArray);
    NSLog(@"=====%lu=====",(unsigned long)dataArray.count);

}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    BOOL success = NO;

    success = [[DBManager getSharedInstance]saveData: textField.text name:textField.text department: textField.text year:textField.text];

    NSArray *data = [[DBManager getSharedInstance]findByRegisterNumber: @" "];

    if (data.count > 0) {
        inputField.text = @"初始值";
        showLabel.text = data[0];
    }
}


//- (void)testSqlite{
//
//    //获取数据库的名字
//    NSString *sqliteName = @"jk_common.sqlite";
//    if (sqliteName.length != 0) {
//
//         sqliteName = [NSString stringWithFormat:@"jk_%@.sqlite",@"userInfo"];
//    }
//
//    //对应的路径(我们把对一个的数据库放到了/Library/Caches下)
//    NSString *sqlitePath = [JKSqliteCachePath stringByAppendingPathComponent:sqliteName];
//
//    //打开数据库，不存在的情况下自动创建
//    sqlite3 *ppDb = nil;
//    if (sqlite3_open(sqlitePath.UTF8String, &ppDb) != SQLITE_OK) {
//         // 打开数据库失败
//         return;
//    }
//
//    // 关闭数据库
//    sqlite3_close(ppDb);
//
//    // 执行sql语句
//    /**
//       第1个参数：数据库对象
//       第2个参数：sql语句
//       第3个参数：查询时候用到的一个结果集闭包
//       第4个参数：用不到
//       第5个参数：用不到
//     */
//     BOOL result = sqlite3_exec(ppDb, sql.UTF8String, nil, nil, nil) == SQLITE_OK;
//
//}






/**
 * 同步执行 + 并发队列
 * 特点：在当前线程中执行任务，不会开启新线程，执行完一个任务，再执行下一个任务。
 */
- (void)syncConcurrent {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncConcurrent---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"syncConcurrent---end");
}

/**
* 异步执行 + 并发队列
* 特点：可以开启多个线程，任务交替（同时）执行。
*/
- (void)asyncConcurrent {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncConcurrent---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"asyncConcurrent---end");
}

/**
 * 同步执行 + 串行队列
 * 特点：不会开启新线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务。
 */
- (void)syncSerial {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncSerial---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"syncSerial---end");
}

/**
 * 异步执行 + 串行队列
 * 特点：会开启新线程，但是因为任务是串行的，执行完一个任务，再执行下一个任务。
 */
- (void)asyncSerial {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncSerial---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"asyncSerial---end");
}

/**
 * 同步执行 + 主队列
 * 特点(主线程调用)：互等卡主不执行。
 * 特点(其他线程调用)：不会开启新线程，执行完一个任务，再执行下一个任务。
 */
- (void)syncMain {
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncMain---begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"syncMain---end");
}

/**
 * 异步执行 + 主队列
 * 特点：只在主线程中执行任务，执行完一个任务，再执行下一个任务
 */
- (void)asyncMain {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncMain---begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"asyncMain---end");
}

/**
 * 线程间通信
 */
- (void)communication {
    // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        // 异步追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        
        // 回到主线程
        dispatch_async(mainQueue, ^{
            // 追加在主线程中执行的任务
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        });
    });
}






- (FMDatabase *)db{
    if (!_db) {
        _db = [[FMDatabase alloc]init];
        _db = [FMDatabase databaseWithPath:[self databaseFilePath]];
    }
    return _db;
}






@end
