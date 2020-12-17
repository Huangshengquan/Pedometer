//
//  SQLiteManager.h
//  Pedometer
//
//  Created by 黄盛全 on 2020/11/9.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQLiteManager : NSObject

+ (instancetype)shareInstance;

//打开数据库
- (BOOL)openDB;

//执行SQL语句，返回成功或失败
- (BOOL)execuSQL:(NSString *)SQL;

//执行SQL语句，删除数据
- (void)deleteSQL:(NSString *)SQL;

//获取结果
- (NSArray *)querySQL:(NSString *)SQL;

- (void)insertData;

@end

NS_ASSUME_NONNULL_END
