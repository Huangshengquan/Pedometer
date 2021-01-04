//
//  UserInfoEntity.h
//  Pedometer
//
//  Created by 黄盛全 on 2021/1/4.
//  Copyright © 2021 黄盛全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoEntity : NSObject



@property (nonatomic, copy) NSString *userid;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *password;

+ (instancetype)entityWithDictionary:(NSDictionary *)dictionary;

- (instancetype)initWithDictionary:(NSDictionary* )dic;

@end

NS_ASSUME_NONNULL_END
