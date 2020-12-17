//
//  DBManager.h
//  Pedometer
//
//  Created by 黄盛全 on 2020/11/6.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBManager : NSObject{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;

-(BOOL)createDB;

-(BOOL) saveData:(NSString*)registerNumber name:(NSString*)name department:(NSString*)department year:(NSString*)year;

-(NSArray*) findByRegisterNumber:(NSString*)registerNumber;

@end

NS_ASSUME_NONNULL_END
