//
//  UserInfoEntity.m
//  Pedometer
//
//  Created by 黄盛全 on 2021/1/4.
//  Copyright © 2021 黄盛全. All rights reserved.
//

#import "UserInfoEntity.h"

@implementation UserInfoEntity

+ (instancetype)entityWithDictionary:(NSDictionary *)dictionary{
    UserInfoEntity * entity = [[UserInfoEntity alloc]init];
    [entity setValuesForKeysWithDictionary:dictionary];
    return entity;
}

- (instancetype)initWithDictionary:(NSDictionary*)dic {
    
    self=[super  init];
    if(self){
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
        NSLog(@"PickOrderModel未定义的Key------------>%@",key);
}

@end
