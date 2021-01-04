//
//  XCHttpRequest.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/25.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "XCHttpRequest.h"

@implementation XCHttpRequest

- (void)getAppUserFormAreaParams:(NSMutableDictionary *)params
                      Complation:(XCNetworkingBlock)complation{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic addEntriesFromDictionary:params];
    [self postUrl:@"" parameters:dic Complated:complation];
}


@end
