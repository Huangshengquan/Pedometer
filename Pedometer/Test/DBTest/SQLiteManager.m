//
//  SQLiteManager.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/11/9.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "SQLiteManager.h"
#import <sqlite3.h>

@interface SQLiteManager()

@property (nonatomic,assign) sqlite3 *db;

@end

@implementation SQLiteManager

static SQLiteManager *instance;
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

//打开数据库，返回是布尔值
- (BOOL)openDB{
    //app内数据库文件存放路径-一般存放在沙盒中
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *DBPath = [documentPath stringByAppendingPathComponent:@"appDB.sqlite"];
    if (sqlite3_open(DBPath.UTF8String, &_db) != SQLITE_OK) {
        //数据库打开失败
        return NO;
    }else{
        //打开成功创建表
        //用户 表
        NSString *creatUserTable = @"CREATE TABLE IF NOT EXISTS 't_User' ( 'ID' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'name' TEXT,'score' INTEGER,'sex' TEXT);";
        //车 表
        NSString *creatCarTable = @"CREATE TABLE IF NOT EXISTS 't_Car' ('ID' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'type' TEXT,'output' REAL,'master' TEXT)";
        //项目中一般不会只有一个表
        NSArray *SQL_ARR = [NSArray arrayWithObjects:creatUserTable,creatCarTable, nil];
        return [self creatTableExecSQL:SQL_ARR];
    }
}

- (void)insertData{
    //插入数据时，确保数据不会出现重复数据
    [self deleteSQL:@"DELETE FROM t_User"];
    
//1.创建插入数据的sql语句
//===========插入单条数据=========
    const char *sql = "INSERT INTO t_Student(name,score,sex)VALUES ('小明',65,'男');";
//==========同时插入多条数据=======

    NSMutableString * mstr = [NSMutableString string];
    for (int i = 0; i < 50; i++) {
        NSString * name = [NSString stringWithFormat:@"name%d", i];
        CGFloat score = arc4random() % 101 * 1.0;
        NSString * sex = arc4random() % 2 == 0 ? @"男" : @"女";
        NSString * tsql = [NSString stringWithFormat:@"INSERT INTO t_User (name,score,sex) VALUES ('%@',%f,'%@');", name, score, sex];
        [mstr appendString:tsql];
    }

    //将OC字符串转换成C语言的字符串
    sql = mstr.UTF8String;

      //2.执行sql语句
   int ret = sqlite3_exec(_db, sql, NULL, NULL, NULL);
   //3.判断执行结果
   if (ret==SQLITE_OK) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败");
    }
    

}

//执行SQL语句，删除数据
- (void)deleteSQL:(NSString *)SQL{
    [self execuSQL:SQL];
}

-(BOOL)creatTableExecSQL:(NSArray *)SQL_ARR{
    for (NSString *SQL in SQL_ARR) {
        //参数一:数据库对象  参数二:需要执行的SQL语句  其余参数不需要处理
        if (![self execuSQL:SQL]) {
            return NO;
        }
    }
    return YES;
}

#pragma 执行SQL语句
- (BOOL)execuSQL:(NSString *)SQL{
    char *error;
    if (sqlite3_exec(self.db, SQL.UTF8String, nil, nil, &error) == SQLITE_OK) {
        return YES;
    }else{
        NSLog(@"SQLiteManager执行SQL语句出错:%s",error);
        return NO;
    }
}

#pragma mark - 查询数据库中数据
-(NSArray *)querySQL:(NSString *)SQL{
    //准备查询
    // 1> 参数一:数据库对象
    // 2> 参数二:查询语句
    // 3> 参数三:查询语句的长度:-1
    // 4> 参数四:句柄(游标对象)
    
    sqlite3_stmt *stmt = nil;
    if (sqlite3_prepare_v2(self.db, SQL.UTF8String, -1, &stmt, nil) != SQLITE_OK) {
        NSLog(@"准备查询失败!");
        return NULL;
    }
    //准备成功,开始查询数据
    //定义一个存放数据字典的可变数组
    NSMutableArray *dictArrM = [[NSMutableArray alloc] init];
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        //一共获取表中所有列数(字段数)
        int columnCount = sqlite3_column_count(stmt);
        //定义存放字段数据的字典
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < columnCount; i++) {
            // 取出i位置列的字段名,作为字典的键key
            const char *cKey = sqlite3_column_name(stmt, i);
            NSString *key = [NSString stringWithUTF8String:cKey];
            
            //取出i位置存储的值,作为字典的值value
            const char *cValue = (const char *)sqlite3_column_text(stmt, i);
            NSString *value = [NSString stringWithUTF8String:cValue];
            
            //将此行数据 中此字段中key和value包装成 字典
            [dict setObject:value forKey:key];
        }
        [dictArrM addObject:dict];
    }
    return dictArrM;
}

@end
