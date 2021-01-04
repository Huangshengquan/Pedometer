//
//  BaseDB.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/30.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "BaseDB.h"
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface BaseDB ()

@property (strong, nonatomic) FMDatabase *db;

@end

@implementation BaseDB

static BaseDB *baseDB;
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseDB = [[self alloc] init];
    });
    return baseDB;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseDB = [super allocWithZone:zone];
    });
    return baseDB;
}


- (id)copyWithZone:(NSZone *)zone
{
    return baseDB;
}



//打开数据库
- (void)openDB:(NSString *)sql tableName:(NSString *)tableName
{
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (![self.db open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    //判断表中是否有指定的数据， 如果没有则无删除的必要，直接return
    if([self.db tableExists:tableName]){
        NSLog(@"数据库已存在");
        return;
    }else{
        @try {
            //为数据库设置缓存，提高查询效率
            [self.db setShouldCacheStatements:YES];

            [self.db executeUpdate:sql];

            NSLog(@"创建 %@ 完成",tableName);
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
    [self.db close];
}

/// 增加数据
- (void)insertSQL:(NSString *)sql tableName:(NSString *)tableName
{
    
    [self execuSQL:sql tableName:tableName];
    
}

/// 删除数据
- (void)deleteSQL:(NSString *)sql tableName:(NSString *)tableName
{
    
    [self execuSQL:sql tableName:tableName];
    
}

/// 更新数据
- (void)updateSQL:(NSString *)sql tableName:(NSString *)tableName
{
    [self execuSQL:sql tableName:tableName];
}

- (void)execuSQL:(NSString *)sql tableName:(NSString *)tableName
{
    if (![self.db open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    
    [self.db setShouldCacheStatements:YES];
    
    if(![self.db tableExists:tableName]){
        return;
    }else{
        @try {
            
            [self.db executeUpdate:sql];
                        
        } @catch (NSException *exception) {

        } @finally {

        }
    }
}
    
#pragma mark - 查询数据库中数据

/// 查找数据
- (NSMutableDictionary *)checkSQL:(NSString *)SQL tableName:(NSString *)tableName
{

    //准备查询
    // 1> 参数一:数据库对象
    // 2> 参数二:查询语句
    // 3> 参数三:查询语句的长度:-1
    // 4> 参数四:句柄(游标对象)
    
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    
    if (![self.db open]) {
        NSLog(@"数据库打开失败");
        return dataDic;
    }
     
    [self.db setShouldCacheStatements:YES];
    
    if(![self.db tableExists:tableName]){
        return dataDic;
    }else{
        
        @try {
            
            NSMutableArray *dictArray = [[NSMutableArray alloc] init];
            
            FMResultSet *rs = [self.db executeQuery:SQL];
            
            //判断结果集中是否有数据，如果有则取出数据
            while ([rs next]) {

                NSDictionary *dict = [rs resultDictionary];

                [dictArray addObject:dict];
                
            }
            
            [dataDic setValue:dictArray forKey:@"data"];
            
            [rs close];
                        
            return dataDic;
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        
    }

}


- (NSString *)databaseFilePath{
    
    NSArray *filePath
    = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    NSLog(@"%@",filePath);
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"db.sqlite"];
    return dbFilePath;
    
}

- (FMDatabase *)db{
    if (!_db) {
        _db = [[FMDatabase alloc]init];
        _db = [FMDatabase databaseWithPath:[self databaseFilePath]];
    }
    return _db;
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
