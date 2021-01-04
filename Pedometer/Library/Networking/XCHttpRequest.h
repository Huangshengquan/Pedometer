//
//  XCHttpRequest.h
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/25.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "XCNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface XCHttpRequest : XCNetworking

- (void)getAppUserFormAreaParams:(NSMutableDictionary *)params
Complation:(XCNetworkingBlock)complation;

@end

NS_ASSUME_NONNULL_END
