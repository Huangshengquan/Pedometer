//
//  BaseDB.h
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/30.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DB [BaseDB shareInstance]

NS_ASSUME_NONNULL_BEGIN

@interface BaseDB : NSObject

+ (instancetype)shareInstance;

///打开数据库  并 建表
- (void)openDB:(NSString *)sql tableName:(NSString *)tableName;

/// 增加数据
- (void)insertSQL:(NSString *)sql tableName:(NSString *)tableName;

/// 删除数据
- (void)deleteSQL:(NSString *)sql tableName:(NSString *)tableName;

/// 更新数据
- (void)updateSQL:(NSString *)sql tableName:(NSString *)tableName;

/// 查找数据
- (NSMutableDictionary *)checkSQL:(NSString *)SQL tableName:(NSString *)tableName;


@end

NS_ASSUME_NONNULL_END
